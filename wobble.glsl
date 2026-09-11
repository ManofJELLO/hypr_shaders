#version 320 es

precision highp float;

in  vec2 v_texcoord;
out vec4 fragColor;

uniform sampler2D tex;

// Keep jiggling for 0.6s after the window stops.
// @settle 0.6

uniform vec2  velocity;            // px/sec, live
uniform vec2  peak_velocity;       // fastest this gesture reached
uniform vec2  size_velocity;       // resize rate, px/sec
uniform vec2  peak_size_velocity;  // fastest resize rate this gesture
uniform float is_moving;
uniform float is_resizing;
uniform float settle;              // 0 -> 1 across the tail
uniform float time;                // seconds, for the oscillation
uniform vec2  surface_size;

// --- knobs -------------------------------------------------------------
// Measured: a full-width move peaks near 32000 px/s. At 11.0 this pinned the
// ceiling for every move, so the jiggle never varied with speed. 2.5 scales
// across the useful range and only saturates near the top end.
const float AMP_PER_KPX = 2.5;   // px of jiggle per 1000 px/s of motion
const float MAX_AMP_PX  = 55.0;  // ceiling, so a fast fling stays sane
const float LOBES       = 1.0;   // full sine periods across the window
const float FREQ_HZ     = 6.5;   // jiggle rate
const float DAMP        = 4.5;   // how fast the settle dies out
const float RECOIL      = 0.55;  // share of gesture energy the settle keeps
// Resize gain is separate from move gain on purpose: a drag-resize changes size
// far slower than a keybind move travels, so one constant cannot tune both.
// Measured on a real edge-drag: size changes at roughly 1000-1400 px/s after
// smoothing — about 20x slower than a keybind move travels. At a gain of 3 that
// produced ~2px of deformation, which is invisible. This is the number to turn
// if the resize effect is too weak or too strong; it is linear.
const float STRETCH_GAIN = 35.0;
// -----------------------------------------------------------------------

const float TAU = 6.28318530718;

void main() {
    vec2 px = max(surface_size, vec2(1.0));

    // Amplitude and direction come from different places depending on phase.
    // While moving, live velocity drives it. Once stopped there IS no velocity
    // — an eased move arrives at rest by construction — so the settle is seeded
    // from the peak of the gesture and decays.
    vec2 src     = is_moving   > 0.5 ? velocity      : peak_velocity;
    vec2 sizeSrc = is_resizing > 0.5 ? size_velocity : peak_size_velocity;

    // Cheap early-out only — each term computes its own scale below.
    float mag  = max(length(src), length(sizeSrc));
    float gate = min(mag * 0.001 * AMP_PER_KPX, MAX_AMP_PX);
    if (is_moving < 0.5 && is_resizing < 0.5)
        gate *= RECOIL * exp(-DAMP * settle);
    if (gate < 0.01 || mag < 1.0) {   // nothing to do; keep it cheap and exact
        fragColor = texture(tex, v_texcoord);
        return;
    }

    float t = time * FREQ_HZ * TAU;

    // ---- STRETCH (resize) -------------------------------------------------
    // Each edge moves at its own speed: the left edge at velocity.x, the right
    // at velocity.x + size_velocity.x. Content follows its nearest edge, so
    // across the window that displacement is linear — and the MEAN of it is the
    // window's centre velocity, which is the pure-translation part. Subtracting
    // it leaves this: zero at the centre, half the resize rate at each edge.
    // That is how a sheet of jelly stretches, and keeping the mean out is what
    // stops a resize reading as a slide.
    vec2 stretch = (v_texcoord - 0.5) * sizeSrc * 0.001 * STRETCH_GAIN;
    stretch = clamp(stretch, vec2(-MAX_AMP_PX), vec2(MAX_AMP_PX));
    if (is_moving < 0.5 && is_resizing < 0.5)
        stretch *= RECOIL * exp(-DAMP * settle);
    // Lag, then overshoot: the stretch trails the frame while it grows and
    // rebounds past it as it settles.
    stretch *= 0.6 + 0.4 * sin(t);

    // ---- RIPPLE (move) ----------------------------------------------------
    float mmag = length(src);
    vec2  disp = vec2(0.0);
    if (mmag > 1.0) {
        vec2  dir  = src / mmag;
        vec2  perp = vec2(-dir.y, dir.x);

        // Position along and across the direction of travel, centred on the
        // window so both span roughly -0.5..0.5.
        vec2  rel   = v_texcoord - 0.5;
        float along = dot(rel, dir);
        float acrs  = dot(rel, perp);

        // FULL sine periods across the surface, which is the whole point: a
        // full period integrates to zero, so the field has no mean and adds no
        // net translation. A field with a constant term is a TRANSLATION, which
        // is indistinguishable from the move already happening.
        //
        // Two waves: strips perpendicular to travel lag by different amounts
        // (the flag-ripple), plus a slower compression wave along it.
        float ripple = sin(acrs  * TAU * LOBES        + t);
        float squash = sin(along * TAU * LOBES * 1.7  - t * 1.4) * 0.6;

        // Displace along the direction of travel. Perpendicular gets a little
        // too, otherwise the deformation is purely 1-D and reads as shear.
        float ramp = min(mmag * 0.001 * AMP_PER_KPX, MAX_AMP_PX);
        if (is_moving < 0.5) ramp *= RECOIL * exp(-DAMP * settle);
        disp = dir * (ripple + squash) * ramp + perp * ripple * ramp * 0.25;
    }

    vec2 uv = v_texcoord - (disp + stretch) / px;

    fragColor = texture(tex, clamp(uv, vec2(0.0), vec2(1.0)));

    // Where content pulled away from the frame we would sample past the edge,
    // and clamp-to-edge smears that into a streak. Fade the vacated strip out
    // instead, so the silhouette appears to deform. A fragment shader cannot
    // draw outside the window's box, so this is the honest approximation.
    vec2  over    = max(-uv, uv - vec2(1.0));
    float outside = max(over.x, over.y) * max(px.x, px.y);
    fragColor *= 1.0 - smoothstep(0.0, 2.0, outside);
}

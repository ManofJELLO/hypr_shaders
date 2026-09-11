#version 320 es

precision highp float;

in  vec2 v_texcoord;
out vec4 fragColor;

uniform sampler2D tex;

// Long enough for two visible wobbles, short enough to still feel instant.
// @duration 0.42

uniform float progress;       // 0 -> 1 across the open
uniform vec2  surface_size;

const float TAU        = 6.28318530718;
const float LOBES      = 1.0;    // full sine periods across the panel
const float CYCLES     = 2.5;    // wobbles over the whole open
const float AMP_PX     = 22.0;   // peak sideways displacement
const float SCALE_FROM = 0.88;   // starts this fraction of full size

float easeOut(float x) { return 1.0 - pow(1.0 - x, 3.0); }

void main() {
    float p = clamp(progress, 0.0, 1.0);
    float e = easeOut(p);

    // Jelly settle. The amplitude decays to nothing by the end, so the panel
    // arrives still instead of being cut off mid-wobble.
    float decay  = (1.0 - p) * (1.0 - p);
    float ripple = sin(v_texcoord.y * TAU * LOBES + p * TAU * CYCLES) * decay;

    // A whole number of periods across the surface integrates to zero, so this
    // deforms the panel rather than sliding it. A displacement field with a
    // non-zero mean is just a translation, and a translation is invisible
    // against an opening panel that is already moving.
    vec2  texel = 1.0 / max(surface_size, vec2(1.0));
    float scale = mix(SCALE_FROM, 1.0, e);

    vec2 uv = (v_texcoord - 0.5) / scale + 0.5;
    uv.x   += ripple * AMP_PX * texel.x;

    // Outside the surface is nothing, not the clamped edge texel — otherwise
    // the wobble smears the border sideways instead of bending it.
    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
        fragColor = vec4(0.0);
        return;
    }

    // Premultiplied, so colour and alpha fade together.
    fragColor = texture(tex, uv) * e;
}

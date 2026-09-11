#version 320 es

precision highp float;

in  vec2 v_texcoord;
out vec4 fragColor;

uniform sampler2D tex;

// Slightly longer than the open — it reads as the panel letting go.
// @duration 0.34

uniform float progress;       // 0 -> 1 across the close
uniform float seed;           // stable per-surface, so two panels differ
uniform vec2  surface_size;

const float CELL_PX = 6.0;    // grain size of the dissolve, in pixels
const float LIFT_PX = 30.0;   // how far it drifts as it goes
const float EDGE    = 0.18;   // softness of the dissolve front

// Hash12 without trigonometry — same one reading_mode.glsl uses.
float hash(vec2 p) {
    vec3 q = fract(vec3(p.xyx) * 0.1031);
    q += dot(q, q.yzx + 33.33);
    return fract((q.x + q.y) * q.z);
}

void main() {
    float p = clamp(progress, 0.0, 1.0);

    vec2 texel = 1.0 / max(surface_size, vec2(1.0));
    vec2 uv    = v_texcoord + vec2(0.0, LIFT_PX * p) * texel;

    if (uv.y < 0.0 || uv.y > 1.0) {
        fragColor = vec4(0.0);
        return;
    }

    vec4 c = texture(tex, uv);

    // One threshold per cell, so the panel breaks into grains rather than
    // fading as a flat sheet. seed keeps two rofi surfaces out of lockstep.
    vec2  cell = floor(v_texcoord * surface_size / CELL_PX);
    float th   = hash(cell + vec2(seed * 91.7));

    // Front sweeps slightly top-first; EDGE widens it so cells near the front
    // fade out instead of popping.
    float sweep = p * 1.18 - v_texcoord.y * 0.10;
    float a     = 1.0 - smoothstep(th - EDGE, th + EDGE, sweep);

    fragColor = c * a;
}

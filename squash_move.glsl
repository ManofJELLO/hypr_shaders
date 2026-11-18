#version 320 es
// Source: community-umbriel-shaders animation/squash — MIT, © Noctalia.
// Adapted to the HyprWindowShade shader interface.
precision highp float;

in vec2 v_texcoord;
out vec4 fragColor;
uniform sampler2D tex;
uniform float progress;

#define umbriel_sample(uv) texture(tex, (uv))
#define umbriel_clamped_progress clamp(progress, 0.0, 1.0)

vec4 animation(vec2 uv) {
    float p = umbriel_clamped_progress;
    float pulse = 16.0 * p * p * (1.0 - p) * (1.0 - p);
    vec2 scale = vec2(1.0 - 0.02 * pulse, 1.0 - 0.045 * pulse);
    return umbriel_sample((uv - 0.5) / scale + 0.5);
}

void main() {
    fragColor = animation(v_texcoord);
}

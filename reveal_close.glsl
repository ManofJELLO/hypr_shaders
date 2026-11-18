#version 320 es
// Source: community-umbriel-shaders animation/reveal — MIT, © Noctalia.
// Adapted to the HyprWindowShade shader interface.
precision highp float;

in vec2 v_texcoord;
out vec4 fragColor;
uniform sampler2D tex;
uniform float progress;

#define umbriel_sample(uv) texture(tex, (uv))
#define umbriel_direction (-1.0)
#define umbriel_clamped_progress clamp(progress, 0.0, 1.0)

vec4 animation(vec2 uv) {
    float visible = umbriel_direction > 0.0
        ? umbriel_clamped_progress : 1.0 - umbriel_clamped_progress;
    float edge = mix(-0.02, 1.02, visible);
    float mask = 1.0 - smoothstep(edge - 0.02, edge + 0.02, uv.x);
    return umbriel_sample(uv) * mask;
}

void main() {
    fragColor = animation(v_texcoord);
}

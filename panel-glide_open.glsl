#version 320 es
// Source: community-umbriel-shaders animation/panel-glide — MIT, © Barrulus.
// Adapted to the HyprWindowShade shader interface.
// @duration 0.22  (Umbriel's own timing)
precision highp float;

in vec2 v_texcoord;
out vec4 fragColor;
uniform sampler2D tex;
uniform float progress;

#define umbriel_sample(uv) texture(tex, (uv))
#define umbriel_direction (1.0)
#define umbriel_clamped_progress clamp(progress, 0.0, 1.0)

// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Barrulus
vec4 animation(vec2 uv) {
    float t = umbriel_clamped_progress;
    float visible = umbriel_direction > 0.0 ? t : 1.0 - t;
    vec2 sampleUv = uv + vec2(0.0, 0.035 * (1.0 - visible));
    float inside = step(0.0, sampleUv.y) * step(sampleUv.y, 1.0);
    return umbriel_sample(sampleUv) * visible * inside;
}

void main() {
    fragColor = animation(v_texcoord);
}

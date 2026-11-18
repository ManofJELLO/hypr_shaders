#version 320 es
// Source: community-umbriel-shaders animation/hologram-boot — MIT, © Barrulus.
// Adapted to the HyprWindowShade shader interface.
precision highp float;

in vec2 v_texcoord;
out vec4 fragColor;
uniform sampler2D tex;
uniform vec2 surface_size;
uniform float progress;

#define umbriel_sample(uv) texture(tex, (uv))
#define umbriel_direction (1.0)
#define umbriel_size surface_size
#define umbriel_clamped_progress clamp(progress, 0.0, 1.0)

// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Barrulus
const float STRIP_HEIGHT_PX = 12.0;
vec4 animation(vec2 uv) {
    float t = umbriel_clamped_progress;
    float v = umbriel_direction > 0.0 ? t : 1.0 - t;
    if (v >= 1.0) return umbriel_sample(uv);
    if (v <= 0.0) return vec4(0.0);
    float band = floor(uv.y * umbriel_size.y / STRIP_HEIGHT_PX);
    float delay = fract(band * 0.61803399) * 0.55;
    float on = smoothstep(delay, delay + 0.45, v);
    float pulse = sin(3.14159265 * v);
    vec2 q = uv + vec2(sin(band * 7.0 + floor(v * 16.0)) * 32.0 * pulse / max(umbriel_size.x, 1.0), 0.0);
    vec4 c = umbriel_sample(q);
    float grey = dot(c.rgb, vec3(0.2126, 0.7152, 0.0722));
    vec3 holo = vec3(0.02, 0.9, 1.0) * (grey + c.a * 0.65);
    return vec4(mix(c.rgb, holo, pulse), c.a) * on;
}

void main() {
    fragColor = animation(v_texcoord);
}

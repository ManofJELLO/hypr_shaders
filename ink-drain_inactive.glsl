#version 320 es
// Source: community-umbriel-shaders animation/ink-drain — MIT, © Barrulus.
// Adapted to the HyprWindowShade shader interface.
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
const float INK_STRENGTH = 0.95;
vec4 animation(vec2 uv) {
    // Ink belongs only to the window losing focus.
    if (umbriel_direction >= 0.0) return umbriel_sample(uv);
    float t = umbriel_clamped_progress;
    if (t <= 0.0 || t >= 1.0) return umbriel_sample(uv);
    float pulse = sin(3.14159265 * t);
    float sweep = smoothstep(-0.2, 0.15, t * 1.6 - (uv.x * 0.65 + uv.y * 0.35));
    float ink = INK_STRENGTH * pulse * sweep;
    vec4 c = umbriel_sample(uv);
    float grey = dot(c.rgb, vec3(0.2126, 0.7152, 0.0722));
    return vec4(mix(c.rgb, vec3(grey * 0.12), ink), c.a);
}

void main() {
    fragColor = animation(v_texcoord);
}

#version 320 es
// Source: community-umbriel-shaders animation/focus-desaturation — MIT, © Barrulus.
// Adapted to the HyprWindowShade shader interface.
precision highp float;

in vec2 v_texcoord;
out vec4 fragColor;
uniform sampler2D tex;
uniform float progress;

#define umbriel_sample(uv) texture(tex, (uv))
#define umbriel_clamped_progress clamp(progress, 0.0, 1.0)

// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Barrulus
vec4 animation(vec2 uv) {
    vec4 c = umbriel_sample(uv);
    float pulse = 0.30 * sin(3.14159265 * umbriel_clamped_progress);
    float grey = dot(c.rgb, vec3(0.2126, 0.7152, 0.0722));
    return vec4(mix(c.rgb, vec3(grey), pulse), c.a);
}

void main() {
    fragColor = animation(v_texcoord);
}

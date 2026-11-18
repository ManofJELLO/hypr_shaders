#version 320 es
// Source: community-umbriel-shaders window/scanlines — MIT, © Noctalia.
// Adapted to the HyprWindowShade shader interface.
precision highp float;

in vec2 v_texcoord;
out vec4 fragColor;
uniform sampler2D tex;
uniform vec2 surface_size;

#define umbriel_sample(uv) texture(tex, (uv))
#define umbriel_size surface_size

vec4 window(vec2 uv) {
    vec4 c = umbriel_sample(uv);
    float line = mod(floor(uv.y * umbriel_size.y), 3.0) == 0.0 ? 0.85 : 1.0;
    return vec4(c.rgb * line, c.a);
}

void main() {
    fragColor = window(v_texcoord);
}

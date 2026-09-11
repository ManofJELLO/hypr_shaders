#version 320 es

precision highp float;

in  vec2 v_texcoord;
out vec4 fragColor;

uniform sampler2D tex;

// One-shots ride no compositor animation, so the shader declares its own length.
// @duration 0.35

uniform float progress;    // 0 -> 1 across the pulse
uniform float anim_kind;   // 4 urgent, 5 focus, 6 unfocus

const float PI = 3.14159265;

void main() {
    fragColor = texture(tex, v_texcoord);

    // Half-sine envelope: rises and falls, ending exactly where it started, so
    // the window lands back on its normal appearance with no step.
    float e = sin(clamp(progress, 0.0, 1.0) * PI);

    if (anim_kind > 5.5) {
        fragColor.rgb *= 1.0 - 0.30 * e;                 // unfocus: dip
    } else if (anim_kind > 4.5) {
        fragColor.rgb *= 1.0 + 0.45 * e;                 // focus: lift
    } else {
        // urgent: wash toward red. Colours are premultiplied, so the target is
        // scaled by alpha — otherwise the wrapper clamps it back and the flash
        // reads as a grey smear on transparent edges.
        fragColor.rgb = mix(fragColor.rgb, vec3(fragColor.a, 0.0, 0.0), 0.55 * e);
    }
}

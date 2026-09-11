Can be used with  
https://github.com/ManofJELLO/HyprWindowShade  
or  
https://github.com/loqusion/hyprshade  
place them in you ~/.config/hypr/shaders location  

## Screen shaders

These only need `tex` and `time`, so they work with either loader.

- **chromaGlitch.glsl** — occasional RGB channel tearing on a random interval.  
- **pixelate.glsl** — pixelation with a sharpening pass, gamma and vignette.  
- **wireframe.glsl** — edge detection, everything but the outlines dropped.  

## Window animation shaders

These are driven per window and read uniforms that HyprWindowShade provides —
`progress`, `velocity`, `surface_size`, `seed`, and the `@duration` / `@settle`
directives in the comments. hyprshade only supplies `time`, so these need the
plugin.

- **wobble.glsl** — jelly deformation while a window is moved or resized, jiggling for 0.6s after it stops. Amplitude follows the gesture speed.  
- **pulse.glsl** — one-shot flash on focus, unfocus and urgent. Lift, dip and a red wash.  
- **rofi_open.glsl** — panel scales up with a decaying sideways wobble.  
- **rofi_close.glsl** — panel drifts up and dissolves into grains.  

All this was inspired by:  
https://www.reddit.com/r/unixporn/comments/1qrb0v3/oc_i_made_a_glsl_shaderbased_reading_mode_that/  
Very cool and much more functional shader for nice eink vibe.

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
## Window shaders (ported from Umbriel)

Permanent effects over the window content. They need `tex`, plus `time` when animated.

| File | What it does |
|---|---|
| `adaptive-text-v4.glsl` | An experimental content-adaptive contrast treatment. |
| `autumn-leaves.glsl` | Animated autumn leaves over window content. |
| `beach-surf-overlay.glsl` | The inner-window half of the beach-surf border effect; keeps inward decoration visible. |
| `cartoon-chase-overlay.glsl` | The inner-window half of the cartoon-chase border effect; keeps inward decoration visible. |
| `crt.glsl` | A CRT-style treatment of the window image. |
| `dappled-light.glsl` | Faint leaf shadows sway across window content, with soft warm light filtering through the gaps. |
| `diya-glow-overlay.glsl` | The inward half of the Diya Lights border: small terracotta lamps and multicoloured sparkling lights, plus their soft glow. |
| `faerie-magic-overlay.glsl` | The inner-window half of the faerie-magic border effect; keeps inward decoration visible. |
| `fire-tendrils.glsl` | Moving fire tendrils over the window. |
| `firelit-clouds.glsl` | Gentle cloud banks billow across the window. |
| `flap-board.glsl` | Rectangular flaps turn in travelling waves, revealing inverted live content. |
| `flowering-vine-overlay.glsl` | The inner-window half of the flowering-vine border effect; keeps inward decoration visible. |
| `fractal-flow-overlay.glsl` | The inward half of Fractal Flow, sharing its coordinates, colours and clock. |
| `fractal-veil.glsl` | Small kaleidoscopic rosettes fill the window with fine moving detail. |
| `ghostly-tear-overlay.glsl` | Shallow pearl, mint and lavender wisps curl into the window from its edges. |
| `haunted-glass.glsl` | Three hooked talons press against the inside of the pane, denting the window content around their tips. |
| `liquid-glass.glsl` | Diffused content with a refractive bevel and soft reflection. |
| `mercury-sheen.glsl` | Flowing liquid-metal highlights give the content a chrome sheen. |
| `neon-bleed-overlay.glsl` | The inner-window half of the neon-bleed border effect; keeps inward decoration visible. |
| `painted-glass.glsl` | Layered violet pigment, diagonal hatching and scattered cyan facets sit along window edges. |
| `paper-content.glsl` | Neutral white crumpled stationery, with static fibres and folds behind the content. |
| `paper-overlay.glsl` | The inner-window half of the paper border effect; keeps inward decoration visible. |
| `parchment-dark.glsl` | A dark parchment treatment of window content. |
| `parchment.glsl` | A parchment treatment of window content. |
| `pink-purple-clouds.glsl` | Slow curling pink and purple billows over window content. |
| `pink-ribbon-overlay.glsl` | The inner-window half of the pink-ribbon border effect; keeps inward decoration visible. |
| `portal-lava-overlay.glsl` | The inner-window half of the portal-lava border effect; keeps inward decoration visible. |
| `prairie-wind.glsl` | An animated prairie-wind treatment of the window image. |
| `rainbow-overlay.glsl` | The inner-window half of the rainbow border effect; keeps inward decoration visible. |
| `rainbow-radial.glsl` | A radial rainbow treatment of the window image. |
| `rainbow-smoke.glsl` | Flowing rainbow smoke over window content. |
| `rainbow-waves.glsl` | Animated rainbow waves over window content. |
| `rainfall.glsl` | Rain falling over the window image. |
| `rgb-border.glsl` | An RGB-coloured edge treatment inside the window content. |
| `rgb-shimmer.glsl` | A shifting RGB shimmer across the window. |
| `ripple-drops.glsl` | Animated drop ripples distort the window image. |
| `rolling-clouds.glsl` | Rolling clouds over window content. |
| `rorschach2.glsl` | An animated inkblot-like treatment of the window image. |
| `scanlines.glsl` | Subtle horizontal scanlines over window content. |
| `sentient-circuit-v2.glsl` | Growing, pulsing, and decaying circuit colonies in copper and pollen tones. |
| `sentient-circuit.glsl` | Etched circuit buses, independent junctions, and light-reactive pulses. |
| `snowfall.glsl` | Snow falling over window content. |
| `somethings-watching-overlay.glsl` | The inward portion of the Pumpkin Parade border: twisting vines, growing jack-o’-lanterns, blinking cat eyes and marching skeletons. |

## Border shaders (ported from Umbriel)

These paint the ring that surrounds the window, so they need a plugin that
draws the border as a canvas instead of a fixed line — see
[HyprWindowShade#9](https://github.com/ManofJELLO/HyprWindowShade/pull/9).
Without that support they cannot run here.

| File | Band | Inner half |
|---|---|---|
| `border/accent-pulse.glsl` | 6px | — |
| `border/arcane-hextech-filament.glsl` | 6px | — |
| `border/beach-surf.glsl` | 6px | `beach-surf-overlay.glsl` |
| `border/cartoon-chase.glsl` | 6px | `cartoon-chase-overlay.glsl` |
| `border/diya-lights.glsl` | 6px | `diya-glow-overlay.glsl` |
| `border/dual-orbit.glsl` | 3px | — |
| `border/faerie-magic.glsl` | 6px | `faerie-magic-overlay.glsl` |
| `border/flowering-vine.glsl` | 6px | `flowering-vine-overlay.glsl` |
| `border/flowing-water.glsl` | 6px | — |
| `border/fractal-flow.glsl` | 6px | `fractal-flow-overlay.glsl` |
| `border/fuse.glsl` | 12px | — |
| `border/ghostly-tear-border.glsl` | 6px | `ghostly-tear-overlay.glsl` |
| `border/heartbeat.glsl` | 6px | — |
| `border/lightning.glsl` | 11px | — |
| `border/neon-bleed.glsl` | 6px | `neon-bleed-overlay.glsl` |
| `border/paper.glsl` | 6px | `paper-overlay.glsl` |
| `border/pink-ribbon.glsl` | 6px | `pink-ribbon-overlay.glsl` |
| `border/portal-lava.glsl` | 12px | `portal-lava-overlay.glsl` |
| `border/pulse.glsl` | 6px | — |
| `border/rainbow.glsl` | 3px | `rainbow-overlay.glsl` |
| `border/sentient-runner.glsl` | 6px | — |
| `border/sentient-spark.glsl` | 6px | — |
| `border/somethings-watching.glsl` | 6px | `somethings-watching-overlay.glsl` |

The band is how wide the ring the effect paints is (`// @border` in the
file's comments): the plugin applies it to `general:border_size` when the
effect is applied and restores your value when it is removed. `// @padding`
grows the canvas without touching the layout, and `// @speed` matches
Umbriel's own time scaling.

Thirteen of them ship an inner half in the repository root: the
`-overlay` file of the same name paints the same effect over the window's
content, and the two travel together when the focus moves. Those overlays
declare the theme palette uniforms so the inside and the rim paint with the
same colours; the plugin reads that palette from
`~/.config/hypr/shaders/umbriel/palette.txt` (four lines of `r g b a`), so a
theme tool can rewrite it live.

## Open, close and motion animations (ported from Umbriel)

One-shot animations driven by `progress`. Every `_close` reaches alpha 0 at
`progress == 1`; `_move` follows the gesture and `_inactive` the focus state.

| File | What it does |
|---|---|
| `accordion-slam_close.glsl` | Layer surfaces unfold in compressed bands behind a hot orange leading edge. |
| `accordion-slam_open.glsl` | Layer surfaces unfold in compressed bands behind a hot orange leading edge. |
| `afterimage_move.glsl` | Three cyan-green spatial echoes and a fading brass clock seal resolve as a window settles. |
| `beach-surf-animation_close.glsl` | A water-and-foam window reveal and disappearance. |
| `beach-surf-animation_open.glsl` | A water-and-foam window reveal and disappearance. |
| `blood-in_open.glsl` | Wave of blood reveals the window top to bottom. |
| `blood-out_close.glsl` | Drains out the bottom with same wave as Blood In. |
| `candle-snuff_close.glsl` | A quick dim and fade with a small orange-to-green edge flicker, confined to the departing window. |
| `cells_close.glsl` | Opening traces glowing pentagonal lines outward from the centre, fills the cells with the window, then withdraws the lines from the perimeter back to the centre. |
| `cells_open.glsl` | Opening traces glowing pentagonal lines outward from the centre, fills the cells with the window, then withdraws the lines from the perimeter back to the centre. |
| `cloud-puff_close.glsl` | A quick, outward-billowing cloud puff for window opening and closing. |
| `cloud-puff_open.glsl` | A quick, outward-billowing cloud puff for window opening and closing. |
| `crescent-reveal_open.glsl` | Pumpkin fire ignites at the bottom-left and burns the window into existence toward the top-right. |
| `crystal-assembly_open.glsl` | Staggered crystal cells travel into place, with cyan and brass seams that vanish as the window assembles. |
| `flame-grilled_close.glsl` | Opening sweeps tall, rolling flames downward and leaves the window behind. |
| `flame-grilled_open.glsl` | Opening sweeps tall, rolling flames downward and leaves the window behind. |
| `focus-desaturation_inactive.glsl` | A brief loss of colour during focus changes, with 20% native unfocused dimming. |
| `fractal-bloom_close.glsl` | Windows appear and disappear through a mirrored kaleidoscope mandala. |
| `fractal-bloom_open.glsl` | Windows appear and disappear through a mirrored kaleidoscope mandala. |
| `ghostly-tear-wave_close.glsl` | Opening begins along an uneven horizontal line near the window's centre. |
| `ghostly-tear-wave_open.glsl` | Opening begins along an uneven horizontal line near the window's centre. |
| `glitch_close.glsl` | Opening vibrates the window into existence through displaced digital bands, staggered blocks, and RGB separation. |
| `glitch_open.glsl` | Opening vibrates the window into existence through displaced digital bands, staggered blocks, and RGB separation. |
| `hologram-boot_close.glsl` | Layer surfaces boot in staggered cyan strips with horizontal glitch offsets. |
| `hologram-boot_open.glsl` | Layer surfaces boot in staggered cyan strips with horizontal glitch offsets. |
| `ink-drain_inactive.glsl` | A dark desaturating diagonal sweep affects only the window losing focus. |
| `ink-fade_inactive.glsl` | A brush-textured cool desaturation briefly passes across the window losing focus. |
| `kzzzt-close_close.glsl` | Closing overdrives the window's own colours into phosphor and tears it into bands, then blows it out like a fuse, with one overexposed pop and a short fading afterglow of its brightest pixels. |
| `kzzzt-open_open.glsl` | Opening strikes the window into being with one overexposed, torn frame, then it stutters in through displaced bands and phosphor bloom while circuit traces flare at its edges and settle. |
| `magic_close.glsl` | Opening reveals the window from a violet puff surrounded by drifting golden four-point sparkles. |
| `magic_open.glsl` | Opening reveals the window from a violet puff surrounded by drifting golden four-point sparkles. |
| `old-tv_close.glsl` | Closing collapses the picture into a horizontal phosphor line, then a brighter central blink that lingers before winking out. |
| `old-tv_open.glsl` | Closing collapses the picture into a horizontal phosphor line, then a brighter central blink that lingers before winking out. |
| `paint-burst_close.glsl` | A closing window breaks into diagonal dry-brush pigment islands with magenta and cyan edges. |
| `panel-glide_close.glsl` | A short vertical glide and fade for layer-shell surfaces as they appear or disappear. |
| `panel-glide_open.glsl` | A short vertical glide and fade for layer-shell surfaces as they appear or disappear. |
| `panel-slide_close.glsl` | Panels slide behind a crisp brass reveal bar punctuated by cyan teeth. |
| `panel-slide_open.glsl` | Panels slide behind a crisp brass reveal bar punctuated by cyan teeth. |
| `paper-animation_close.glsl` | A sheet falls and unfurls on opening, then scrunches and falls away on closing. |
| `paper-animation_open.glsl` | A sheet falls and unfurls on opening, then scrunches and falls away on closing. |
| `petal-gather_open.glsl` | A curling breeze of cream, pink and lilac petals gathers along the edge of an appearing window. |
| `petal-scatter_close.glsl` | A gust peels petals away from a receding window edge and carries them through the cleared space. |
| `reveal_close.glsl` | A bundled opening and closing reveal animation. |
| `reveal_open.glsl` | A bundled opening and closing reveal animation. |
| `shattered-glass_close.glsl` | Opening reassembles an irregular fracture map. |
| `shattered-glass_open.glsl` | Opening reassembles an irregular fracture map. |
| `signal-break_inactive.glsl` | The window losing focus fractures into coarse pixels, displaced strips and split colour; the incoming window stays clear. |
| `sky-manipulation_close.glsl` | A bowed, rippling fold of space sweeps across the window, swallowing it on close and unfolding it on open, with a chromatic crease and glowing strain lines. |
| `sky-manipulation_open.glsl` | A bowed, rippling fold of space sweeps across the window, swallowing it on close and unfolding it on open, with a chromatic crease and glowing strain lines. |
| `spooky-move_move.glsl` | Slow, deeply stretching window movement with a lingering ghostly sway, adapted from Wobbly Move. |
| `squash_move.glsl` | A bundled squash deformation for window movement. |
| `triangle-flaps_close.glsl` | Equilateral triangles point alternately up and down. |
| `triangle-flaps_open.glsl` | Equilateral triangles point alternately up and down. |
| `vhs_close.glsl` | Opening introduces the window through horizontal tape stretch, rolling tracking errors, scanlines, noise, and colour bleed. |
| `vhs_open.glsl` | Opening introduces the window through horizontal tape stretch, rolling tracking errors, scanlines, noise, and colour bleed. |
| `void_close.glsl` | Opening grows a broad violet vortex around a black core and releases the twisting window. |
| `void_open.glsl` | Opening grows a broad violet vortex around a black core and releases the twisting window. |
| `water-conjure_close.glsl` | A drop lands, a water column rises, and a foamy frame fills inward; closing reverses into a puddle. |
| `water-conjure_open.glsl` | A drop lands, a water column rises, and a foamy frame fills inward; closing reverses into a puddle. |
| `water-splash_close.glsl` | A water-drop impact seen from above, intended for closing windows. |
| `wet-paint_close.glsl` | Opening pours long, uneven paint streams down the window. |
| `wet-paint_open.glsl` | Opening pours long, uneven paint streams down the window. |
| `wobbly-lifecycle_close.glsl` | Elastic-sheet deformation for opening and closing windows. |
| `wobbly-lifecycle_open.glsl` | Elastic-sheet deformation for opening and closing windows. |
| `wobbly-move_move.glsl` | Elastic deformation during animated moves, resizes, and layout changes. |

---

These shaders are adapted from the
[community Umbriel collection](https://github.com/noctalia-dev/community-umbriel-shaders)
at commit `5f19b06`. Umbriel uses its own effect API, so each file was ported to
the interface this plugin expects: `#version 320 es`, `v_texcoord`, `fragColor`,
`tex`, and the plugin's own uniforms. `umbriel_sample(uv)` became
`texture(tex, uv)`; `umbriel_size`, `umbriel_time` and `umbriel_linear_progress`
became `surface_size`, `time` and `progress`; `umbriel_direction` is baked into
each file as `+1` for `_open` and `-1` for `_close`. There is no theme palette
or audio on this side, so palette-driven shaders fall back to their own colours
and the audio ones were left out. See `CREDITS.md` for authors, and `LICENSES/`
for the MIT notices.

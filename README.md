# 🎵🧮 yt-breenogm: Music Meets Math in Motion

**yt-breenogm** is a personal MATLAB-based project that blends mathematical patterns and musical theory through visual and sonic animations.  
Each video is generated from simulations of dynamic systems (often polar or circular), where colored balls follow rhythmic paths and trigger musical notes based on their motion.

---

## 🔍 Project Overview

This repository contains the complete source code for generating **music-mathematical animations** using MATLAB.  
Animations are exported via `VideoWriter` and sounds are generated using custom audio synthesis functions.

> The project is showcased on YouTube: [**breenogm**](https://www.youtube.com/@breenogm)

---

## 📁 Repository Structure

```
📂 yt-breenogm/
├── *.m                  # Main animation scripts, test scripts, utility, etc.
├── functions/           # Authorial utility functions (see list below)
├── media/               # Watermarks, sound samples, auxiliary assets
└── never used/          # Experimental or discarded sketches
```

---

## ⚙️ Audio Utility Script

### `utility.m`

This helper script automates audio generation after the animation has run.

- Loads precomputed arrays (`soundfms.mat` and `panfms.mat`)
- Uses `genArray` and `genAudio` to create synchronized stereo `.wav` files
- Example setup:

```matlab
fpath = "../media/pendulumSons/pendulum";
apath = "../media/pendulumSons/composites/";
```

> Useful for generating audio independently of the animation itself.

---

## ▶️ How to Run

1. Open any of the main `.m` animation scripts (e.g. `pendulumWave.m`, etc.)
2. Make sure you have MATLAB with **Audio Toolbox** installed
3. Set `video = 's'` in the script to enable `.mp4` export via `VideoWriter`
4. Run the animation:
   - During execution, the simulation generates:
     - A **frame array** for each object (e.g. `somArray`), indicating exactly which frames trigger notes
     - A **panning array** defining stereo position (left ↔ right) per object over time
5. After the animation, use:
   - `genArray` to structure these frame and pan arrays with corresponding sound files
   - `genAudio` or `genAudioMulti` to render final stereo `.wav` files
6. (Optional) Combine video and audio manually using external software (e.g. ffmpeg, a video editor, or DAW)

---

## 🎚️ Frame and Pan Arrays

The animation and sound are **decoupled** by design:

- **Frame Arrays** (e.g. `somArray`) track **when** each object “plays” based on its movement
- **Pan Arrays** (e.g. `panfms`) define how sound **moves in stereo** (left ↔ right)

These are used as input for `genArray`, which feeds `genAudio` to produce fully synchronized stereo soundtracks.

---

## 🔧 Notable Custom Functions (`functions/`)

| Function           | Description |
|--------------------|-------------|
| `ballinside`       | Handles collision and reflection of a ball inside a circular boundary. |
| `ballinsidecheck`  | Detects if a ball is touching the inner circular boundary. |
| `balloutsidecheck` | Detects if a ball is touching the outer circular boundary. |
| `blkbgm`           | Applies a fade-in or color transition effect using a timer. |
| `blkbgmfm`         | Simplified version of `blkbgm`, with fixed number of frames. |
| `ccd`              | Calculates the intersection point with a square boundary. |
| `circlebgm`        | Draws a circular patch with customizable styling. |
| `cv`               | Closes a `VideoWriter` object. |
| `endsec`           | Appends extra seconds of still frame to the end of a video. |
| `eudist`           | Computes 2D Euclidean distance from origin to a point. |
| `fullcmap`         | Generates reversed color indices from a colormap. |
| `genArray`         | Prepares structured audio data using frame triggers, `.wav` files, and panning values. |
| `genAudio`         | Renders synchronized stereo `.wav` files (one per object) from structured data. |
| `genAudioMulti`    | Same as `genAudio`, but supports multiple sound files per object. |
| `gf`               | Captures and writes a frame to a video using `VideoWriter`. |
| `heartbgm`         | Draws a stylized heart shape using a parametric equation. |
| `linecmap`         | Creates interpolated-color line segments between moving objects. |
| `linesimple`       | Creates lines with fixed color (requires manual update). |
| `linestatic`       | Initializes all lines at [0,0] with constant color and width. |
| `patchcmap`        | Initializes a matrix of color-interpolated patch lines. |
| `revblkbgm`        | Reverses the effect of `blkbgm` using a default timer. |
| `rvsblkbgm`        | Reversible fade using user-defined timing and duration. |
| `scenebgm`         | Sets up the animation canvas, background, shape, resolution, and axis styling. |
| `sqcol`            | Handles square-boundary collisions and graphical updates for square-shaped objects. |
| `squarebgm`        | Draws a square using a patch with given size and style. |
| `stpen`            | Computes wrapped time-stepped index using modulo arithmetic. |
| `sv`               | Creates and opens a `VideoWriter` object (preset quality and FPS). |
| `uplinecmap`       | Updates a colored connecting line between two moving objects with dynamic blending. |
| `uplinesimple`     | Updates fixed-color lines between two objects, based on distance and visibility. |
| `uplinestatic`     | Draws a line between a moving object and a static reference point. |
| `uppatchcmap`      | Updates all interpolated patch lines from a source object to others. |
| `waterblack`       | Adds a black watermark overlay using a transparent PNG (position adjusted by layout). |
| `waterwhite`       | Adds a white watermark overlay (inverse of `waterblack`). |
| `zoom`             | Generates a stereo frequency sweep with 4-phase panning evolution, saved as `.wav`. |

> All file paths (e.g., for images or audio files) use `fullfile('..', 'media', ...)` for portability across OSes.

---

## 📜 License

This project is licensed under the **Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)**.  
You may share or adapt the code and media for non-commercial purposes, with attribution.

More info: [https://creativecommons.org/licenses/by-nc/4.0/](https://creativecommons.org/licenses/by-nc/4.0/)

---

## 🌐 Author & Contact

Made by **Breno Vargas Gemelgo (breenogm)**  
YouTube: [@breenogm](https://www.youtube.com/@breenogm)  
E-mail: brenogemelgo@gmail.com

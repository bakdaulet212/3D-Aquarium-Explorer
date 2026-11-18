# 3D Aquarium Explorer — Living Reef Edition

Interactive real-time underwater environment using C++17, OpenGL 3.3 Core and GLSL.

## Launch on Windows

1. Extract the entire ZIP archive.
2. Open `3D_Aquarium_Explorer`.
3. Double-click `START_WINDOWS.bat`.
4. The script detects Visual Studio Community 2026 or Visual Studio 2022 with C++ tools, configures the solution, builds Release and launches the application.

Requirements: MSVC C++ x64 tools, Windows SDK, CMake 3.21+, an OpenGL 3.3-compatible GPU driver. If the console shows an error, its window remains open. Keep the `shaders` directory beside the executable (the CMake build copies it automatically).

## Controls

| Input | Function |
|---|---|
| Left mouse drag / A-D / arrows | Orbit camera |
| W / S / mouse wheel | Zoom |
| 1 / 2 | Day / night |
| T | Automatic day-night cycle |
| F | Drop food; fish seek and eat the pellets |
| + / - (or numpad +/-) | Increase / decrease fish by 4 (8–64) |
| [ / ] | Simulation speed down / up (50–200%) |
| M | Toggle school behavior (alignment/cohesion) |
| C | Toggle caustic highlights on sand |
| L | Toggle light shafts |
| U | Toggle animated water surface |
| J | Toggle floating jellyfish |
| B | Toggle bubbles |
| , / . | Adjust direct light strength |
| Tab | Open/close settings panel |
| P | Photo mode: hide interface |
| Space | Pause / resume |
| H | Toggle control help |
| R | Reset environment and settings |
| Esc | Exit |

If `+` does not register on a particular keyboard, use the numpad plus key or the `=` key.

## Project structure

- `src/main.cpp` — mesh generation, procedural environment, fish steering, feeding, jellyfish, camera, render loop, HUD and tests
- `shaders/scene.vert` — model/view/projection, plant motion, wave displacement
- `shaders/scene.frag` — underwater fog, light, caustics, water transparency and rays
- `shaders/hud.vert` / `shaders/hud.frag` — overlay
- `vendor/glfw`, `vendor/glad`, `vendor/glm` — third-party source with respective license notices
- `CMakeLists.txt` — cross-platform project build and test configuration

## Validation

After building, run the test executable:

```powershell
.\build_vs2026\Release\AquariumExplorer.exe --self-test
```

Visual Studio 2022 uses `build_vs2022` instead. The built-in test validates mesh indices, scene construction, fish limits and boundaries, different school behavior, pellet consumption, light-cycle range and pause.

## Optional frame capture

The program can save a PPM framebuffer:

```powershell
.\build_vs2026\Release\AquariumExplorer.exe --frames 30 --capture aquarium.ppm
```

Additional options: `--night`, `--feed-demo`, `--fish 40`, `--hide-help`, `--photo`. Local Linux software-render tests use `--headless` with a surfaceless EGL implementation.

## Submission

Submit separately: PDF presentation, PDF report (including a public YouTube demonstration URL), and source ZIP. Host the source in a public GitHub repository and enter its URL in the teacher's table. The video and repository URLs must be actual published links, not placeholders.

This is an interactive graphics demonstration, not a real fluid simulation or biologically accurate fish model.

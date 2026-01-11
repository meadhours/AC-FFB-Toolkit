# Meka FFB Framework
A modular, object-oriented Lua framework for Assetto Corsa's Custom Shaders Patch (CSP) FFB scripting.

Most FFB scripts available for AC are monolithic (single file, thousands of lines), which makes them hard to read, debug, or extend. This project aims to solve that by applying standard software architecture principles—similar to embedded firmware design—separating signal processing, effect calculation, and logic.

## Architecture

The project is structured to keep the main loop clean. Each FFB effect (ABS, Road Noise, etc.) is its own independent module/class.

```text
Meka-FFB-Framework/
├── src/
│   ├── Core/           # Math helpers, signal smoothing, filters
│   ├── Effects/        # Individual effect modules (ABS, Road, Slip)
│   └── UI/             # Debugger implementation
├── main.lua            # Entry point & main loop
└── config.ini          # Content Manager configuration
Features
Modular Design: Adding or removing an effect is as simple as importing/removing a module. No more spaghetti code in the main update loop.

Visual Debugger: Includes a real-time UI monitor (using CSP ui API) to visualize force vectors and signal noise. Useful for tuning gain values.

Signal Processing: Implements basic filtering (smoothing) to handle raw physics data more naturally.

CM Integration: Fully configurable via the "FFB Tweaks" menu in Content Manager.

Installation
Download the latest release (or clone this repo).

Copy the folder into your AC directory: .../assettocorsa/extension/lua/ffb_hooks/

Open Content Manager -> Settings -> Custom Shaders Patch -> FFB Tweaks.

Select Meka FFB Framework as the active script.

Usage / Tuning
You can adjust gain and frequency values directly from Content Manager.

If you want to extend the script or add custom effects, check src/Effects/. Each module follows a simple structure:

new(): Constructor for parameters.

calculate(physics, dt): Returns the calculated force for the current frame.


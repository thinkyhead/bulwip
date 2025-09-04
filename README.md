# BuLWiP - a TI/99 4/A emulator in C w/SDL2

- Features 9918A video and 9919 sound chip emulation.
- Lower memory usage, less lookup tables, keep important data in cache
- Instruction opcode decoding using CLZ instead of a lookup table
- Memory is designated as 16-bit words as seen from the CPU; no need for builtin_bswap16
- Memory accesses use a function pointer per 256 bytes
- Instruction loop is in a single function; keeping PC, WP, (maybe ST) in host CPU registers
- Instruction decoding functions inlined; better branch prediction

## Requirements
- GCC or compatible compiler
- SDL2 library and headers
- ROM and GROM files: `994arom.bin`, `994agrom.bin`.
  - Put these in the same directory as the emulator executable for dynamic loading.
    - (If you want to have a ROM source listing, it should be named `994arom.lst`.)
  - Use `make cbulwip` for a build with the ROMs compiled in.

## Building BuLWiP
- Enter the project folder and run `make`.
- To build a macOS application bundle:
  - Place `994arom.bin` and `994agrom.bin` in the bulwip source folder.
  - Use `make app` to build the `.icns` and executable and bundle them with the ROM files.
  - Use `make capp` to build the app with the ROMs compiled into the binary.

## Keyboard usage
|Key(s)|Description|
|---|---|
|ESC|Load Cartridges/Settings/Quit menu|
|F11|Toggle full-screen|
|F12 or Ctrl-Home|Toggle debugger interface|
|Ctrl-F12|Reset and reload current cartridge/listings|
|Shift-Insert|Paste from clipboard|
|Arrow keys and Tab|Mapped to Joystick 1|

## Loading Cartridges
- Files ending in `G.BIN` are assumed to be GROM, otherwise ROM.
- ROM files must be non-inverted (first bank is 0) format.
- Listing file is loaded automatically and must be named the same as the ROM with a `.LST` extension.
- Cartridge files may be loaded by drag-and-drop onto the window.

## While debugger is open
|Key(s)|Description|
|---|---|
|F1|Run/Stop|
|F2|Single instruction step|
|Ctrl-F2|Single frame step|
|Up/Down/PgUp/PgDn|move highlighted line in listing|
|Home/End|Go to start/end of listing|
|Ctrl-F|Find text string|
|Ctrl-G|Repeat last find|
|Shift-Ctrl-G|Repeat last find, reverse direction|
|B|Toggle breakpoint at current line (red=stop, green=go)|
|Del|Remove breakpoint at current line|
|F5|List breakpoints<br/>- Enter: Go to selected breakpoint<br/>- Space: Toggle selected breakpoint<br/>- Del: Remove selected breakpoint|
|R|Register select, then Enter to jump to address|
|Z|Reverse instruction step|
|Shift-Z|Reverse instruction step until PC goes lower (good for rewinding out of a loop)|
|1/2/3/S|Show character pattern tables, or sprite pattern table|

### TODO
- Ctrl->B : Go to referenced label
- SAMS banking 1MB

# TODO
- F18A support (some bits work)
- FinalGROM99 cartridge emulation (paged 4Krom+4Kram, gram, load, dump)
- Memory view:
  - A: set address
  - M: CPU memory
  - V: VDP memory
  - G: GROM
  - S: SAMS

# Android?
- See [cnlohr/rawdrawandroid](https://github.com/cnlohr/rawdrawandroid)

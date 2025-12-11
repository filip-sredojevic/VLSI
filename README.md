# VLSI - Simulation, Synthesis and Verification

This project is a Verilog HDL design environment for building, simulating and synthesizing digital hardware for Altera/Intel FPGA development boards (Terasic DE0 with a Cyclone III device and DE0-CV with a Cyclone V device). The design sources are split into two trees: `src/simulation`, which holds the verification code, and `src/synthesis`, which holds the modules that are mapped onto the FPGA. Currently implemented and verified are a 4-bit combinational ALU (`alu.v`) supporting addition, subtraction, multiplication, division, complement, XOR, OR and AND selected by a 3-bit opcode, and a 4-bit multifunction `register` with asynchronous reset, clear, parallel load, increment, decrement and shift-right/shift-left with serial input. Both are exercised by the testbench in `src/simulation/top.v`, which sweeps the ALU over all opcode/operand combinations and drives the register with randomized control signals while logging results to the transcript and to a waveform file. The synthesis tree additionally contains a parameterized single-port `memory` module initialized from `tooling/mem_init.mif`, the board-level wrappers `DE0_TOP.v` / `DE0_CV_TOP.v`, and placeholder modules (CPU, VGA, PS/2, seven-segment display, BCD, debouncer, clock divider) reserved for the full system described in `specifikacija.pdf`. Everything is driven from a single makefile in `tooling/`, which wraps the whole ModelSim/Questa simulation flow and the complete Quartus flow (analysis & synthesis, place & route, assembly, static timing analysis and device programming) behind simple `make` targets.

## How to run

### Prerequisites

* **ModelSim ASE** (or **Questa SIM**) for simulation.
* **Quartus II** for synthesis and for programming the board.
* **make** - a minimal Windows toolset (`make`, `sh`, `cp`, `rm`, ...) is bundled in `tooling/xpack/bin`, so nothing extra has to be installed.

### Configuration

Before the first run, open `tooling/makefile` and adjust the variables at the top to your machine and board:

| Variable | Meaning |
| --- | --- |
| `SIMUL_TOOL_EXE_DIR_PATH` | Path to the ModelSim/Questa `win32aloem` / `win64` directory (must end with `\`). |
| `SIMUL_IS_QUESTA_USED` | `1` for Questa SIM, `0` for ModelSim. |
| `SIMUL_TOP_LEVEL_MODULE` | Top-level module of the testbench (default `top`). |
| `SYNTH_TOOL_EXE_DIR_PATH` | Path to the Quartus `bin` directory (must end with `\`). |
| `SYNTH_TOP_LEVEL_MODULE` | `DE0_TOP` for the DE0 board, `DE0_CV_TOP` for the DE0-CV board. |
| `SYNTH_DEVICE_FAMILY` | `CycloneIII` (DE0) or `CycloneV` (DE0-CV). |
| `SYNTH_DEVICE_PART` | `EP3C16F484C6` (DE0) or `5CEBA4F23C7` (DE0-CV). |

### Running

All commands are run from the `tooling` directory:

```sh
cd tooling
./xpack/bin/make help
```

`make help` prints the list of all available targets.

**Simulation**

```sh
./xpack/bin/make simul_all       # create the library, compile and simulate (shell mode)
./xpack/bin/make simul_run_gui   # run the simulation in the ModelSim/Questa GUI
./xpack/bin/make simul_wave_new  # run the simulation and open the resulting waveform
./xpack/bin/make simul_wave_old  # open the existing waveform without re-running
./xpack/bin/make simul_clean     # remove the work library, logs and waveforms
```

The compile log is written to `tooling/vlog_compile.log`, the simulation output to `tooling/transcript`, and the waveform to `tooling/waveform.wlf`.

**Synthesis and programming**

```sh
./xpack/bin/make synth_all       # analysis & synthesis, place & route, assembly and timing analysis
./xpack/bin/make synth_map       # analysis & synthesis only
./xpack/bin/make synth_fit       # place & route only
./xpack/bin/make synth_asm       # generate the .sof programming image
./xpack/bin/make synth_sta       # static timing analysis
./xpack/bin/make synth_pgm       # program the connected board over JTAG
./xpack/bin/make synth_clean     # remove all generated Quartus files
```

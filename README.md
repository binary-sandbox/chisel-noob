# chisel-noob

chisel-noob

## FOSS FPGA Synthesis, Place and Route, and Flashing Tools Installation

### Install Yosys Synthesis

Clone Yosys GitHub repository:

```bash
git clone https://github.com/YosysHQ/yosys.git
```

Install Dependencies:

```bash
sudo apt-get install build-essential clang bison flex libreadline-dev gawk tcl-dev libffi-dev git graphviz xdot pkg-config python3
```

Configure and compile with:

```bash
make config-clang
make config-gcc
make
```

Test and install:

```bash
make test
sudo make install
```

### Install IceStorm Tools

Install dependencies:

```bash
sudo apt install libftdi1-dev
```

Clone, build and install the IceStorm tools

```bash
git clone https://github.com/cliffordwolf/icestorm.git
make
sudo make install
```

### Install nextpnr Place and Route

Clone nextpnr GitHub repository:

```bash
git clone https://github.com/YosysHQ/nextpnr
```

Install Dependencies:

```bash
sudo apt install libboost-dev libboost-filesystem-dev libboost-thread-dev libboost-program-options-dev libboost-python-dev libboost-dev cmake
```

Build and install with:

```bash
mkdir build
cd build/
cmake -DARCH=ice40 ../
make -j$(nproc)
sudo make install
```

# Compile and Install of the Yosys Tool

This repository contains a **make** file for easy compile and install of [Yosys](https://yosyshq.net/yosys).
Yosys is a framework for Verilog RTL synthesis.

This **make** file can build the Yosys tool on the following systems:
* Linux
* Windows
    * [MSYS2](https://www.msys2.org)/mingw64
    * [MSYS2](https://www.msys2.org)/mingw32


# Get Source Code

## ed_yosys

```bash
git clone https://github.com/embed-dsp/ed_yosys.git
```

## Yosys

```bash
# Enter the ed_yosys directory.
cd ed_yosys
```

```bash
# If this is the first time Yosys is built, then clone the Yosys git repository.
make clone
```

```bash
# Otherwise just pull the latest updates from the Yosys git repository.
make pull
```

```bash
# Edit the Makefile for selecting the Yosys version.
vim Makefile
PACKAGE_VERSION = 0.25
```


# Build

```bash
# Checkout specific version and rebuild configure.
make prepare
```

```bash
# Configure source code.
make configure
```

```bash
# Compile source code using 4 simultaneous jobs (Default).
make compile
```

```bash
# Compile source code using 2 simultaneous jobs.
make compile J=2
```


# Install

## Linux

```bash
# Install build products.
sudo make install
```

The Yosys package does NOT install correctly according to the
[GNU Coding Standards](https://www.gnu.org/prep/standards/standards.html).
The build products are therefore installed in the following locations in order 
to allow separate installation for different architectures:

```bash
/opt/
└── yosys/
    ├── linux_x86_64/               # 64-bit binaries and libraries for Linux
    │   └── yosys-0.25/
    │       ├── bin/
    │       │   ├── yosys
    │       │       ...
    │       └── share/              # ...
    │           ├── yosys/
    │               ...
    └── linux_x86/                  # 32-bit binaries and libraries for Linux
        └── yosys-0.25/
            ├── bin/
            │   ├── yosys
            │       ...
            └── share/              # ...
                ├── yosys/
                    ...
            ...
```

## Windows: MSYS2/mingw64 & MSYS2/mingw32

```bash
# Install build products.
make install
```

The Yosys package does NOT install correctly according to the
[GNU Coding Standards](https://www.gnu.org/prep/standards/standards.html).
The build products are therefore installed in the following locations in order 
to allow separate installation for different architectures:

```bash
/c/opt/
└── yosys/
    ├── mingw64_x86_64/             # 64-bit binaries and libraries for Windows
    │   └── yosys-0.25/

    ├── mingw32_x86_64/             # 32-bit binaries and libraries for Windows
    │   └── yosys-0.25/
```


# Tested System Configurations

System  | M=                | M=32  
--------|-------------------|-------------------
linux   | Fedora-37 64-bit  | 
mingw64 | Windows-11 64-bit |
mingw32 | **FIXME**         |

This has been testes with the following Linux distributions and compilers:
* `Fedora-37 (64-bit)`
    * `gcc-12.2.1`

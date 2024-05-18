
# Copyright (c) 2023-2024 embed-dsp, All Rights Reserved.
# Author: Gudmundur Bogason <gb@embed-dsp.com>


PACKAGE_NAME = yosys

# Package version number (git master branch / git tag)
# PACKAGE_VERSION = master
PACKAGE_VERSION = 0.25

PACKAGE = $(PACKAGE_NAME)-$(PACKAGE_VERSION)

# ==============================================================================

# Determine system.
SYSTEM = unknown
ifeq ($(findstring Linux, $(shell uname -s)), Linux)
	SYSTEM = linux
endif
ifeq ($(findstring MINGW32, $(shell uname -s)), MINGW32)
	SYSTEM = mingw32
endif
ifeq ($(findstring MINGW64, $(shell uname -s)), MINGW64)
	SYSTEM = mingw64
endif
ifeq ($(findstring CYGWIN, $(shell uname -s)), CYGWIN)
	SYSTEM = cygwin
endif

# Determine machine.
MACHINE = $(shell uname -m)

# Architecture.
ARCH = $(SYSTEM)_$(MACHINE)

# ==============================================================================

# Set number of simultaneous jobs (Default 8)
ifeq ($(J),)
	J = 8
endif

# System configuration.
CONFIGURE_FLAGS =

# Configuration for linux system.
ifeq ($(SYSTEM),linux)
	# Compiler.
	CC = /usr/bin/gcc
	CXX = /usr/bin/g++

	# Installation directory.
	INSTALL_DIR = /opt
endif

# Configuration for mingw32 system.
ifeq ($(SYSTEM),mingw32)
	# Compiler.
	CC = /mingw32/bin/gcc
	CXX = /mingw32/bin/g++

	# Installation directory.
	INSTALL_DIR = /c/opt
endif

# Configuration for mingw64 system.
ifeq ($(SYSTEM),mingw64)
	# Compiler.
	CC = /mingw64/bin/gcc
	CXX = /mingw64/bin/g++

	# Installation directory.
	INSTALL_DIR = /c/opt
endif

# Installation directory.
PREFIX = $(INSTALL_DIR)/$(PACKAGE_NAME)/$(ARCH)/$(PACKAGE)

# ==============================================================================

all:
	@echo ""
	@echo "ARCH   = $(ARCH)"
	@echo "PREFIX = $(PREFIX)"
	@echo ""
	@echo "## Get Source Code"
	@echo "make clone"
	@echo "make pull"
	@echo ""
	@echo "## Build"
	@echo "make prepare"
	@echo "make configure"
	@echo "make compile [J=...]"
	@echo ""
	@echo "## Install"
	@echo "[sudo] make install"
	@echo ""
	@echo "## Cleanup"
	@echo "make clean"
	@echo ""


.PHONY: clone
clone:
	git clone https://github.com/YosysHQ/yosys.git


.PHONY: pull
pull:
	# Discard any local changes
	# cd $(PACKAGE_NAME) && git checkout -- .
	cd $(PACKAGE_NAME) && git reset --hard
	
	# Checkout master branch
	cd $(PACKAGE_NAME) && git checkout master
	
	# ...
	cd $(PACKAGE_NAME) && git pull


.PHONY: prepare
prepare:
	# Discard any local changes
	# cd $(PACKAGE_NAME) && git checkout -- .
	cd $(PACKAGE_NAME) && git reset --hard

	# Checkout specific version
	cd $(PACKAGE_NAME) && git checkout $(PACKAGE)


.PHONY: configure
configure:
	# Configure the build system
	echo "CONFIG := gcc" > $(PACKAGE_NAME)/Makefile.conf
	echo "PREFIX := $(PREFIX)" >> $(PACKAGE_NAME)/Makefile.conf


.PHONY: compile
compile:
	cd $(PACKAGE_NAME) && make -j$(J)


.PHONY: install
install:
	cd $(PACKAGE_NAME) && make install
	-mkdir -p $(PREFIX)/share/doc
	-cd $(PREFIX)/share/doc && wget -nc https://yosys.readthedocs.io/_/downloads/en/latest/pdf/
	-cd $(PREFIX)/share/doc && mv index.html yosys_manual_latest.pdf


.PHONY: clean
clean:
	cd $(PACKAGE_NAME) && make clean

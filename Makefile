# --- Tools ---

ZIP_TOOL := $(shell \
    if command -v zip >/dev/null 2>&1; then echo zip; \
    elif command -v 7z >/dev/null 2>&1; then echo 7z; \
    else echo ""; fi)

ifeq ($(ZIP_TOOL),)
$(error Neither zip nor 7z was found in PATH)
endif

# --- JSON field extractor ---
json_field = $(shell \
    grep -m1 '"$(1)"' src/info.json \
    | tr -d '\r' \
    | cut -d':' -f2 \
    | tr -d '",' \
    | tr -d ' ' \
)

MOD_NAME := $(call json_field,name)
MOD_VERSION := $(call json_field,version)

ifeq ($(MOD_NAME),)
$(error Could not extract name from src/info.json)
endif

ifeq ($(MOD_VERSION),)
$(error Could not extract version from src/info.json)
endif

ZIP_DIR := $(MOD_NAME)_$(MOD_VERSION)
ZIP_NAME := $(ZIP_DIR).zip
BUILD_DIR := build
TEMP_DIR := .build_temp

# --- Factorio mods directory (POSIX) ---
ifeq ($(OS),Windows_NT)
    FACTORIO_MODS_DIR := $(APPDATA)/Factorio/mods
else
    FACTORIO_MODS_DIR := $(HOME)/.factorio/mods
endif

.PHONY: all build clean install install-clean

# --- Default target ---

all: build

# --- Build ---

build:
	@printf 'Building %s %s\n' "$(MOD_NAME)" "$(MOD_VERSION)"
	@mkdir -p "$(BUILD_DIR)"
	@rm -rf "$(TEMP_DIR)"
	@mkdir -p "$(TEMP_DIR)/$(ZIP_DIR)"
	@cp -R src/* "$(TEMP_DIR)/$(ZIP_DIR)/"

	@printf 'Zipping with %s...\n' "$(ZIP_TOOL)"
	@if [ "$(ZIP_TOOL)" = "zip" ]; then \
		( cd "$(TEMP_DIR)" && zip -r "../$(BUILD_DIR)/$(ZIP_NAME)" "$(ZIP_DIR)" ); \
	else \
		( cd "$(TEMP_DIR)" && 7z a -tzip "../$(BUILD_DIR)/$(ZIP_NAME)" "$(ZIP_DIR)" >/dev/null ); \
	fi

	@rm -rf "$(TEMP_DIR)"
	@printf 'Build complete -> %s/%s\n' "$(BUILD_DIR)" "$(ZIP_NAME)"

# --- Install ---

install:
	@printf 'Installing to %s\n' "$(FACTORIO_MODS_DIR)"
	@mkdir -p "$(FACTORIO_MODS_DIR)"
	@cp "$(BUILD_DIR)/$(ZIP_NAME)" "$(FACTORIO_MODS_DIR)/"
	@printf 'Done.\n'

# Build then install
install-clean: build
	@$(MAKE) install

# --- Clean ---

clean:
	@printf 'Cleaning...\n'
	@rm -rf "$(BUILD_DIR)" "$(TEMP_DIR)"
	@printf 'Done.\n'

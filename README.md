# Corne TP - ZMK Firmware Config

Custom ZMK firmware for a Corne 42-key split keyboard with trackpad.

## Hardware

- **Keyboard**: Corne 4.1 (42 keys, 3x6 + 3 thumb keys per side)
- **Controller**: nice!nano (nRF52840)
- **Connectivity**: Bluetooth
- **Left half**: OLED display (SSD1306, 128x32, I2C)
- **Right half**: Trackpad Azoteq ProxSense TPS43 (IQS5xx, I2C)

## Layers

- **0 - DEFAULT**: QWERTY base layer
- **1 - NUMBER**: Numbers and symbols
- **2 - FN**: Function / numpad
- **3 - HOTKEY**: Settings, BT, soft off

## Build

The firmware is built automatically via GitHub Actions on push. Download the `.uf2` artifacts from the [Actions tab](../../actions).

The `.uf2` files will be generated in `./firmware/`.

### Flashing

1. Connect a half via USB
2. Double-click the nice!nano reset button to enter bootloader (appears as USB drive)
3. Drag the corresponding `.uf2` file to the drive

Flash order for pairing: right half first, then left half.



### Settings Reset

Flash `settings_reset.uf2` to clear Bluetooth pairings and stored config. Re-flash the normal firmware afterwards.

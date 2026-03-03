#!/bin/bash
set -e

IMAGE="zmkfirmware/zmk-dev-arm:stable"
WORK_DIR="/tmp/zmk-workspace"
OUTPUT_DIR="/output"

# Targets to build
TARGETS=(
  "corne_tp_left:studio-rpc-usb-uart"
  "corne_tp_right:"
  "settings_reset:"
)

echo "=== ZMK Firmware Build ==="
echo "Pulling Docker image..."
docker pull "$IMAGE"

mkdir -p firmware

for target in "${TARGETS[@]}"; do
  SHIELD="${target%%:*}"
  SNIPPET="${target##*:}"

  SNIPPET_ARG=""
  if [ -n "$SNIPPET" ]; then
    SNIPPET_ARG="-DSNIPPET=$SNIPPET"
  fi

  echo ""
  echo ">>> Building $SHIELD..."

  docker run --rm \
    -v "$(pwd)/config:/config:ro" \
    -v "$(pwd)/firmware:$OUTPUT_DIR" \
    "$IMAGE" \
    bash -c "
      cp -r /config $WORK_DIR
      cd $WORK_DIR && west init -l . 2>/dev/null || true
      cd $WORK_DIR && west update
      west build -s zmk/app -d /tmp/build -b nice_nano/nrf52840 -p -- \
        -DSHIELD=$SHIELD \
        $SNIPPET_ARG \
        -DZMK_CONFIG=$WORK_DIR
      cp /tmp/build/zephyr/zmk.uf2 $OUTPUT_DIR/$SHIELD.uf2
    "

  echo ">>> $SHIELD done: firmware/$SHIELD.uf2"
done

echo ""
echo "=== Build complete ==="
echo "Firmware files in ./firmware/"
ls -la firmware/*.uf2

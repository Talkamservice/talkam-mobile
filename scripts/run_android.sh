#!/usr/bin/env bash
# Run the app on whatever Android emulator is already running (including one
# Android Studio launched in the background with a hidden window). Only boots
# a new emulator if none is connected yet.
#
# Pass an AVD id as $1 to require a specific emulator instead, e.g.:
#   ./scripts/run_android.sh Pixel_7_API_35
set -euo pipefail

AVD_ID="${1:-}"
FALLBACK_AVD_ID="Pixel_7_API_35"
CONFIG_FILE="${CONFIG_FILE:-config.json}"

cd "$(dirname "$0")/.."

if [ ! -f "$CONFIG_FILE" ]; then
  echo "error: $CONFIG_FILE not found. Copy config.example.json to $CONFIG_FILE and fill in secrets." >&2
  exit 1
fi

find_any_device() {
  adb devices | awk '/^emulator-/{print $1; exit}'
}

find_device_for_avd() {
  for serial in $(adb devices | awk '/^emulator-/{print $1}'); do
    if [ "$(adb -s "$serial" emu avd name 2>/dev/null | head -1)" = "$1" ]; then
      echo "$serial"
      return 0
    fi
  done
  return 1
}

if [ -n "$AVD_ID" ]; then
  existing_device=$(find_device_for_avd "$AVD_ID" || true)
else
  existing_device=$(find_any_device || true)
fi

if [ -z "$existing_device" ]; then
  launch_avd="${AVD_ID:-$FALLBACK_AVD_ID}"
  echo "No emulator running. Launching $launch_avd..."
  flutter emulators --launch "$launch_avd"

  echo "Waiting for adb to see $launch_avd..."
  until existing_device=$(find_device_for_avd "$launch_avd" || true); [ -n "$existing_device" ]; do
    sleep 2
  done
fi

echo "Waiting for $existing_device to finish booting..."
until [ "$(adb -s "$existing_device" shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')" = "1" ]; do
  sleep 2
done

echo "Booted. Running app on $existing_device..."
flutter run --dart-define-from-file="$CONFIG_FILE" -d "$existing_device"

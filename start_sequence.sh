#!/usr/bin/env bash
# Start sequence for AVA Sovereign modules (run on a host you control).
# Activation order: ghost_mesh -> iron_shield (mapped) -> wealth_manifestor
# Usage: ./start_sequence.sh [--map-iron=sentinel_shield.py]

set -euo pipefail

MAP_IRON=""
for arg in "$@"; do
  case $arg in
    --map-iron=*)
      MAP_IRON="${arg#*=}"
      shift
      ;;
    *)
      ;;
  esac
done

LOGDIR="./ava_logs"
mkdir -p "$LOGDIR"

run_module() {
  local module_path="$1"
  local name="$2"
  if [ ! -f "$module_path" ]; then
    echo "$(date -u --iso-8601=seconds) [ERROR] Module not found: $module_path" | tee -a "$LOGDIR/$name.log"
    return 1
  fi
  echo "$(date -u --iso-8601=seconds) [INFO] Starting $name ($module_path)" | tee -a "$LOGDIR/$name.log"
  python3 "$module_path" >>"$LOGDIR/$name.log" 2>&1 &
  pid=$!
  echo "$(date -u --iso-8601=seconds) [INFO] Launched $name (pid=$pid)" | tee -a "$LOGDIR/$name.log"
  sleep 4
  if kill -0 "$pid" 2>/dev/null; then
    echo "$(date -u --iso-8601=seconds) [INFO] $name appears running (pid=$pid)" | tee -a "$LOGDIR/$name.log"
    return 0
  else
    echo "$(date -u --iso-8601=seconds) [ERROR] $name crashed shortly after start" | tee -a "$LOGDIR/$name.log"
    return 2
  fi
}

main() {
  echo "$(date -u --iso-8601=seconds) [INFO] Starting AVA activation sequence" | tee -a "$LOGDIR/activation.log"

  if ! run_module "./ghost_mesh.py" "ghost_mesh"; then
    echo "$(date -u --iso-8601=seconds) [FATAL] ghost_mesh failed to start — aborting" | tee -a "$LOGDIR/activation.log"
    exit 1
  fi

  IRON_MODULE="./iron_shield.py"
  if [ -n "$MAP_IRON" ]; then
    IRON_MODULE="$MAP_IRON"
  elif [ -f "./sentinel_shield.py" ]; then
    IRON_MODULE="./sentinel_shield.py"
  fi

  if [ ! -f "$IRON_MODULE" ]; then
    echo "$(date -u --iso-8601=seconds) [WARN] iron_shield not found at $IRON_MODULE. Skipping iron_shield step." | tee -a "$LOGDIR/activation.log"
  else
    if ! run_module "$IRON_MODULE" "iron_shield"; then
      echo "$(date -u --iso-8601=seconds) [FATAL] iron_shield failed — aborting" | tee -a "$LOGDIR/activation.log"
      exit 1
    fi
  fi

  if ! run_module "./wealth_manifestor.py" "wealth_manifestor"; then
    echo "$(date -u --iso-8601=seconds) [ERROR] wealth_manifestor failed to start" | tee -a "$LOGDIR/activation.log"
    exit 1
  fi

  echo "$(date -u --iso-8601=seconds) [INFO] Activation sequence complete. Check $LOGDIR for logs." | tee -a "$LOGDIR/activation.log"
}

main "$@"
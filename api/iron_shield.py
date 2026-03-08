# Bridge stub: run sentinel_shield.py if present
import runpy
import sys

try:
    runpy.run_path("sentinel_shield.py", run_name="__main__")
except FileNotFoundError:
    print("iron_shield bridge: sentinel_shield.py not found. Create iron_shield.py or map to another module.", file=sys.stderr)
    sys.exit(1)
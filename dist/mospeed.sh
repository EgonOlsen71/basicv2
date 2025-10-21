#!/bin/bash
# Resolve the directory of this script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Running from $SCRIPT_DIR"

# Run Java using classpath relative to the script's directory
java -Xmx768m -cp "$SCRIPT_DIR/basicv2.jar:$SCRIPT_DIR/dist/basicv2.jar" com.sixtyfour.cbmnative.shell.MoSpeedCL "$@"


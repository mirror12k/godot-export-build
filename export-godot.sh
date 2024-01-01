#!/bin/bash

cd ${PROJECT_PATH}
wget -q https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip
unzip Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip
chmod +x Godot_v${GODOT_VERSION}-stable_linux.x86_64
wget -q https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}-stable/Godot_v${GODOT_VERSION}-stable_export_templates.tpz
mkdir -p /home/runner/.local/share/godot/export_templates/${GODOT_VERSION}.stable/
unzip Godot_v${GODOT_VERSION}-stable_export_templates.tpz -d /home/runner/.local/share/godot/export_templates/${GODOT_VERSION}.stable/
mv ${HOME}/.local/share/godot/export_templates/${GODOT_VERSION}.stable/templates/* ${HOME}/.local/share/godot/export_templates/${GODOT_VERSION}.stable/
while IFS= read -r line; do
  if [[ $line == name* ]]; then
    preset_name=$(echo $line | cut -d'=' -f2 | tr -d '"')
  fi
  if [[ $line == export_path* ]]; then
    export_path=$(echo $line | cut -d'=' -f2 | tr -d '"')
    mkdir -p $(dirname $export_path)
    ./Godot_v${GODOT_VERSION}-stable_linux.x86_64 --headless --export-release "$preset_name" "$export_path" --quit
    if [ ! "$(ls -A $export_path)" ]; then
      echo "Export directory $export_path is empty."
      exit 1
    fi
    echo "Exported $preset_name to $export_path"
  fi
done < export_presets.cfg

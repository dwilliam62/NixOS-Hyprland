{pkgs}:
pkgs.writeShellScriptBin "ff" ''
  fastfetch -c ~/.config/fastfetch/fastfetch-system-times.config.jsonc
''

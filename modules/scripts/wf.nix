{pkgs}:
pkgs.writeShellScriptBin "wf" ''
  # Wfetch Randomizer
  # Choose between multiple command options randomly
  # Author: Don Williams
  # Revision History
  #==============================================================
  v0.1      5-15-2025        Initial release

  # Generate a random number (0 to 4)
  choice=$((RANDOM % 5))

  # Execute one of the five commands based on the random number
  case "$choice" in
      0) wfetch --waifu2 --challenge --challenge-years=3 --image-size 300 ;;
      1) wfetch --waifu --challenge --challenge-years=3 --image-size 300 ;;
      2) wfetch --challenge --challenge-years=3 --hollow ;;
      3) wfetch --challenge --challenge-years=3 --wallpaper ;;
      4) wfetch --challenge --challenge-years=3 --smooth ;;
  esac

''

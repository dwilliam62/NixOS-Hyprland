#!/usr/bin/env bash

# Wfetch
      # choice betwen two images randomly
      #  wfetch --waifu2 --challenge --challenge-years=3

    #v1
    # Generate a random number (0 or 1)
    choice=$((RANDOM % 2))

    # Execute one of the two commands based on the random number
      #if [ "$choice" -eq 0 ]; then
      #  wfetch --waifu2 --challenge --challenge-years=3 --image-size 300
      #else
      #   wfetch --waifu --challenge --challenge-years=3 --image-size 300
      #fi
    #v2

   # Wfetch Randomizer
  # Choose between multiple commands randomly

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


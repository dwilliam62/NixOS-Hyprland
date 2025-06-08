#!/usr/bin/env bash

# Which terminal to use for the “up” popup
TERMINAL="${TERMINAL:-kitty}"

# 1) Check for official zypper updates
#    Skip the first 3 header lines, drop any blank lines, and count the rest
ofc=$(zypper --non-interactive list-updates \
      | tail -n +4 \
      | sed '/^$/d' \
      | wc -l)

# 2) Check for Flatpak updates (if installed)
if command -v flatpak >/dev/null 2>&1; then
  fpk=$(flatpak remote-ls --updates | wc -l)
  fpk_disp="\n󰏓 Flatpak  $fpk"
else
  fpk=0
  fpk_disp=""
fi

# Total outstanding updates
total=$((ofc + fpk))

case "$1" in
  text)
    # just print the number if non-zero
    [ "$total" -ne 0 ] && echo "$total"
    exit
    ;;
  img)
    # print an icon if non-zero
    [ "$total" -ne 0 ] && echo "󰩢"
    exit
    ;;
esac

# if not “up”, nothing more to do
if [[ "$1" != "up" ]] || (( total == 0 )); then
  exit
fi

# when the popup closes, refresh (e.g. your Waybar module)
trap 'pkill -SIGUSR2 waybar' EXIT

# build the inside‐popup command
command=$(cat <<EOF
printf '[ Official ] %-5s\\n[ Flatpak ] %-5s\\n' "$ofc" "$fpk"
echo
# 1) Refresh metadata + upgrade all
sudo zypper refresh
sudo zypper update --no-confirm
# 2) Flatpak (if present)
if command -v flatpak >/dev/null 2>&1; then
  flatpak update --noninteractive
fi
echo
read -n 1 -p 'Press any key to exit…'
EOF
)

# launch in your preferred terminal
$TERMINAL --title "System Update" -e bash -c "${command}"


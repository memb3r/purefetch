#!/bin/bash

run_command() {
    output=$(eval "$1")
    echo "$output"
}

user=$USER
host=$(hostname)

if [ -f /etc/os-release ]; then
    source /etc/os-release
    os_info=$NAME
else
    os_info=$(uname)
fi

kernel=$(uname -r)
uptime_seconds=$(cut -d ' ' -f 1 /proc/uptime)
uptime_formatted=$(date -u -d "@$uptime_seconds" +'%-kh %-Mm')

if command -v dpkg &>/dev/null; then
    main_pkg="dpkg"
    packages_count=$(run_command 'dpkg -l | grep -c "^ii"')
    packages="$packages_count ($main_pkg)"
elif command -v rpm &>/dev/null; then
    main_pkg="rpm"
    packages_count=$(run_command 'rpm -qa | wc -l')
    packages="$packages_count ($main_pkg)"
elif command -v pacman &>/dev/null; then
    main_pkg="pacman"
    packages_count=$(run_command 'pacman -Qq | wc -l')
    packages="$packages_count ($main_pkg)"
elif command -v zypper &>/dev/null; then
    main_pkg="zypper"
    packages_count=$(run_command 'zypper se --installed-only | grep "i+" | wc -l')
    packages="$packages_count ($main_pkg)"
elif command -v dnf &>/dev/null; then
    main_pkg="dnf"
    packages_count=$(run_command 'dnf list installed | wc -l')
    packages="$packages_count ($main_pkg)"
elif command -v xbps-query &>/dev/null; then
    main_pkg="xbps"
    packages_count=$(run_command 'xbps-query -l | wc -l')
    packages="$packages_count ($main_pkg)"
elif command -v apk &>/dev/null; then
    main_pkg="apk"
    packages_count=$(run_command 'apk info -q | wc -l')
    packages="$packages_count ($main_pkg)"
else
    packages="N/A"
fi

cpu=$(run_command 'lscpu | grep "Model name" | sed -e "s/Model name://g" | xargs')
memory_info=$(free -m)
used_memory=$(echo "$memory_info" | awk 'NR==2 {print $3}')
total_memory=$(echo "$memory_info" | awk 'NR==2 {print $2}')
memory_format=$(printf "%.1fMiB/%.1fMiB" $used_memory $total_memory)

LIGHTGREEN="\033[1;32m"
WHITE="\033[0m"

echo -e "${LIGHTGREEN}       /^-^\     ${user}${WHITE}@${LIGHTGREEN}${host}"
echo -e "${LIGHTGREEN}      / ${WHITE}o o ${LIGHTGREEN}\\ "
echo -e "${LIGHTGREEN}     /  ${WHITE} Y   ${LIGHTGREEN}\\   os: ${WHITE}${os_info}"
echo -e "${LIGHTGREEN}     V \\ ${WHITE}v${LIGHTGREEN} / V   kernel: ${WHITE}${kernel}"
echo -e "${LIGHTGREEN}       / - \\     uptime: ${WHITE}${uptime_formatted}"
echo -e "${LIGHTGREEN}      /    |     packages: ${WHITE}${packages}"
echo -e "${LIGHTGREEN}(    /     |     cpu: ${WHITE}${cpu}"
echo -e "${LIGHTGREEN} ===/___) ||     ram: ${WHITE}${memory_format}"

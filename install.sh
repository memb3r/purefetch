#!/bin/bash

LIGHTGREEN="\033[1;32m"
WHITE="\033[0m"

echo -e "${LIGHTGREEN}Welcome to the Purefetch installation script!"

touch purefetch
echo "#!/bin/bash" > purefetch
echo "./purefetch.sh" >> purefetch
chmod +x purefetch.sh
chmod +x purefetch

echo ""
echo -e "${LIGHTGREEN}Installation complete! ${WHITE}To use Purefetch, simply run './purefetch'."

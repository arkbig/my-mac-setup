eval "$(/opt/homebrew/bin/brew shellenv)"

DEVBASE=~/proj/devbase
# udptunnel
${DEVBASE}/udptunnel/forward_udp.sh ${DEVBASE}/udptunnel/udp_forwarding.conf &
# Colima (Docker)
COLIMA_CPUS=8
COLIMA_MEMORY=8
${DEVBASE}/util/colima_startup.sh

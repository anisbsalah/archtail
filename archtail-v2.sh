#!/usr/bin/env bash

##################################################################
##################       GLOBAL VARIABLES       ##################
##################################################################

# NOTE: Many of these variables get set programmatically as you run the program.
# But they must be declared in the global namespace so they can be updated in local functions.
# Here in 'archtail', they get updated many times as you run the individual functions.

# DEFAULT GRAPHICS DRIVERS ETC --- Changes as needed via whiptail later in script ---
graphics_drivers=(xf86-video-vesa) # $( pacman -Ss xf86-video- ) will list available drivers...
input_drivers=(libinput xf86-input-libinput xf86-input-evdev xf86-input-elographics xf86-input-synaptics)
wifi_drivers=(dkms broadcom-wl-dkms) # find chipset for your wifi card!
display_mgr='lightdm'                # lightdm goes well with cinnamon desktop
mydesktop=("${cinnamon_desktop[@]}")
AUR_HELPER='yay-bin'

# You can edit this if you want.
# For some reasons, the ubuntu geoip server doesn't always work.
TIMEZONE='Africa/Tunis'
LOCALE='en_US.UTF-8'
KEYBOARD='us'

##################################################################
###################       SOFTWARE SETS       ####################
##################################################################

# Contents of arrays are Arch Linux package names. Sometimes these change.
# The validate_pkgs function is supposed to check whether pkg names have
# dropped out or have changed.

# These are all executables in script that should be in $PATH
executables=(
	"[["
	"arch-chroot"
	"break"
	"case"
	"cat"
	"date"
	"declare"
	"echo"
	"eval"
	"exit"
	"for"
	"genfstab"
	"grep"
	"if"
	"local"
	"locale-gen"
	"ls"
	"lsblk"
	"mkdir"
	"mkfs"
	"mkswap"
	"modprobe"
	"mount"
	"pacman"
	"passwd"
	"pgrep"
	"printf"
	"rm"
	"sed"
	"sfdisk"
	"sgdisk"
	"shuf"
	"sleep"
	"swapon"
	"systemctl"
	"tee"
	"then"
	"timedatectl"
	"useradd"
	"wget"
	"while"
	"whiptail"
)

# Replace with linux-lts or linux-hardened if preferable
base_pkgs=(base base-devel linux linux-headers linux-firmware)

essential_pkgs=(bash-completion git man-db man-pages texinfo terminus-font nano pacman-contrib sudo zstd)

xorg_pkgs=(xorg xorg-xkill)

drivers=(
	# ------------------------ Graphics
	xf86-video-amdgpu
	xf86-video-ati
	xf86-video-intel
	xf86-video-nouveau
	xf86-video-fbdev
	xf86-video-vesa
	xf86-video-vmware
	mesa lib32-mesa
	vulkan-icd-loader vulkan-intel vulkan-radeon
	lib32-vulkan-icd-loader lib32-vulkan-intel lib32-vulkan-radeon
	libva-intel-driver lib32-libva-intel-driver
	mesa-vdpau lib32-mesa-vdpau
	libva-mesa-driver lib32-libva-mesa-driver
	# ------------------------ Wifi
	dkms broadcom-wl-dkms
	# ------------------------ Input
	libinput xf86-input-libinput xf86-input-evdev
	xf86-input-elographics xf86-input-synaptics
)

cinnamon_desktop=(cinnamon cinnamon-translations
	lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
	blueman gnome-screenshot gnome-system-monitor
	nemo-fileroller nemo-share xed)

gnome_desktop=(gnome gnome-extra gnome-bluetooth)

kde_desktop=(plasma-meta dolphin dolphin-plugins kate konsole sddm
	ark audiocd-kio bluedevil extra-cmake-modules ffmpegthumbs
	ghostwriter gwenview kate kcodecs kcoreaddons kcron kdeconnect
	kdegraphics-thumbnailers kdenetwork-filesharing kdialog kimageformats
	kinit kio-fuse kompare libksysguard networkmanager-qt5 okular packagekit-qt6
	partitionmanager plasma-wayland-protocols print-manager solid spectacle
	svgpart xsettingsd xwaylandvideobridge yakuake)

mate_desktop=(mate mate-extra lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings)

xfce_desktop=(xfce4 xfce4-goodies lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings)

networking_pkgs=(avahi bind bridge-utils curl dhclient dnsmasq dnsutils
	git ifplugd inetutils ipset mobile-broadband-provider-info
	modemmanager net-tools netctl network-manager-applet networkmanager
	networkmanager-openconnect networkmanager-openvpn nfs-utils
	nm-connection-editor nss-mdns ntp openbsd-netcat openconnect
	openresolv openssh openvpn wget wireless-regdb wireless_tools wpa_supplicant)

bluetooth_pkgs=(bluez bluez-libs bluez-utils)

sound_pkgs=(wireplumber pipewire-jack pipewire pipewire-alsa pipewire-audio pipewire-pulse pavucontrol
	alsa-card-profiles alsa-firmware alsa-lib alsa-plugins alsa-utils sof-firmware
	pipewire-docs pipewire-ffado pipewire-roc pipewire-v4l2 pipewire-x11-bell
	pipewire-zeroconf lib32-pipewire lib32-pipewire-jack
	gst-plugin-pipewire gstreamer gst-libav gst-plugins-bad
	gst-plugins-base gst-plugins-good gst-plugins-ugly playerctl)

printing_pkgs=(cups cups-pdf cups-filters cups-pk-helper
	foomatic-db foomatic-db-engine foomatic-db-gutenprint-ppds
	foomatic-db-ppds foomatic-db-nonfree foomatic-db-nonfree-ppds
	ghostscript gsfonts gutenprint gtk3-print-backends libcups system-config-printer)

laptop_pkgs=(acpi acpid acpi_call tlp)

archive_pkgs=(arj cabextract file-roller gzip lzop p7zip sharutils
	unace unarchiver unrar unzip usbutils xz zip zstd)

disk_pkgs=(btrfs-progs cifs-utils dosfstools e2fsprogs exfat-utils
	fuse2 fuse3 fuseiso gpart gparted
	gvfs gvfs-afc gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb
	ifuse mtools mtpfs nfs-utils nilfs-utils ntfs-3g
	os-prober partclone partimage squashfs-tools sshfs udiskie udisks2 uudeview)

font_pkgs=(noto-fonts noto-fonts-emoji terminus-font ttf-hack
	ttf-iosevka-nerd ttf-jetbrains-mono-nerd ttf-mononoki-nerd
	ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols-mono)

pacman_pkgs=(alacritty arc-gtk-theme autoconf automake bash-completion
	cronie dconf-editor dialog evince exa expac ffmpegthumbs htop icoutils
	imagemagick kitty kvantum libreoffice-still libx11 libxft libxinerama
	make meld nano nano-syntax-highlighting papirus-icon-theme pkgconf
	qbittorrent ranger reflector rofi rsync shellcheck shfmt telegram-desktop
	vlc which xdg-desktop-portal xdg-user-dirs xdg-utils yad zenity
	zsh zsh-autosuggestions zsh-syntax-highlighting)

my_services=(acpid avahi-daemon bluetooth cronie cups dhcpcd ntpd NetworkManager reflector sshd tlp wpa_supplicant)

# This array will exclude services because they are often named differently and are duplicates
all_pkgs=(
	base_pkgs
	essential_pkgs
	xorg_pkgs
	drivers
	cinnamon_desktop
	gnome_desktop
	kde_desktop
	mate_desktop
	xfce_desktop
	networking_pkgs
	sound_pkgs
	bluetooth_pkgs
	printing_pkgs
	archive_pkgs
	disk_pkgs
	laptop_pkgs
	font_pkgs
	pacman_pkgs
)

# Can't show checkmarks very easily... This array will help show the user which tasks are completed or not
completed_tasks=("X")

##################################################################
#######################     FUNCTIONS     ########################
##################################################################

######################  UTILITY FUNCTIONS  #######################

# WELCOME MESSAGE
function welcome() {
	message="This automated Arch Linux installer will lead you through \
	a menu-driven process to create a base installation \
	of Arch Linux on your computer by selecting a group of tasks from a main menu."
	whiptail --backtitle "${backmessage}" --title "Welcome" \
		--msgbox "${message}" 10 63
}

# PRINT STEP
function print_step() {
	echo "
==========================================================================================
 $1
==========================================================================================
"
}

# PRESS ANY KEY TO CONTINUE
function pressanykey() {
	printf "\n"
	read -n1 -p "Press any key to continue..."
}

# PACMAN CONFIGURATION
function pacman_configuration() {
	# Add color
	sed -i 's/^[#[:space:]]*Color/Color\nILoveCandy/' /etc/pacman.conf
	# Add parallel downloading
	sed -i 's/^[#[:space:]]*ParallelDownloads.*/ParallelDownloads = 5/' /etc/pacman.conf
	# Enable multilib
	sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
}

# INSTALL PREREQUISITES
function install_prerequisites() {
	clear
	print_step "Installing prerequisites"
	pacman -Sy --noconfirm --needed archlinux-keyring arch-install-scripts glibc reflector wget
	pressanykey
}

# VERIFY BOOT MODE
# This is not a variable but a function that determines
# how the program will branch in its disktable.
function efi_boot_mode() {
	# If the efivars directory exists, we definitely have an EFI BIOS.
	# Otherwise, we could have a non-standard EFI or even an MBR-only system.
	(ls /sys/firmware/efi/efivars &>/dev/null && return 0) || return 1
}

# TIMEZONE AUTO DETECTION
function detect_timezone() {
	# Try to get the Timezone via wget. If that fails, default to 'Africa/Tunis'
	# Check that service is up first...
	server='http://geoip.ubuntu.com/lookup'
	if ping -c3 "${server}" 2>/dev/null; then
		TIMEZONE=$(wget -O - -q http://geoip.ubuntu.com/lookup | sed -n -e 's/.*<TimeZone>\(.*\)<\/TimeZone>.*/\1/p')
	fi

	# Default timezone is Africa/Tunis (we will use detect_timezone value if geoip site is up)
	TIMEZONE=${TIMEZONE:='Africa/Tunis'}
}

function change_timezone() {
	# Select a new timezone from the list in case wget didn't work properly
	message="The system detected your timezone to be: ${TIMEZONE}\n\nKeep it or change it?"
	# whiptail --yesno dialog
	if whiptail --backtitle "${backmessage}" --title "Timezone" \
		--yesno "${message}" \
		--yes-button "Keep '${TIMEZONE}'" \
		--no-button "Change timezone" 10 70 3>&1 1>&2 2>&3; then

		timezone=${TIMEZONE}
	else
		timezones=()
		# Populate array with possible timezones
		for timezone in $(timedatectl list-timezones); do
			timezones+=($(printf "%s\t\t\t%s\n" "${timezone}" 'timezone'))
		done

		# Let user pick the desired timezone
		message="Please select your timezone:"
		timezone=$(whiptail --backtitle "${backmessage}" --title "Timezone" \
			--menu "${message}" "${LINES}" "${COLUMNS}" $((LINES - 8)) \
			"${timezones[@]}" 3>&1 1>&2 2>&3)
	fi

	# Default to $TIMEZONE variable from detect_timezone if the user cancels the previous form
	TIMEZONE=${timezone:=${TIMEZONE}}
	return 0
}

# CHOOSE LOCALE
function choose_locale() {
	if whiptail --backtitle "${backmessage}" --title "locale" \
		--yesno "Default locale: en_US.UTF-8" \
		--yes-button "Keep 'en_US.UTF-8'" \
		--no-button "Change locale" 10 70 3>&1 1>&2 2>&3; then

		LOCALE=${LOCALE:="en_US.UTF-8"}
	else
		# Here's the array of available locales
		locales=()
		for locale in $(grep -E '^#?[a-z]{2}_*' /etc/locale.gen | awk '{print $1}' | sed 's/^#//g'); do
			locales+=($(printf "%s\t\t\t%s\n" "${locale}" "locale"))
		done
		# whiptail selection menu of all available locales on system
		LOCALE=$(whiptail --backtitle "${backmessage}" --title "Locale" \
			--menu "Default: en_US.UTF-8" "${LINES}" "${COLUMNS}" $((LINES - 8)) "${locales[@]}" 3>&1 1>&2 2>&3)
	fi

	LOCALE=${LOCALE:='en_US.UTF-8'}
	return 0
}

# SELECT KEYBOARD LAYOUT
function configure_keyboard() {
	# Get a list of all keyboard files on the system
	keymaps=$(find /usr/share/kbd/keymaps/ -type f -printf "%f\n" | sort -V)
	# Get the list into an array
	keymaps=(${keymaps})

	# status will be part of the menu list of kbd choices
	status=""
	# these will be menu options
	options=()

	# Only turn on us keymap for default
	# I chose a --menu for whiptail and not a --radiolist
	# But I keep this around in case I want to go back to a --radiolist
	for file in "${keymaps[@]}"; do
		if [[ ${file%%.*} == 'us' ]]; then
			status="ON"
		else
			status="OFF"
		fi

		# Remove the suffix for the loadkeys command
		newfile=$(echo "${file}" | sed 's/.map.gz//g')
		# Set up the line for the whiptail menu
		options+=($(printf "%s\t\t\t%s" "${newfile}" 'keymap'))
	done

	# Ask the user if he/she wants to keep the us keymap
	if (whiptail --backtitle "${backmessage}" --title "Keyboard Layout" \
		--yesno "Keep the 'us' keyboard layout?" 10 70); then
		# Set default value for 'us' in case setxkbmap doesn't work
		KEYBOARD=${KEYBOARD:='us'}
	else
		# If not, there are about 260 other options...
		KEYBOARD=$(whiptail --backtitle "${backmessage}" --title "Keyboard Layout" \
			--menu "Default keymap is 'us'" "${LINES}" "${COLUMNS}" $((LINES - 8)) "${options[@]}" 3>&1 1>&2 2>&3)
		# Set default keymap to be 'us' in case above doesn't get set properly or user cancels
		KEYBOARD=${KEYBOARD:='us'}
	fi

	# Default value is 'us'; therefore load new value if we're not in US
	# 'loadkeys' is not persistent; only loads for current session
	if [[ ! ${KEYBOARD} =~ 'us' ]]; then loadkeys "${KEYBOARD}"; fi
	return 0
}

# IF NOT CONNTECTED
function no_connection() {
	message="Your network connection is down!!!\nPerhaps your wifi card is not supported.\nCheck if your network card is plugged in."
	TERM=ansi whiptail --backtitle "${backmessage}" \
		--title "Network Connection" --infobox "${message}" 9 45
	sleep 5
	exit 1
}

# ARE YOU CONNTECTED?
function check_connection() {
	TERM=ansi whiptail --backtitle "${backmessage}" --title "Network Connection" \
		--infobox "Checking network connection now..." 9 45

	if ping -c 3 archlinux.org &>/dev/null; then
		TERM=ansi whiptail --backtitle "${backmessage}" --title "Network Connection" \
			--infobox "Your network connection is up!" 9 45
		sleep 3
	else
		no_connection
	fi
}

# UPDATE SYSTEM CLOCK
function time_date() {
	timedatectl set-ntp true &>/dev/null
	time_date_status=$(timedatectl status)
	whiptail --backtitle "${backmessage}" --title "Time and Date Status" \
		--msgbox "${time_date_status}" 14 70
}

# CHECK IF TASK IS COMPLETED
function check_tasks() {
	# If task already exists in array return falsy
	# Function takes a task number as an argument
	# This function might not be needed anymore: STATUS TBD

	# Just return an 'X' in the array position of the passed integer parameter
	completed_tasks[$1]="X"
}

# FIND CLOSEST MIRROR
function check_reflector() {
	# Arch Linux tries to find and work with the closest mirrors before installing.
	# This function tries to check whether that process is complete or not.
	TERM=ansi whiptail --backtitle "${backmessage}" --title "Update Mirrors" --infobox \
		"Evaluating and finding closest mirrors for Arch repositories...\n\nThis may take a while, but you'll be returned to the main menu as soon as possible." 10 70

	while true; do
		pgrep -x reflector &>/dev/null || break
		sleep 2
	done
}

# VALIDATE PKG NAMES IN SCRIPT
function validate_pkgs() {
	MISSING_PKGS='/tmp/missing_pkgs.log'
	[[ -f ${MISSING_PKGS} ]] && rm "${MISSING_PKGS}"

	message="Arch Linux can change package names without notice.\nJust checking for missing packages..."
	TERM=ansi whiptail --backtitle "${backmessage}" \
		--title "Missing Packages" --infobox "${message}" 8 0

	missing_pkgs=()
	printf "=== MISSING PKGS (IF ANY) ===\n\n" &>>"${MISSING_PKGS}"

	# Initialize the package database
	pacman -Sy &>>"${MISSING_PKGS}"

	for pkg_arr in "${all_pkgs[@]}"; do
		declare -n arr_name=${pkg_arr} # make a namespace for each pkg_array
		for pkg_name in "${arr_name[@]}"; do
			if ! pacman -Sp "${pkg_name}" &>/dev/null; then
				#echo -e "\n'${pkg_name}' from '${pkg_arr}' had an error...\n" &>>"${MISSING_PKGS}" 2>&1
				printf "\n'%s' from '%s' is missing...\n" "${pkg_name}" "${pkg_arr}" &>>"${MISSING_PKGS}" 2>&1
				missing_pkgs+=("${pkg_arr}::${pkg_name}")
			fi
		done
	done
	# printf "%s\n" "${missing_pkgs[@]}" &>>"${MISSING_PKGS}"
	printf "\n===  END OF MISSING PKGS  ===\n" &>>"${MISSING_PKGS}"

	whiptail --backtitle "${backmessage}" --title "Missing Packages" \
		--textbox "${MISSING_PKGS}" --scrolltext 30 90
}

# CHECK THAT ALL EXECUTABLES ARE AVAILABLE FOR THIS SCRIPT
function checkpath() {
	MISSING_EX='/tmp/missing_ex.log'
	[[ -f ${MISSING_EX} ]] && rm "${MISSING_EX}"

	echo "==> ${#executables[@]} executables are being checked. (Good if none are found)" &>>"${MISSING_EX}"
	printf "\n===   MISSING EXECUTABLES   ===\n\n" &>>"${MISSING_EX}"
	for ex in "${executables[@]}"; do
		command -v "${ex}" &>/dev/null || missing_ex+=("${ex}")
	done
	printf "%s\n" "${missing_ex[@]}" &>>"${MISSING_EX}"
	printf "\n=== END MISSING EXECUTABLES ===\n" &>>"${MISSING_EX}"
	whiptail --backtitle "${backmessage}" --title "Missing Executables" \
		--textbox "${MISSING_EX}" --scrolltext 30 90
}

#################  DISK FUNCTIONS  ########################

# SELECT INSTALLATION DISK
function select_disk() {
	local DISKS=()
	for d in $(lsblk | grep disk | awk '{printf "/dev/%s\n%s \\\n",$1,$4}'); do
		DISKS+=("${d}")
	done
	whiptail --backtitle "${backmessage}" --title "Select Disk" \
		--radiolist "Select the disk you want to install Arch Linux on:" 0 0 0 \
		"${DISKS[@]}" 3>&1 1>&2 2>&3
}

# CONFIRM TO WIPE ALL DATA ON INSTALLATION DISK
function confirm_data_wipe() {
	if whiptail --backtitle "${backmessage}" --title "Warning!" \
		--defaultno --yesno "Are you sure you want to wipe all data on ${DISK} ?" 7 0; then
		return 0
	else
		return 1
	fi
}

# CHOOSE WHETHER DRIVE IS SSD OR NOT
function ssd_drive() {
	if whiptail --backtitle "${backmessage}" --title "Disk Device" \
		--defaultno --yesno "Is ${DISK} a SSD?" 7 0; then
		BTRFS_MOUNT_OPTIONS="defaults,noatime,compress=zstd,ssd,commit=120"
	else
		BTRFS_MOUNT_OPTIONS="defaults,noatime,compress=zstd,commit=120"
	fi
}

# CHECK IF ANY DISK WAS SELECTED FOR THE INSTALLATION
function check_disk_selection() {
	if [[ -n ${DISK} ]]; then
		return 0
	else
		msg="No device selected.\nSelect your disk first."
		whiptail --backtitle "${backmessage}" --title "ERROR!" --msgbox "${msg}" 0 0
		return 1
	fi
}

# PARTITION THE SELECTED DISK
function partition_disk() {
	if ! efi_boot_mode; then
		message="The system is booted in BIOS mode.\n\n"
		message+="Do you want to create a GPT or MBR partition table?"
		if whiptail --backtitle "${backmessage}" --title "Partition Table" \
			--yesno "${message}" \
			--yes-button "GPT" \
			--no-button "MBR" 9 0 3>&1 1>&2 2>&3; then
			DISKTABLE='GPT'
		else
			DISKTABLE='MBR'
		fi
	else
		DISKTABLE='GPT'
	fi

	options=()
	options+=("Auto partitions (No swap)" "" "")
	options+=("Auto partitions (Swap to file)" "" "")
	options+=("Auto partitions (Swap partition)" "" "")

	if partition_table=$(whiptail --backtitle "${backmessage}" --title "Partition Table" \
		--radiolist "Select your desired partitioning layout:" 0 0 0 "${options[@]}" 3>&1 1>&2 2>&3); then
		case ${partition_table} in
		*"(No swap)"*)
			auto_partitions_noswap
			;;
		*"(Swap to file)"*)
			SWAPFILE='true'
			set_swapfile_size
			auto_partitions_noswap
			;;
		*"(Swap partition)"*)
			SWAP='true'
			auto_partitions_with_swap
			;;
		*) ;;
		esac
		return 0
	else
		return 1
	fi
}

# CREATE A MBR PARTITION TABLE
function create_mbr_partition_table() {
	clear
	print_step "Wiping DATA on ${DISK}"
	wipefs -a -f "${DISK}"
	print_step "Creating a new MBR partition table on ${DISK}"
	echo 'label: dos' | sfdisk "${DISK}"
	pressanykey
}

# CREATE A GPT PARTITION TABLE
function create_gpt_partition_table() {
	clear
	print_step "Wiping DATA on ${DISK}"
	wipefs -a -f "${DISK}"
	print_step "Creating a new GPT partition table on ${DISK}"
	sgdisk -a 2048 -o "${DISK}"
	pressanykey
}

# RE-READ THE PARTITION TABLE
function reread_partition_table() {
	partprobe "${DISK}"
	sleep 3
}

# AUTO PARTITIONING THE DISK (NO SWAP PARTITION)
function auto_partitions_noswap() {
	TERM=ansi whiptail --backtitle "${backmessage}" --title "Partition The Disk" \
		--infobox "Please wait a moment while creating your partitions..." 7 0
	sleep 2
	if efi_boot_mode; then
		create_gpt_partition_table
		clear
		print_step "Partitioning the disk"
		sgdisk --new=1::+1024M --typecode=1:ef00 --change-name=1:"EFI System Partition" "${DISK}"
		sgdisk --new=2::-0 --typecode=2:8300 --change-name=2:"ArchLinux Root" "${DISK}"
		reread_partition_table
		EFI_PARTITION=$(fdisk -l "${DISK}" | grep "^${DISK}" | awk '{print $1}' | awk 'NR==1')
		ROOT_PARTITION=$(fdisk -l "${DISK}" | grep "^${DISK}" | awk '{print $1}' | awk 'NR==2')
	else
		if [[ ${DISKTABLE} == GPT ]]; then
			create_gpt_partition_table
			clear
			print_step "Partitioning the disk"
			sgdisk --new=1::+1M --typecode=1:ef02 --change-name=1:"BIOS Boot" "${DISK}"
			sgdisk --new=2::-0 --typecode=2:8300 --change-name=2:"ArchLinux Root" "${DISK}"
			reread_partition_table
			BIOS_BOOT_PARTITION=$(fdisk -l "${DISK}" | grep "^${DISK}" | awk '{print $1}' | awk 'NR==1')
			ROOT_PARTITION=$(fdisk -l "${DISK}" | grep "^${DISK}" | awk '{print $1}' | awk 'NR==2')
		else
			create_mbr_partition_table
			clear
			print_step "Partitioning the disk"
			echo 'type=83, bootable' | sfdisk "${DISK}"
			reread_partition_table
			ROOT_PARTITION=$(fdisk -l "${DISK}" | grep "^${DISK}" | awk '{print $1}' | awk 'NR==1')
		fi
	fi
	pressanykey
}

# AUTO PARTITIONING THE DISK (WITH SWAP PARTITION)
function auto_partitions_with_swap() {
	TERM=ansi whiptail --backtitle "${backmessage}" --title "Partition The Disk" \
		--infobox "Please wait a moment while creating your partitions..." 7 0
	sleep 2
	if efi_boot_mode; then
		create_gpt_partition_table
		clear
		print_step "Partitioning the disk"
		sgdisk --new=1::+1024M --typecode=1:ef00 --change-name=1:"EFI System Partition" "${DISK}"
		sgdisk --new=2::+4096M --typecode=2:8200 --change-name=2:"Swap" "${DISK}"
		sgdisk --new=3::-0 --typecode=3:8300 --change-name=3:"ArchLinux Root" "${DISK}"
		reread_partition_table
		EFI_PARTITION=$(fdisk -l "${DISK}" | grep "^${DISK}" | awk '{print $1}' | awk 'NR==1')
		SWAP_PARTITION=$(fdisk -l "${DISK}" | grep "^${DISK}" | awk '{print $1}' | awk 'NR==2')
		ROOT_PARTITION=$(fdisk -l "${DISK}" | grep "^${DISK}" | awk '{print $1}' | awk 'NR==3')
	else
		if [[ ${DISKTABLE} == GPT ]]; then
			create_gpt_partition_table
			clear
			print_step "Partitioning the disk"
			sgdisk --new=1::+1M --typecode=1:ef02 --change-name=1:"BIOS Boot" "${DISK}"
			sgdisk --new=2::+4096M --typecode=2:8200 --change-name=2:"Swap" "${DISK}"
			sgdisk --new=3::-0 --typecode=3:8300 --change-name=3:"ArchLinux Root" "${DISK}"
			reread_partition_table
			BIOS_BOOT_PARTITION=$(fdisk -l "${DISK}" | grep "^${DISK}" | awk '{print $1}' | awk 'NR==1')
			SWAP_PARTITION=$(fdisk -l "${DISK}" | grep "^${DISK}" | awk '{print $1}' | awk 'NR==2')
			ROOT_PARTITION=$(fdisk -l "${DISK}" | grep "^${DISK}" | awk '{print $1}' | awk 'NR==3')
		else
			create_mbr_partition_table
			clear
			print_step "Partitioning the disk"
			printf 'size=+4096M, type=S\nsize=+, type=L, bootable\n' | sfdisk "${DISK}"
			reread_partition_table
			SWAP_PARTITION=$(fdisk -l "${DISK}" | grep "^${DISK}" | awk '{print $1}' | awk 'NR==1')
			ROOT_PARTITION=$(fdisk -l "${DISK}" | grep "^${DISK}" | awk '{print $1}' | awk 'NR==2')
		fi
	fi
	pressanykey
}

# SWAP FILE SIZE SETUP
function set_swapfile_size() {
	# Linear swap file size
	ram=$(free -m -t | awk 'NR == 2 {print $2}')
	result=$((ram < 4096 ? ram : 4096))
	result=$((result + ((ram - 4096 > 0 ? ram - 4096 : 0) / 2)))
	result=$((result < 32 * 1024 ? result : 32 * 1024))

	# Accept the default swap file size or edit it manually
	swapfile_size=$(whiptail --backtitle "${backmessage}" --title "Swap File" \
		--inputbox "Type the size of the swap file (MiB):\n(Default = ${result} MiB)" 0 0 "${result}" 3>&1 1>&2 2>&3)
	SWAPFILE_SIZE="${swapfile_size:=${result}}"
}

# FORMAT THE PARTITIONS
function format_partitions() {
	options=()
	options+=("btrfs" "" "on")
	options+=("ext4" "" "off")
	message="Select the appropriate file system for root partition:\n(Default: btrfs)"
	filesystem=$(whiptail --backtitle "${backmessage}" --title "Format Partitions" \
		--radiolist "${message}" 0 0 0 "${options[@]}" 3>&1 1>&2 2>&3)

	FILESYSTEM=${filesystem:=btrfs}

	clear
	print_step "Formatting the partitions"

	PARTITIONS=$(fdisk -l "${DISK}" | grep "^${DISK}" | awk '{print $1}')
	for PART in ${PARTITIONS}; do
		case ${PART} in
		"${BIOS_BOOT_PARTITION}")
			continue
			;;
		"${EFI_PARTITION}")
			echo "[*] Formatting the EFI system partition as fat32..."
			mkfs.fat -F 32 "${PART}"
			;;
		"${SWAP_PARTITION}")
			echo "[*] Formatting the swap partition..."
			mkswap "${PART}"
			swapon "${PART}"
			;;
		"${ROOT_PARTITION}")
			echo "[*] Formatting the root partition as ${FILESYSTEM}..."
			if [[ ${FILESYSTEM} == btrfs ]]; then
				mkfs.btrfs -f "${PART}"
			elif [[ ${FILESYSTEM} == ext4 ]]; then
				mkfs.ext4 -F "${PART}"
			fi
			;;
		*) printf "Bad disk format request.\nCan't make that disk format." && sleep 5 && clear && startmenu "D" ;;
		esac
	done
	pressanykey
	return 0
}

# MOUNT THE FILE SYSTEMS
function mount_filesystems() {
	clear
	print_step "Mounting the file systems"

	# Mount the root partition
	if [[ ${FILESYSTEM} == btrfs ]]; then
		mount -t btrfs "${ROOT_PARTITION}" /mnt
		subvolumes_setup
	elif [[ ${FILESYSTEM} == ext4 ]]; then
		mount -t ext4 "${ROOT_PARTITION}" /mnt
	fi

	# Mount the EFI System partition
	if efi_boot_mode; then
		mount --mkdir "${EFI_PARTITION}" /mnt/boot
	fi
	pressanykey
}

# CREATE BTRFS SUBVOLUMES
function create_subvolumes() {
	echo "[*] Creating subvolumes for root, home, .snapshots, swap, tmp and var/log directories..."
	btrfs subvolume create /mnt/@
	btrfs subvolume create /mnt/@home
	btrfs subvolume create /mnt/@snapshots

	if [[ -n ${SWAPFILE_SIZE} ]]; then
		btrfs subvolume create /mnt/@swap
	fi
	btrfs subvolume create /mnt/@tmp
	btrfs subvolume create /mnt/@var_log
}

# MOUNT ALL BTRFS SUBVOLUMES
function mount_subvolumes() {
	echo "[*] Mounting the subvolumes..."
	mount -o "${BTRFS_MOUNT_OPTIONS},subvol=@" "${ROOT_PARTITION}" /mnt
	mkdir -p /mnt/{home,.snapshots,tmp,var/log}
	mount -o "${BTRFS_MOUNT_OPTIONS},subvol=@home" "${ROOT_PARTITION}" /mnt/home
	mount -o "${BTRFS_MOUNT_OPTIONS},subvol=@snapshots" "${ROOT_PARTITION}" /mnt/.snapshots

	if [[ ${SWAPFILE} == true ]]; then
		mkdir -p /mnt/swap
		mount -o "${BTRFS_MOUNT_OPTIONS},subvol=@swap" "${ROOT_PARTITION}" /mnt/swap
	fi
	mount -o "${BTRFS_MOUNT_OPTIONS},subvol=@tmp" "${ROOT_PARTITION}" /mnt/tmp
	mount -o "${BTRFS_MOUNT_OPTIONS},subvol=@var_log" "${ROOT_PARTITION}" /mnt/var/log
}

# BTRFS SUBVOLUMES CREATION AND MOUNTING
function subvolumes_setup() {
	create_subvolumes
	umount /mnt
	mount_subvolumes
}

function create_swap_file() {
	clear
	print_step "Creating a swap file"

	if [[ ${SWAPFILE} == true ]]; then
		if [[ ${FILESYSTEM} == btrfs ]]; then

			btrfs filesystem mkswapfile --size "${SWAPFILE_SIZE}M" --uuid clear /mnt/swap/swapfile
			swapon /mnt/swap/swapfile
			echo "# Swap
/swap/swapfile    none    swap    defaults  0   0" | tee -a /mnt/etc/fstab

		elif [[ ${FILESYSTEM} == ext4 ]]; then

			dd if=/dev/zero of=/mnt/swapfile bs=1M count="${SWAPFILE_SIZE}" status=progress # Create a swap file
			chmod 0600 /mnt/swapfile                                                        # Set permissions
			mkswap -U clear /mnt/swapfile                                                   # Format the file to swap
			swapon /mnt/swapfile                                                            # Activate the swap file
			echo "# Swap
/swapfile    none    swap    defaults  0   0" | tee -a /mnt/etc/fstab # Add entry to fstab

		fi
	fi
	pressanykey
}

function current_disk_status() {
	# Current disk status
	status=$(
		fdisk -l "${DISK}"
		lsblk -f "${DISK}"
	)
	whiptail --backtitle "${backmessage}" --title "Current Disk Status" \
		--msgbox "${status}" 0 0

	# If mounting failed, reboot
	if ! grep -qs '/mnt' /proc/mounts; then
		TERM=ansi whiptail --backtitle "${backmessage}" --title "ERROR!" \
			--infobox "Drive is not mounted! Can not continue.\nRebooting in 3s..." 8 0
		sleep 1
		TERM=ansi whiptail --backtitle "${backmessage}" --title "ERROR!" \
			--infobox "Drive is not mounted! Can not continue.\nRebooting in 2s..." 8 0
		sleep 1
		TERM=ansi whiptail --backtitle "${backmessage}" --title "ERROR!" \
			--infobox "Drive is not mounted! Can not continue.\nRebooting in 1s..." 8 0
		sleep 1
		reboot now
	fi
}

function diskmenu() {
	while true; do
		if diskmenupick=$(
			whiptail --backtitle "${backmessage}" --title "Partition Disks" \
				--default-item "$1" --menu "Prepare the installation disk:" 0 0 0 \
				"D" "Select the disk" \
				"P" "Partition the disk" \
				"F" "Format partitions and mount filesystems" \
				"R" "Return to previous menu" 3>&1 1>&2 2>&3
		); then

			case ${diskmenupick} in
			"D")
				if DISK=$(select_disk); then
					confirm_data_wipe && ssd_drive && diskmenu "P"
				else
					diskmenu "D"
				fi

				;;
			"P")
				if check_disk_selection; then
					partition_disk && diskmenu "F"
				else
					diskmenu
				fi
				;;
			"F")
				if check_disk_selection; then
					format_partitions && mount_filesystems && current_disk_status && check_tasks 5 && startmenu "B"
				else
					diskmenu
				fi
				;;
			"R") startmenu "D" ;;
			*) ;;
			esac
		else
			startmenu "D"
		fi
	done
}

####################  INSTALLATION FUNCTIONS  ####################

# INSTALL BASE SYSTEM
function install_base() {
	clear
	print_step "Installing the base system"
	pacstrap -K /mnt "${base_pkgs[@]}"
	pressanykey
}

# MICROCODE INSTALL
function install_microcode() {
	clear
	print_step "Installing microcode update image"

	# Determine processor type and install microcode
	PROC_TYPE=$(lscpu)
	if grep -Eiq "GenuineIntel" <<<"${PROC_TYPE}"; then
		arch-chroot /mnt pacman -S --noconfirm --needed intel-ucode
	elif grep -Eiq "AuthenticAMD" <<<"${PROC_TYPE}"; then
		arch-chroot /mnt pacman -S --noconfirm --needed amd-ucode
	fi

	pressanykey
}

function install_graphics_drivers() {
	# Graphics card drivers find and install
	card=$(lspci | grep VGA | sed 's/^.*: //g')
	driver=$(whiptail --backtitle "${backmessage}" --title "Graphics Drivers" \
		--radiolist "> You are running: ${card}\nSelect the appropriate drivers:" 0 0 0 \
		"xf86-video-amdgpu" "AMD GPUs" OFF \
		"xf86-video-ati" "ATI cards" OFF \
		"xf86-video-intel" "Intel Video Chipsets" OFF \
		"xf86-video-nouveau" "Open Source 3D acceleration driver for nVidia cards" OFF \
		"xf86-video-fbdev" "For framebuffer devices only" OFF \
		"xf86-video-vesa" "X.org vesa video driver" OFF \
		"xf86-video-vmware" "For virtual machines" OFF 3>&1 1>&2 2>&3)

	# This selection should overwrite the global choice if necessary
	case ${driver} in
	*intel*)
		graphics_drivers=(
			xf86-video-intel
			mesa
			# ---------------------- Multilib
			lib32-mesa
			# ---------------------- Vulkan
			vulkan-intel
			vulkan-icd-loader
			# ---------------------- Vulkan multilib
			lib32-vulkan-intel
			lib32-vulkan-icd-loader
			# ---------------------- Hardware video acceleration
			libva-intel-driver # intel-media-driver
			# ---------------------- Hardware video acceleration multilib
			lib32-libva-intel-driver
		)
		;;
	*amdgpu*)
		graphics_drivers=(
			xf86-video-amdgpu
			mesa
			# ---------------------- Multilib
			lib32-mesa
			# ---------------------- Vulkan
			vulkan-radeon
			vulkan-icd-loader
			# ---------------------- Vulkan multilib
			lib32-vulkan-radeon
			lib32-vulkan-icd-loader
			# ---------------------- Hardware video acceleration
			libva-mesa-driver
			# ---------------------- Hardware video acceleration multilib
			lib32-libva-mesa-driver
		)
		;;
	*ati*)
		graphics_drivers=(
			xf86-video-ati
			mesa
			# ---------------------- Multilib
			lib32-mesa
			# ---------------------- Vulkan
			vulkan-radeon
			vulkan-icd-loader
			# ---------------------- Vulkan multilib
			lib32-vulkan-radeon
			lib32-vulkan-icd-loader
			# ---------------------- Hardware video acceleration
			mesa-vdpau
			# ---------------------- Hardware video acceleration multilib
			lib32-mesa-vdpau
		)
		;;
	*nouveau*)
		graphics_drivers=(
			xf86-video-nouveau
			mesa
			# ---------------------- Multilib
			lib32-mesa
			# ---------------------- Hardware video acceleration
			libva-mesa-driver # mesa-vdpau
			# ---------------------- Hardware video acceleration multilib
			lib32-libva-mesa-driver # lib32-mesa-vdpau
		)
		;;
	*fbdev*)
		graphics_drivers=(xf86-video-fbdev)
		;;
	*vesa*)
		graphics_drivers=(xf86-video-vesa)
		;;
	*vmware*)
		graphics_drivers=(xf86-video-vmware)
		;;
	*)
		graphics_drivers=(
			xf86-video-fbdev
			xf86-video-vesa
		)
		;;
	esac

	clear
	print_step "Installing graphics drivers"
	arch-chroot /mnt pacman -S --noconfirm --needed "${graphics_drivers[@]}"
	pressanykey

}

function install_input_drivers() {
	# Input drivers install
	clear
	print_step "Installing input drivers"
	arch-chroot /mnt pacman -S --noconfirm --needed "${input_drivers[@]}"
	pressanykey
}

# WIFI (BCM4312) IF NECESSARY # wifi_drivers should equal your PCI or USB wifi adapter!!!
function install_wifi_drivers() {
	# Wireless card drivers find and install
	WIFI_CARD=$(lspci -v | grep -i network)
	if grep -Eiq "BCM43" <<<"${WIFI_CARD}"; then
		clear
		print_step "Installing wifi drivers"
		arch-chroot /mnt pacman -S --noconfirm --needed "${wifi_drivers[@]}"
		pressanykey
	fi
}

# INSTALL DRIVERS (GRAPHICS, INPUT, WIRELESS)
function install_drivers() {
	install_graphics_drivers
	install_input_drivers
	install_wifi_drivers
}

# PICK YOUR DESKTOP
function select_desktop() {
	desktop_choice=$(whiptail --backtitle "${backmessage}" --title "Desktop Environment" \
		--radiolist "Select your desired desktop environment\nDefault: Cinnamon" 0 0 0 \
		"Cinnamon" "Gnome based desktop that is intuitive and familiar" ON \
		"Gnome" "Modern and even bleeding edge desktop" OFF \
		"KDE" "A large but heavy-weight DE based on QT toolkit" OFF \
		"Mate" "Originally based on Gnome 2, traditional and lightweight" OFF \
		"XFCE" "Lightweight and full featured desktop" OFF 3>&1 1>&2 2>&3)

	case ${desktop_choice} in
	"Cinnamon")
		mydesktop=("${cinnamon_desktop[@]}")
		display_mgr="lightdm"
		;;
	"Gnome")
		mydesktop=("${gnome_desktop[@]}")
		display_mgr="gdm"
		;;
	"KDE")
		mydesktop=("${kde_desktop[@]}")
		display_mgr="sddm"
		;;
	"Mate")
		mydesktop=("${mate_desktop[@]}")
		display_mgr="lightdm"
		;;
	"XFCE")
		mydesktop=("${xfce_desktop[@]}")
		display_mgr="lightdm"
		;;
	*)
		mydesktop=("${cinnamon_desktop[@]}")
		display_mgr="lightdm"
		;;
	esac
}

# INSTALL SOFTWARE
function install_essential_pkgs() {
	clear
	print_step "Installing essential packages"
	arch-chroot /mnt pacman -S --noconfirm --needed "${essential_pkgs[@]}"
}
function install_xorg() {
	clear
	print_step "Installing Xorg server"
	arch-chroot /mnt pacman -S --noconfirm --needed "${xorg_pkgs[@]}"
}
function install_networking_software() {
	clear
	print_step "Installing networking software"
	arch-chroot /mnt pacman -S --noconfirm --needed "${networking_pkgs[@]}"
}
function install_sound_software() {
	clear
	print_step "Installing sound software"
	arch-chroot /mnt pacman -S --noconfirm --needed "${sound_pkgs[@]}"
}
function install_bluetooth_software() {
	clear
	print_step "Installing bluetooth software"
	arch-chroot /mnt pacman -S --noconfirm --needed "${bluetooth_pkgs[@]}"
}
function install_archive_software() {
	clear
	print_step "Installing archiving & compression software"
	arch-chroot /mnt pacman -S --noconfirm --needed "${archive_pkgs[@]}"
}
function install_disk_software() {
	clear
	print_step "Installing disk software"
	arch-chroot /mnt pacman -S --noconfirm --needed "${disk_pkgs[@]}"
}
function install_printing_software() {
	clear
	print_step "Installing printing software"
	arch-chroot /mnt pacman -S --noconfirm --needed "${printing_pkgs[@]}"
}
function install_laptop_software() {
	clear
	print_step "Installing laptop software"
	arch-chroot /mnt pacman -S --noconfirm --needed "${laptop_pkgs[@]}"
}
function install_fonts() {
	clear
	print_step "Installing fonts"
	arch-chroot /mnt pacman -S --noconfirm --needed "${font_pkgs[@]}"
}
function install_pacman_software() {
	clear
	print_step "Installing more pacman software"
	arch-chroot /mnt pacman -S --noconfirm --needed "${pacman_pkgs[@]}"
	pressanykey
}

# INSTALL DESKTOP ENVIRONMENT
function install_desktop() {
	DESKTOP=("${mydesktop[@]}")
	clear
	print_step "Installing '${desktop_choice}' desktop environment"
	arch-chroot /mnt pacman -S --noconfirm --needed "${DESKTOP[@]}"
	pressanykey
}

# LOGIN DISPLAY MANAGER
function enable_display_manager() {
	# Enable login display manager
	clear
	print_step "Enabling login display manager"
	arch-chroot /mnt systemctl enable "${display_mgr}.service"
	pressanykey
}

# ENABLE SERVICES
function enable_services() {
	clear
	print_step "Enabling essential services"

	for service in "${my_services[@]}"; do
		case ${service} in
		"dhcpcd")
			arch-chroot /mnt systemctl disable "${service}.service"
			;;
		"ntpd")
			arch-chroot /mnt ntpd -qg
			arch-chroot /mnt systemctl enable "${service}.service"
			;;
		"reflector")
			arch-chroot /mnt systemctl enable "${service}.timer"
			arch-chroot /mnt systemctl enable "${service}.service"
			;;
		*)
			arch-chroot /mnt systemctl enable "${service}.service"
			;;
		esac
	done
	pressanykey
}

# AUR HELPER
function install_aur_helper() {
	message="Do you want to install any AUR helpers?"
	if whiptail --backtitle "${backmessage}" --title "AUR Helper" \
		--yesno "${message}" 7 0 3>&1 1>&2 2>&3; then
		AUR_HELPER=$(whiptail --backtitle "${backmessage}" --title "AUR Helper" \
			--radiolist "Select your desired AUR helper:" 0 0 0 \
			"paru" "A feature packed AUR helper, written in Rust" off \
			"paru-bin" "A feature packed AUR helper, written in Rust (Binary)" off \
			"yay" "Yet Another Yogurt - An AUR helper, written in Go" off \
			"yay-bin" "Yet Another Yogurt - An AUR helper written in Go (Binary)" on \
			"trizen" "A lightweight wrapper for AUR, written in Perl" off \
			"pikaur" "An AUR helper with minimal dependencies, written in Python" off \
			"pakku" "A pacman wrapper with AUR support, written in Nim" off \
			"aurman" "An AUR helper with almost pacman syntax, written in Python" off \
			"aura" "A secure, multilingual package manager for Arch Linux and the AUR, written in Haskell" off \
			3>&1 1>&2 2>&3)
		AUR_HELPER=${AUR_HELPER:='yay-bin'}

		clear
		print_step "Installing '${AUR_HELPER}' AUR helper"

		sed -i 's/^[#[:space:]]*%wheel/%wheel/g' /mnt/etc/sudoers
		execute_user "${SUDO_USER}" "cd /home/${SUDO_USER}/ && git clone https://aur.archlinux.org/${AUR_HELPER}.git && (cd ${AUR_HELPER} && makepkg -si --noconfirm --needed) && rm -rf ${AUR_HELPER}"
		sed -i 's/^\(%wheel[[:space:]]*ALL=(ALL)[[:space:]]*NOPASSWD:[[:space:]]*ALL\)$/# \1/g' /mnt/etc/sudoers
		sed -i 's/^\(%wheel[[:space:]]*ALL=(ALL:ALL)[[:space:]]*NOPASSWD:[[:space:]]*ALL\)$/# \1/g' /mnt/etc/sudoers

		pressanykey
	else
		return 0
	fi
}

# EXECUTE USER COMMANDS
function execute_user() {
	local USERNAME="$1"
	local COMMAND="$2"
	arch-chroot /mnt bash -c "su -s /usr/bin/bash -c \"${COMMAND}\" -l \"${USERNAME}\""
	# arch-chroot /mnt bash -c "runuser - \"${USERNAME}\" -c \"${COMMAND}\""
	# arch-chroot /mnt bash -c "runuser -u \"${USERNAME}\" -- bash -c \"${COMMAND}\""
}

# INSTALL GRUB BOOT LOADER
function install_grub() {
	clear
	print_step "Installing GRUB boot loader"
	arch-chroot /mnt pacman -S --noconfirm --needed grub os-prober

	# Grub gets installed differently on efi & non-efi systems
	if efi_boot_mode; then
		arch-chroot /mnt pacman -S --noconfirm --needed efibootmgr dosfstools
		arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
	else
		arch-chroot /mnt grub-install --target=i386-pc "${DISK}"
	fi

	# Create the grub.cfg file
	arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

	pressanykey
}

###################  CONFIGURATION FUNCTIONS  ####################

# GENERATE FSTAB
function gen_fstab() {
	TERM=ansi whiptail --backtitle "${backmessage}" --title "System Configuration" \
		--infobox "Generating fstab..." 10 70
	genfstab -U /mnt >>/mnt/etc/fstab
	sleep 3

	# Take a look at the new fstab file
	whiptail --backtitle "${backmessage}" --title "Generated fstab" \
		--textbox /mnt/etc/fstab --scrolltext 0 0
}

# FUNCTION TO EDIT THE FILE
function edit_file() {
	local file_path=$1
	if whiptail --backtitle "${backmessage}" --title "${file_path}" \
		--yesno "Do you want to edit anything?" 10 70; then
		# Create a temporary file to hold the edited content
		temp_file=/mnt/tmp/file.tmp

		# Copy the content of the original file to the temporary file
		cp /mnt"${file_path}" "${temp_file}"

		# Open a text editor (you can change "nano" to your preferred editor)
		nano "${temp_file}"

		# Prompt the user to save the changes
		if whiptail --backtitle "${backmessage}" --title "${file_path}" \
			--yesno "Do you want to save the changes?" 10 70; then

			# If the user chooses to save the changes, overwrite the original file
			cp "${temp_file}" /mnt"${file_path}"
			whiptail --backtitle "${backmessage}" --title "${file_path}" \
				--msgbox "Changes saved successfully!" 10 70
		else
			whiptail --backtitle "${backmessage}" --title "${file_path}" \
				--msgbox "Changes discarded." 10 70
		fi

		# Remove the temporary file
		rm "${temp_file}"
	fi
}

# TIMEZONE
function timezone_setup() {
	TERM=ansi whiptail --backtitle "${backmessage}" --title "System Configuration" \
		--infobox "Setting Timezone to '${TIMEZONE}'..." 10 70
	sleep 2
	arch-chroot /mnt ln -sf "/usr/share/zoneinfo/${TIMEZONE}" /etc/localtime &>/dev/null
	arch-chroot /mnt hwclock --systohc &>/dev/null

	message=$(arch-chroot /mnt date)
	whiptail --backtitle "${backmessage}" --title "HW Clock & Timezone" \
		--infobox "${message}" 7 0
	sleep 2
}

# LOCALE
function locale_setup() {
	LOCALE=${LOCALE:="en_US.UTF-8"}
	sleep 1

	message="Setting locale to '${LOCALE}'...\n"
	TERM=ansi whiptail --backtitle "${backmessage}" --title "System Configuration" \
		--infobox "${message}" 10 70
	sleep 1
	sed -i "s/^[#[:space:]]*${LOCALE}/${LOCALE}/g" /mnt/etc/locale.gen
	arch-chroot /mnt locale-gen &>/dev/null

	message+="\nLANG=${LOCALE}"
	TERM=ansi whiptail --backtitle "${backmessage}" --title "System Configuration" \
		--infobox "${message}" 10 70
	sleep 1
	echo "LANG=${LOCALE}" | tee /mnt/etc/locale.conf &>/dev/null

	message+="\nLC_TIME=C"
	TERM=ansi whiptail --backtitle "${backmessage}" --title "System Configuration" \
		--infobox "${message}" 10 70
	sleep 2
	echo "LC_TIME=C" | tee -a /mnt/etc/locale.conf &>/dev/null

	export LANG="${LOCALE}"
}

# CONSOLE FONT & KEYMAP
function console_setup() {
	message="Setting the console font and keymap...\n"
	TERM=ansi whiptail --backtitle "${backmessage}" --title "System Configuration" \
		--infobox "${message}" 10 70
	sleep 1

	message+="\nKEYMAP=${KEYBOARD}"
	TERM=ansi whiptail --backtitle "${backmessage}" --title "System Configuration" \
		--infobox "${message}" 10 70
	sleep 1
	echo "KEYMAP=${KEYBOARD}" | tee /mnt/etc/vconsole.conf &>/dev/null

	message+="\nFONT=ter-v18b"
	TERM=ansi whiptail --backtitle "${backmessage}" --title "System Configuration" \
		--infobox "${message}" 10 70
	sleep 2
	echo 'FONT=ter-v18b' | tee -a /mnt/etc/vconsole.conf &>/dev/null
}

# PACMAN CONFIGURATION ARCH CHROOT
function pacman_configuration_chroot() {
	clear
	print_step "pacman configuration"

	# Add color
	sed -i 's/^[#[:space:]]*Color/Color\nILoveCandy/' /mnt/etc/pacman.conf
	# Add parallel downloading
	sed -i 's/^[#[:space:]]*ParallelDownloads.*/ParallelDownloads = 5/' /mnt/etc/pacman.conf
	# Enable multilib
	sed -i "/\[multilib\]/,/Include/"'s/^#//' /mnt/etc/pacman.conf
	# Update database
	arch-chroot /mnt pacman -Sy

	pressanykey
}

# EDIT MKINITCPIO CONFIGURATION FILE
function mkinitcpio_conf() {
	clear
	print_step "Initramfs"

	if [[ ${FILESYSTEM} == btrfs ]]; then
		sed -i 's/^MODULES=()/MODULES=(btrfs)/' /mnt/etc/mkinitcpio.conf
	fi
	sed -i 's/^BINARIES=()/BINARIES=(setfont)/' /mnt/etc/mkinitcpio.conf
	# sed -i 's/^\(HOOKS=["(]*base .*\) keymap consolefont \(.*\)$/\1 sd-vconsole \2/g' /mnt/etc/mkinitcpio.conf
	sed -i '/^HOOKS=/s/autodetect\( \|$\)/autodetect microcode\1/g' /mnt/etc/mkinitcpio.conf
	sed -i 's/^[#[:space:]]*COMPRESSION="zstd"/COMPRESSION="zstd"/' /mnt/etc/mkinitcpio.conf
	arch-chroot /mnt mkinitcpio -P

	pressanykey
}

# HOSTNAME
function hostname_setup() {
	HOSTNAME=$(whiptail --backtitle "${backmessage}" --title "Hostname" \
		--inputbox "Please enter the hostname for this system:" 8 60 3>&1 1>&2 2>&3)

	echo "${HOSTNAME}" | tee /mnt/etc/hostname &>/dev/null

	tee /mnt/etc/hosts &>/dev/null <<HOSTS
127.0.0.1      localhost
::1            localhost
127.0.1.1      ${HOSTNAME}.localdomain     ${HOSTNAME}
HOSTS

	message=$(printf "> /etc/hostname and /etc/hosts files configured...\n\n" && echo)
	message+=$(printf "\n\n==================\n[*] /etc/hostname:\n==================\n\n" && cat /mnt/etc/hostname)
	message+=$(printf "\n\n==================\n[*] /etc/hosts:\n==================\n\n" && cat /mnt/etc/hosts)
	whiptail --backtitle "${backmessage}" --title "/etc/hostname & /etc/hosts" \
		--msgbox "${message}" 0 0
}

# ROOT PASSWORD
function root_password() {
	if PASSWORD1=$(whiptail --backtitle "${backmessage}" --title "Root Password" \
		--passwordbox "Please enter the root password:" 8 60 3>&1 1>&2 2>&3) &&
		PASSWORD2=$(whiptail --backtitle "${backmessage}" --title "Root Password" \
			--passwordbox "Confirm password:" 8 60 3>&1 1>&2 2>&3); then
		if [[ ${PASSWORD1} == "${PASSWORD2}" ]]; then
			ROOT_PASSWORD=${PASSWORD1}
			printf "%s\n%s\n" "${ROOT_PASSWORD}" "${ROOT_PASSWORD}" | arch-chroot /mnt passwd &>/dev/null
			#echo -e "${ROOT_PASSWORD}\n${ROOT_PASSWORD}" | arch-chroot /mnt passwd &>/dev/null
		else
			TERM=ansi whiptail --backtitle "${backmessage}" --title "Root Password" \
				--infobox "Passwords do not match.\nTry again." 8 60
			sleep 2
			root_password
		fi
	else
		TERM=ansi whiptail --backtitle "${backmessage}" --title "Root Password" \
			--infobox "No password set.\nTry again." 8 60
		sleep 2
		root_password
	fi
}

# USER PASSWORD
function user_password() {
	if PASSWORD1=$(whiptail --backtitle "${backmessage}" --title "User Password" \
		--passwordbox "Choose a password for the new user:" 8 60 3>&1 1>&2 2>&3) &&
		PASSWORD2=$(whiptail --backtitle "${backmessage}" --title "User Password" \
			--passwordbox "Confirm password:" 8 60 3>&1 1>&2 2>&3); then
		if [[ ${PASSWORD1} == "${PASSWORD2}" ]]; then
			USER_PASSWORD=${PASSWORD1}
			printf "%s\n%s\n" "${USER_PASSWORD}" "${USER_PASSWORD}" | arch-chroot /mnt passwd "${SUDO_USER}" &>/dev/null
			#echo -e "${USER_PASSWORD}\n${USER_PASSWORD}" | arch-chroot /mnt passwd "${SUDO_USER}" &>/dev/null
		else
			TERM=ansi whiptail --backtitle "${backmessage}" --title "User Password" \
				--infobox "Passwords do not match.\nTry again." 8 60
			sleep 2
			user_password
		fi
	else
		TERM=ansi whiptail --backtitle "${backmessage}" --title "User Password" \
			--infobox "No password set.\nTry again." 8 60
		sleep 2
		user_password
	fi
}

# ADD USER ACCOUNT
function add_user_account() {

	sed -i 's/^[#[:space:]]*%wheel/%wheel/g' /mnt/etc/sudoers
	sed -i 's/^\(%wheel[[:space:]]*ALL=(ALL)[[:space:]]*NOPASSWD:[[:space:]]*ALL\)$/# \1/g' /mnt/etc/sudoers
	sed -i 's/^\(%wheel[[:space:]]*ALL=(ALL:ALL)[[:space:]]*NOPASSWD:[[:space:]]*ALL\)$/# \1/g' /mnt/etc/sudoers

	SUDO_USER=$(whiptail --backtitle "${backmessage}" --title "User Account" \
		--inputbox "Username for your account: " 8 60 3>&1 1>&2 2>&3)

	TERM=ansi whiptail --backtitle "${backmessage}" --title "User Account" \
		--infobox "Adding '${SUDO_USER}' to sudoers..." 10 70

	arch-chroot /mnt useradd -m -g users -G wheel,audio,video,network,storage,rfkill -s /bin/bash "${SUDO_USER}" &>/dev/null
	sleep 3 # Need this so user has time to read infobox above

	user_password
	TERM=ansi whiptail --backtitle "${backmessage}" --title "User Account" \
		--infobox "Password created for '${SUDO_USER}'." 10 70
	sleep 3
}

# SWAPPINESS VALUE
function decrease_swappiness() {
	if [[ ${SWAP} == true || ${SWAPFILE} == true ]]; then
		clear
		print_step "Decreasing swappiness value"
		echo "vm.swappiness=10" | tee -a /mnt/etc/sysctl.d/99-swappiness.conf

		pressanykey
	fi
}

# XORG KEYBOARD CONFIGURATION
function xorg_keyboard_configuration() {
	clear
	print_step "Xorg/Keyboard configuration"

	mkdir -p /mnt/etc/X11/xorg.conf.d
	tee /mnt/etc/X11/xorg.conf.d/00-keyboard.conf <<EOF
# Written by systemd-localed(8), read by systemd-localed and Xorg. It's
# probably wise not to edit this file manually. Use localectl(1) to
# update this file.
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "${KEYBOARD}"
EndSection
EOF

	pressanykey
}

# COPY THE LOG FILES TO THE NEW SYSTEM
function copy_log_files() {
	cp /tmp/*.log "/mnt/home/${SUDO_USER}/"
}

# FINISH INSTALLATION
function finish_installation() {
	TERM=ansi whiptail --backtitle "${backmessage}" --title "Final Steps" \
		--infobox "Finishing the installation..." 11 75
	sleep 3
	decrease_swappiness
	xorg_keyboard_configuration
	enable_services
	mkinitcpio_conf
	print_step "End of installation"
	sleep 3
	copy_log_files
	message="Arch Linux has been installed on your computer."
	message+="\nYou may now restart into your new system, or continue using the live environment."
	message+="\nMake sure to remove the installation media, so that you boot into the new system, rather than restarting the installation."
	message+="\n\nDo you want to reboot now?"
	if whiptail --backtitle "${backmessage}" --title "Installation Complete" \
		--defaultno --yesno "${message}" 13 85; then
		reboot_pc
	else
		check_tasks 13 && startmenu "R"
	fi
}

##################################################################
####################       SCRIPT START       ####################
##################################################################

function startmenu() {
	while true; do
		if menupick=$(
			whiptail --backtitle "${backmessage}" --title "Main Menu" \
				--default-item "$1" --menu "\nChoose the next step in the install process:" 0 63 0 \
				"T" "[${completed_tasks[1]}] Select your timezone" \
				"L" "[${completed_tasks[2]}] Configure locales" \
				"K" "[${completed_tasks[3]}] Configure the keyboard" \
				"C" "[${completed_tasks[4]}] Check the connection and date" \
				"D" "[${completed_tasks[5]}] Partition disks" \
				"B" "[${completed_tasks[6]}] Install the base system" \
				"O" "[${completed_tasks[7]}] Configure the system" \
				"H" "[${completed_tasks[8]}] Hostname" \
				"U" "[${completed_tasks[9]}] Set up users and passwords" \
				"S" "[${completed_tasks[10]}] Select and install software" \
				"A" "[${completed_tasks[11]}] Select and install AUR helper" \
				"G" "[${completed_tasks[12]}] Install the Grub boot loader" \
				"F" "[${completed_tasks[13]}] Finish the installation" \
				"R" "[${completed_tasks[14]}] Reboot your computer" \
				"Q" "[${completed_tasks[15]}] Quit the script" 3>&1 1>&2 2>&3
		); then

			case ${menupick} in

			"T")
				change_timezone
				check_tasks 1
				startmenu "L"
				;;

			"L")
				choose_locale
				check_tasks 2
				startmenu "K"
				;;

			"K")
				configure_keyboard
				check_tasks 3
				startmenu "C"
				;;

			"C")
				check_connection &&
					time_date &&
					check_tasks 4 &&
					startmenu "D"
				;;

			"D") diskmenu ;;

			"B")
				install_base
				pacman_configuration_chroot
				install_essential_pkgs
				check_tasks 6 && startmenu "O"
				;;

			"O")
				gen_fstab &&
					edit_file "/etc/fstab" &&
					create_swap_file &&
					timezone_setup &&
					locale_setup &&
					console_setup &&
					check_tasks 7 && startmenu "H"
				;;

			"H")
				hostname_setup && check_tasks 8 && startmenu "U"
				;;

			"U")
				root_password && add_user_account && check_tasks 9 && startmenu "S"
				;;

			"S")
				select_desktop
				install_microcode
				install_drivers
				install_xorg
				install_networking_software
				install_sound_software
				install_bluetooth_software
				install_archive_software
				install_disk_software
				install_printing_software
				install_laptop_software
				install_fonts
				install_pacman_software
				install_desktop
				enable_display_manager
				check_tasks 10 && startmenu "A"
				;;

			"A")
				install_aur_helper && check_tasks 11 && startmenu "G"
				;;

			"G")
				install_grub && check_tasks 12 && startmenu "F"
				;;

			"F")
				finish_installation && check_tasks 13
				;;

			"R")
				reboot_pc
				;;

			"Q")
				quit_script
				;;

			*)
				quit_script
				;;

			esac
		else
			quit_script
		fi
	done
}

function reboot_pc() {
	umount -R /mnt
	TERM=ansi whiptail --backtitle "${backmessage}" --title "Reboot" \
		--infobox "Rebooting in 3s." 7 40
	sleep 1
	TERM=ansi whiptail --backtitle "${backmessage}" --title "Reboot" \
		--infobox "Rebooting in 2s.." 7 40
	sleep 1
	TERM=ansi whiptail --backtitle "${backmessage}" --title "Reboot" \
		--infobox "Rebooting in 1s..." 7 40
	sleep 1
	clear
	reboot now

}

function quit_script() {
	if whiptail --backtitle "${backmessage}" --title "Exit" \
		--defaultno --yesno "Are you sure you want to quit?" 7 0; then
		clear
		exit 0
	else
		startmenu
	fi
}

backmessage='Arch Linux Installer via whiptail utility (ARCHTAIL)'
welcome
pacman_configuration
install_prerequisites
checkpath
validate_pkgs
check_reflector
detect_timezone
startmenu

#!/bin/false

# Declares $PATH
#PATH=$PATH

# Sources defaults
source /usr/local/etc/bashrc

# Color Variables
CYAN="\e[1;36m"
PINK="\e[1;35m"
WHITE="\e[0;1m"
RESET="\e[0m"

BASE_COLOR=$WHITE
COLOR1=$CYAN
COLOR2=$PINK

# Variables for prompt customization
PS1="\[$COLOR1\]\u\[$BASE_COLOR\]@\[$COLOR2\]\h\[$BASE_COLOR\]:\w
\[$BASE_COLOR\]\$> \[$RESET\]"
PS2="\[$BASE_COLOR\] > \[$RESET\]"

# ls always uses color
alias ls="ls --color=always"

# One key config sourcing
alias .="clear && . ~/.bashrc"

# Shows available space in main drive
alias space="df --output='source,size,used,avail,pcent' /dev/sda1"

# Changes lynx.cfg's path to ~/lynx.cfg
alias lynx="lynx -cfg ~/lynx.cfg"

# Helps with managing dotfiles with a bare git repo.
alias config="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# easy vnc setup
alias vnc-start="x11vnc -usepw"

# Location of bootloader config.
BOOTCONF="/mnt/sda1/tce/boot/extlinux/extlinux.conf"

# Location of onboot.lst
ONBOOTLST="/mnt/sda1/tce/onboot.lst"

# Sorts onboot.lst alphabetically
sort-onboot() {
	if [[ -f $ONBOOTLST ]]; then
		sort --ignore-case --output=$ONBOOTLST $ONBOOTLST
		echo "$ONBOOTLST sorted"
	else
		echo "$ONBOOTLST does not exist!" >&2
		echo "No changes made."
		return 1
	fi
}

# Backup and restore onboot.lst
ONBOOTBACKUP="$HOME/onboot.lst.backup"
backup-onboot() {
	if [[ -f $ONBOOTLST ]]; then
		cp $ONBOOTLST $ONBOOTBACKUP
		echo "$ONBOOTLST backed up to $ONBOOTBACKUP"
	else
		echo "$ONBOOTLST does not exist!" >&2
		echo "No changes made."
		return 1
	fi
}
restore-onboot() {
	if [[ -f $ONBOOTBACKUP ]]; then
		cp $ONBOOTBACKUP $ONBOOTLST
		echo $ONBOOTLST restored from $ONBOOTBACKUP
	else
		echo "$ONBOOTBACKUP does not exist!" >&2
		echo "No changes made."
		return 1
	fi
}

# Changes the default shell to bash in Tiny Core Linux
change_shell() {
	which bash | sudo tee -a /etc/shells > /dev/null
	sudo sed -i '/^derpsquid:/s#:[^:]\+$#:/usr/local/bin/bash#' /etc/passwd
}

# Sets up ssh-agent and adds ssh key at default location
ssh-setup(){
	eval "$(ssh-agent -s)" && ssh-add
}

# Variables to minimize repetition in below commands
color_punct() {
	echo "$COLOR1$1$COLOR2"
}
COLON=$(color_punct :)
COMMA=$(color_punct ,)
PERIOD=$(color_punct .)

# Prints the date and time in bold white
echo -e "${BASE_COLOR}Tiny Core Linux Version $COLOR2$(version)"
echo -e "${BASE_COLOR}Welcome back, $COLOR1$USER$COLOR2!"
echo -e $(date +"${BASE_COLOR}Today is $COLOR2%A$COMMA %B %d$COMMA %Y$BASE_COLOR$PERIOD")
echo -e $(date +"${BASE_COLOR}The current time is $COLOR2%I$COLON%M$COLON%S$COLON%N %p$PERIOD")
echo -e "$RESET"

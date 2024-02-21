# Archtail

This is a fork of the original [Archtail](https://github.com/deepbsd/Archtail) project created by [deepbsd](https://github.com/deepbsd).

## Description

Archtail is an Arch Linux installer using `whiptail`.\
It's supposed to be a simple Arch Linux installer for the masses. But mainly it was an excuse for the [deepbsd](https://github.com/deepbsd) to learn whiptail.

To install whiptail:

```bash
sudo pacman -S libnewt
```

To use this script, run this command from your freshly booted archiso image:

```bash
curl -O https://raw.githubusercontent.com/anisbsalah/archtail/main/archtail.sh
```

It will be best if you use three different tty's:\
1- Open the script in your editor on tty1.\
2- Run the script ( `bash archtail.sh` ) on tty2.\
3- On tty3 you can watch the installation progress by tailing the install log: `tail -f /tmp/install.log`.

- A single command quicklaunch:

```bash
bash <(curl -L https://github.com/anisbsalah/archtail/raw/main/archtail.sh)
```

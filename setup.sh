#!/bin/sh
#
# CannyOS cannyos-hardware-raspi setup script
#
# https://github.com/intlabs/cannyos-hardware-raspi
#
# Copyright 2014 Pete Birley
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# curl https://raw.githubusercontent.com/intlabs/cannyos-hardware-raspi/master/setup.sh | sh

clear
curl https://raw.githubusercontent.com/intlabs/cannyos-hardware-raspi/master/CannyOS/CannyOS.splash
#     *****************************************************
#     *                                                   *
#     *        _____                    ____  ____        *
#     *       / ___/__ ____  ___  __ __/ __ \/ __/        *
#     *      / /__/ _ `/ _ \/ _ \/ // / /_/ /\ \          *
#     *      \___/\_,_/_//_/_//_/\_, /\____/___/          *
#     *                         /___/                     *
#     *                                                   *
#     *                                                   *
#     *****************************************************
echo "*                                                   *"
echo "*      Rasberry Pi - Arch Linux Setup Script        *"
echo "*                                                   *"
echo "*****************************************************"
echo ""

# Add new user
useradd -m -s /bin/bash user
echo 'user:acoman' | chpasswd

pacman-key --init && \
pacman -Syu --noconfirm && \
pacman -S --noconfirm mesa xf86-video-fbdev xf86-video-vesa && \
pacman -S --noconfirm xorg-xinit xorg-server xorg-server-utils xterm && \
pacman -S --noconfirm openbox midori && \
pacman -S --noconfirm slim && \
systemctl enable slim.service && \
systemctl enable graphical.target

# Set Up Slim for autologin
printf "default_user        user\n" >> /etc/slim.conf
printf "focus_password      yes\n" >> /etc/slim.conf
printf "auto_login          yes\n" >> /etc/slim.conf

#Set up x init and bash profile for user
curl https://raw.githubusercontent.com/intlabs/cannyos-hardware-raspi/master/root/xinitrc.sh >> /home/user/.xinitrc
chmod +x /home/user/.xinitrc
curl https://raw.githubusercontent.com/intlabs/cannyos-hardware-raspi/master/root/bash_profile >> /home/user/.bash_profile

reboot


pacman -S alsa-utils alsa-firmware alsa-lib alsa-plugins --noconfirm 

#Set sound output channel (0 for Auto, 1 for Analog out, 3 for HDMI)
amixer cset numid=1 x

#Caveats for HDMI audio
#Some applications require a setting in /boot/config.txt to force audio over HDMI:
#hdmi_drive=2
reboot


echo "Install Docker"
pacman -Syy --noconfirm && \
pacman -S --noconfirm  docker && \
systemctl start docker && \
systemctl enable docker && \
sysctl -w net.ipv4.ip_forward=1 && \
docker -d &

#echo "pull base image"
#docker pull resin/rpi-raspbian




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



echo "Run this script as root only."
pacman-key --init && \
pacman -Syu --noconfirm && \
pacman -S --noconfirm xorg-xinit xorg-server xorg-server-utils xterm && \
pacman -S --noconfirm xfce4 && \
pacman -S --noconfirm mesa xf86-video-fbdev xf86-video-vesa && \
pacman -S --noconfirm slim && \
systemctl enable slim.service && \
systemctl enable graphical.target

curl https://raw.githubusercontent.com/intlabs/cannyos-hardware-raspi/master/root/xinitrc >> ~/.xinitrc
curl https://raw.githubusercontent.com/intlabs/cannyos-hardware-raspi/master/root/bash_profile >> ~/.bash_profile

reboot
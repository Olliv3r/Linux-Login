#!/usr/bin/env python3
# Logos aleatórios
#
# Por oliver
#

import random
import os

root = "/data/data/com.termux/files/home/Linux-Login"

def banner():
    global distro

    regex = 'neofetch --help | tr -d "\n " | grep -Eo "AIX.*Zorin" | sed -e "s/,/\\n/g" | tr -d \\"'
    distros = os.system(regex + str(f" > {root}/distros.txt"))

    distros = open(f"{root}/distros.txt", 'r')

    distro = random.choice(list(distros)).rstrip()

    os.system(f'neofetch --ascii_distro {distro} -L')

def _input():

    if not os.path.exists(f"{root}/.banner"):
        res = input('Apply random logo? y/n\n')

        if res == "y" or res == "yes":
            os.system(f"echo 'on' > {root}/.banner")

        elif res == "n" or res == "no":
            os.system(f"echo 'off' > {root}/.banner")

        else:
            _input()

    else:
        banner()
        print(distro + str("\n"))


_input()

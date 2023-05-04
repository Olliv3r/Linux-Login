#!/usr/bin/env python3
# Logos aleatórios
#
# Por oliver
#

import random
import os

def banner():
    regex = 'neofetch --help | tr -d "\n " | grep -Eo "AIX.*Zorin" | sed -e "s/,/\\n/g" | tr -d \\"'
    distros = os.system(regex + " > distros.txt")

    distros = open('distros.txt', 'r')

    distro = random.choice(list(distros)).rstrip()

    os.system(f'neofetch --ascii_distro {distro} -L')

def _input():

    if not os.path.exists('.banner'):
        res = input('Apply random logo? y/n\n')

        if res == "y" or res == "yes":
            os.system('echo "on" > .banner')
    
        elif res == "n" or res == "no":
            os.system('echo "off" > .banner')

        else:
            _input()

    else:
        
        banner()


_input()

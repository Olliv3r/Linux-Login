import random
import os

regex = 'neofetch --help | tr -d "\n " | grep -Eo "AIX.*Zorin" | sed -e "s/,/\\n/g" | tr -d \\"'
distros = os.system(regex + " > distros.txt")

distros = open('distros.txt', 'r')

distro = random.choice(list(distros)).rstrip()

os.system(f'neofetch --ascii_distro {distro} -L')

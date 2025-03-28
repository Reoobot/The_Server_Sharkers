#!/bin/bash

#This command creates users for the game.

echo "[+] Creando usuarios Manolo y Lucy..."
useradd -m -s /bin/bash manolo
echo 'manolo:Password123' | chpasswd
useradd -m -s /bin/bash lucy
echo 'lucy:Password123' | chpasswd
usermod -aG sudo lucy

echo "[+] Usuarios creados."

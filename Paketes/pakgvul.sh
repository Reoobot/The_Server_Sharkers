#!/bin/bash

echo "[+] Instalando paquetes vulnerables..."
apt update && apt install -y xrdp vsftpd netcat motion apache2 php
echo "[+] Instalación completada."

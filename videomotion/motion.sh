#!/bin/bash

# ==============================
# 🔹 CONFIGURACIÓN INICIAL
# ==============================
echo "[+] Instalando paquetes necesarios..."
apt update && apt install -y v4l2loopback-utils ffmpeg motion xrdp vsftpd netcat

# ==============================
# 🔹 CREAR CÁMARA VIRTUAL
# ==============================
echo "[+] Creando cámara virtual..."
modprobe v4l2loopback devices=1 video_nr=10 card_label="FakeCamera"

# ==============================
# 🔹 CONFIGURAR MOTION
# ==============================
echo "[+] Configurando Motion..."
sed -i 's|videodevice /dev/video0|videodevice /dev/video10|' /etc/motion/motion.conf

# Habilitar acceso remoto a Motion
echo "webcontrol_localhost off" >> /etc/motion/motion.conf

# Reiniciar Motion
systemctl enable motion
systemctl restart motion

# ==============================
# 🔹 CREAR RUTA PARA EL VIDEO
# ==============================
echo "[+] Creando carpeta para el video..."
VIDEO_PATH="/home/ubuntu/videos/video.mp4"
mkdir -p /home/ubuntu/videos

# Verificar si el video existe
echo "[+] Verificando si el video existe..."
if [ ! -f "$VIDEO_PATH" ]; then
    echo "[!] No se encontró video.mp4, creando un video de prueba..."
    ffmpeg -f lavfi -i testsrc=duration=10:size=640x480:rate=30 "$VIDEO_PATH"
fi

# ==============================
# 🔹 INICIAR STREAMING EN BUCLE
# ==============================
echo "[+] Iniciando transmisión del video..."
while true; do
    ffmpeg -re -stream_loop -1 -i "$VIDEO_PATH" -f v4l2 /dev/video10
    sleep 1
done &

echo "[+] Configuración completada. Puedes ver el video en: http://$(hostname -I | awk '{print $1}'):8081"

#!/bin/bash

# ==============================
# 🔹 INSTALACIÓN DE PAQUETES NECESARIOS
# ==============================
echo "[+] Instalando paquetes necesarios..."
apt update && apt install -y xrdp vsftpd netcat motion v4l2loopback-utils gstreamer1.0-tools gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly

# ==============================
# 🔹 CONFIGURAR RDP PARA LUCY
# ==============================
echo "[+] Configurando RDP para Lucy..."
# Habilita el servicio de xRDP (escritorio remoto)
systemctl enable xrdp
systemctl restart xrdp

# ==============================
# 🔹 CONFIGURAR FTP ANÓNIMO (VULNERABLE)
# ==============================
echo "[+] Configurando FTP vulnerable..."
# Habilita acceso anónimo al servidor FTP agregando una línea en el archivo de configuración
echo "anonymous_enable=YES" >> /etc/vsftpd.conf
# Reinicia el servicio FTP para aplicar cambios
systemctl restart vsftpd

# ==============================
# 🔹 CREAR CÁMARA VIRTUAL
# ==============================
echo "[+] Creando cámara virtual..."
modprobe v4l2loopback devices=1 video_nr=10 card_label="FakeCamera"

# ==============================
# 🔹 CONFIGURAR MOTION (SIMULACIÓN DE CÁMARA DE SEGURIDAD)
# ==============================
echo "[+] Configurando Motion para simular la cámara de seguridad..."
# Habilita y arranca el servicio Motion (DVR simulado)
systemctl enable motion
systemctl start motion

# ==============================
# 🔹 CREAR RUTA PARA EL VIDEO
# ==============================
echo "[+] Creando carpeta para el video..."
VIDEO_PATH="/home/ubuntu/videos/video.mp4"
mkdir -p /home/ubuntu/videos

echo "[+] Copia tu video en: $VIDEO_PATH antes de ejecutar el streaming."

# Verificar si el video existe, si no, crear un video de prueba
if [ ! -f "$VIDEO_PATH" ]; then
    echo "[!] No se encontró video.mp4, creando un video de prueba..."
    gst-launch-1.0 videotestsrc num-buffers=300 ! videoconvert ! x264enc ! mp4mux ! filesink location="$VIDEO_PATH"
fi

# ==============================
# 🔹 INICIAR STREAMING EN BUCLE CON GSTREAMER
# ==============================
echo "[+] Iniciando transmisión del video con GStreamer..."
while true; do
    gst-launch-1.0 filesrc location="$VIDEO_PATH" ! decodebin ! videoconvert ! videoscale ! v4l2sink device=/dev/video10
    sleep 1
done &

echo "[+] Configuración completada. Puedes ver el video en: http://$(hostname -I | awk '{print $1}'):8081"

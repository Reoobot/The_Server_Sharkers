#!/bin/bash

# ==============================
# 🔹 CONFIGURACIÓN INICIAL
# ==============================
echo "[+] Creando archivo de script para iniciar el servidor HTTP..."
cat << 'EOF' | sudo tee /etc/init.d/start_http_server
#!/bin/bash
### BEGIN INIT INFO
# Provides:          start_http_server
# Required-Start:    $network $local_fs
# Required-Stop:     $network $local_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Starts an HTTP server to serve video
# Description:       Starts a Python HTTP server to serve video files from /home/ubuntu/videos
### END INIT INFO

case "$1" in
  start)
    echo "Starting Python HTTP server..."
    # Cambiar la ruta para que apunte a ~/game/The_Server_Sharkers/videomotion
    cd ~/game/The_Server_Sharkers/videomotion
    python -m SimpleHTTPServer 8080 &
    ;;
  stop)
    echo "Stopping Python HTTP server..."
    pkill -f 'python -m SimpleHTTPServer'
    ;;
  *)
    echo "Usage: /etc/init.d/start_http_server {start|stop}"
    exit 1
    ;;
esac

exit 0
EOF

# ==============================
# 🔹 HACER EL SCRIPT EJECUTABLE
# ==============================
echo "[+] Haciendo el script ejecutable..."
sudo chmod +x /etc/init.d/start_http_server

# ==============================
# 🔹 AGREGAR EL SCRIPT A LOS SERVICIOS DE INICIO
# ==============================
echo "[+] Agregando el script a los servicios de inicio..."
sudo update-rc.d start_http_server defaults

# ==============================
# 🔹 INICIAR EL SERVIDOR HTTP
# ==============================
echo "[+] Iniciando el servidor HTTP..."
sudo /etc/init.d/start_http_server start

echo "[+] Configuración completa. El servidor HTTP está corriendo en: http://$(hostname -I | awk '{print $1}'):8080"

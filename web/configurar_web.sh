#!/bin/bash

echo "[+] Creando sitio web para OSINT..."
mkdir -p /var/www/html/the_servir_sharkers
cat <<EOF > /var/www/html/the_servir_sharkers/index.html
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="author" content="Lucy Smith, lucy@servirsharkers.com">
    <meta name="keywords" content="shoes, innovation, flying shoes, technology">
    <title>Servir Sharkers - Innovación en calzado</title>
</head>
<body>
    <h1>Bienvenido a The Servir Sharkers</h1>
    <p>Somos una empresa innovadora dedicada a la creación de calzado revolucionario.</p>
    <p>¡Próximamente lanzaremos nuestros zapatos voladores!</p>
    <p>Contacto: soporte@servirsharkers.com</p>
</body>
</html>
EOF

wget -O /var/www/html/the_servir_sharkers/logo.jpg https://upload.wikimedia.org/wikipedia/commons/a/a3/June_odd-eyed-cat_cropped.jpg
exiftool -Comment="Usuario: manolo, Contraseña: CarreraCaballos2024" /var/www/html/the_servir_sharkers/logo.jpg

chown -R www-data:www-data /var/www/html/the_servir_sharkers
chmod -R 755 /var/www/html/the_servir_sharkers

systemctl enable apache2
systemctl restart apache2

echo "[+] Sitio web configurado."

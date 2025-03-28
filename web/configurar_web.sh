#!/bin/bash

echo "[+] Creando sitio web para OSINT..."

# Crear el directorio del sitio web
mkdir -p /var/www/html/the_servir_sharkers

# Crear el archivo index.html con estilos modernos
cat <<EOF > /var/www/html/the_servir_sharkers/index.html
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="author" content="Lucy Smith, lucy@servirsharkers.com">
    <meta name="keywords" content="shoes, innovation, flying shoes, technology">
    <title>Servir Sharkers - Innovación en calzado</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            color: white;
            text-align: center;
            background-image: url('bg.jpg');
            background-size: cover;
            background-position: center;
            margin: 0;
            padding: 0;
        }
        .container {
            background: rgba(0, 0, 0, 0.6);
            width: 60%;
            margin: auto;
            padding: 20px;
            border-radius: 10px;
            margin-top: 100px;
        }
        h1 {
            font-size: 2.5em;
        }
        p {
            font-size: 1.2em;
        }
        img {
            width: 200px; /* Ajusta el tamaño según tu preferencia */
            border-radius: 10px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Bienvenido a The Servir Sharkers</h1>
        <p>Somos una empresa innovadora dedicada a la creación de calzado revolucionario.</p>
        <p>¡Próximamente lanzaremos nuestros zapatos voladores!</p>
        <p>Contacto: soporte@servirsharkers.com</p>
        <!-- Mostrar el logo -->
        <img src="logo.jpeg" alt="Logo de Servir Sharkers">
    </div>
</body>
</html>
EOF

# Descargar la imagen de fondo
wget -O /var/www/html/the_servir_sharkers/bg.jpg "https://images.unsplash.com/photo-1562183241-b937e95585b6?q=80&w=1965&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"

# Asegúrate de que el logo se encuentre en la misma carpeta que index.html
# Aquí solo se agregarán los metadatos si el archivo logo.jpg ya está presente en la carpeta.

# Agregar metadatos ocultos a la imagen del logo (Si el archivo logo.jpg ya está en la carpeta)
exiftool -Comment="Usuario: manolo, Contraseña: Password123" /var/www/html/the_servir_sharkers/logo.jpeg

# Configurar permisos
chown -R www-data:www-data /var/www/html/the_servir_sharkers
chmod -R 755 /var/www/html/the_servir_sharkers

# Habilitar Apache y reiniciar
systemctl enable apache2
systemctl restart apache2

echo "[+] Sitio web configurado."

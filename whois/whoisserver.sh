#!/bin/bash

# Definir nombres de archivos
WHOIS_SCRIPT="$HOME/whois_the_server_sharkers.com"
DATABASE_FILE="$HOME/whois_database.txt"

# Paso 1: Crear la base de datos con dominios falsos
echo "Creando base de datos de WHOIS falso en $DATABASE_FILE..."
cat > "$DATABASE_FILE" <<EOL
Domain Name: SHARKERS.COM
Registry Domain ID: 1234567890_DOMAIN_COM-VRSN
Registrar WHOIS Server: whois.registrar.com
Registrar URL: http://www.registrar.com
Updated Date: 2023-04-15T09:38:28Z
Creation Date: 2000-05-10T12:00:00Z
Registrar Registration Expiration Date: 2025-05-10T12:00:00Z
Registrar: Registrar, Inc.
Registrant Name: Juan Pérez
Registrant Organization: Sharkers Corp
Registrant Street: Calle Ficticia 123
Registrant City: Ciudad Ejemplo
Registrant Country: ES
DNS Servers:
- ns1.sharkers.com
- ns2.sharkers.com
===
Domain Name: EXAMPLE.COM
Registry Domain ID: 9876543210_DOMAIN_COM-VRSN
Registrar WHOIS Server: whois.example.com
Registrar URL: http://www.example.com
Updated Date: 2022-03-10T05:20:30Z
Creation Date: 1999-07-15T18:30:00Z
Registrar Registration Expiration Date: 2026-07-15T18:30:00Z
Registrar: Example Registrar, Inc.
Registrant Name: María González
Registrant Organization: Example Ltd.
Registrant Street: Avenida Principal 456
Registrant City: Ciudad Falsa
Registrant Country: MX
DNS Servers:
- ns1.example.com
- ns2.example.com
===
EOL
echo "Base de datos creada ✅"

# Paso 2: Crear el script whois_the_server_sharkers.com
echo "Creando script de WHOIS falso en $WHOIS_SCRIPT..."
cat > "$WHOIS_SCRIPT" <<'EOL'
#!/bin/bash

DATABASE_FILE="$HOME/whois_database.txt"
DEFAULT_DOMAIN="sharkers.com"

# Si no se especifica un dominio, usa por defecto "sharkers.com"
DOMAIN=${1:-$DEFAULT_DOMAIN}

# Buscar el dominio en la base de datos
DOMAIN_INFO=$(awk -v domain="$DOMAIN" 'BEGIN {RS="==="} $0 ~ domain' "$DATABASE_FILE")

# Verificar si se encontró el dominio
if [ -z "$DOMAIN_INFO" ]; then
    echo "Error: No hay información simulada para el dominio $DOMAIN."
    exit 1
fi

# Mostrar la información del dominio
echo "$DOMAIN_INFO"
EOL
chmod +x "$WHOIS_SCRIPT"
echo "Script WHOIS falso creado ✅"

# Paso 3: Configurar alias para que "whois the server sharkers.com" ejecute el script
echo "Configurando alias para WHOIS..."
ALIAS_CMD="alias 'whois the server sharkers.com'='bash $WHOIS_SCRIPT'"
if ! grep -q "$ALIAS_CMD" "$HOME/.bashrc"; then
    echo "$ALIAS_CMD" >> "$HOME/.bashrc"
    echo "$ALIAS_CMD" >> "$HOME/.bash_profile"
fi
echo "Alias creado ✅"

# Recargar configuración para que el alias esté disponible de inmediato
source "$HOME/.bashrc"

echo "¡Configuración completa! Ahora puedes usar 'whois the server sharkers.com' para consultar información simulada de sharkers.com."

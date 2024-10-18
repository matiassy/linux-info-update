#!/bin/bash

# Definir el archivo de salida
archivo_salida="sistema_info.txt"

# Obtener información del archivo /etc/*release
echo "Sistema operativo:" > "$archivo_salida"
cat /etc/*release >> "$archivo_salida"

# Listar paquetes actualizables
echo "Lista de actualizaciones:" >> "$archivo_salida"
apt list --upgradable >> "$archivo_salida"

# Detectar si el sistema es Proxmox y obtener la versión de PVE
if command -v pveversion >/dev/null 2>&1; then
    echo "Versión de PVE (Proxmox):" >> "$archivo_salida"
    pveversion >> "$archivo_salida" 2>&1
fi

# Mensaje de finalización
echo "La información se ha guardado en $archivo_salida"

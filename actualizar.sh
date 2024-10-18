#!/bin/bash

# Definir el archivo de salida
archivo_salida="sistema_info.txt"

# Obtener información del archivo /etc/*release
echo "Información de /etc/*release:" > "$archivo_salida"
cat /etc/*release >> "$archivo_salida"
echo -e "\n----------------------------------------" >> "$archivo_salida"

# Actualizar la lista de paquetes
echo "Actualizando la lista de paquetes..." >> "$archivo_salida"
apt update >> "$archivo_salida" 2>&1
echo -e "\n----------------------------------------" >> "$archivo_salida"

# Listar paquetes actualizables
echo "Paquetes actualizables:" >> "$archivo_salida"
apt list --upgradable >> "$archivo_salida"
echo -e "\n----------------------------------------" >> "$archivo_salida"

# Obtener la versión de PVE
echo "Versión de PVE (Proxmox):" >> "$archivo_salida"
pveversion >> "$archivo_salida" 2>&1
echo -e "\n----------------------------------------" >> "$archivo_salida"

# Mensaje de finalización
echo "La información se ha guardado en $archivo_salida"

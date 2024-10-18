#!/bin/bash

# Variables personalizadas

nombre_sistema=$(hostname)  # Obtener el nombre del sistema (servidor o instancia)
fecha=$(date +"%A %d/%m/%Y")  # Fecha actual
directorio_actual=$(pwd)  # Obtener el directorio actual
archivo_salida="../sistema_info.txt"  # Guardar un directorio antes
echo "___________________________________________________________________________________________________________________________________"
# Escribir encabezado en el archivo de salida
{
    echo "LOCACION: $locacion"
    echo "FECHA: $fecha"
    echo "Actualización de servidor e instancias:"
    echo "___________________________________________________________________________________________________________________________________"
    
    # Si es Proxmox, mostrar información específica
    if command -v pveversion >/dev/null 2>&1; then
        echo "SERVIDOR: $nombre_sistema"
    else
        echo "Instancia: $nombre_sistema"
    fi

    # Información del sistema operativo
    echo "Sistema operativo:"
    cat /etc/*release
    
    # Listar paquetes actualizables
    echo -e "\nLista de actualizaciones:"
    apt list --upgradable 2>/dev/null | grep -v "Listing..."  # Ignorar la primera línea con "Listing..."
    
    # Si es Proxmox, obtener la versión de PVE
    if command -v pveversion >/dev/null 2>&1; then
        echo -e "\nVersión Proxmox:"
        pveversion 2>&1
    fi

} > "$archivo_salida"

# Volver un directorio
cd ..

# Eliminar la carpeta linux-info-update
rm -rf "$directorio_actual"

# Mensaje de finalización
echo "La información se ha guardado en $archivo_salida y se eliminó la carpeta linux-info-update"

#!/bin/bash

# Variables personalizadas
locacion="REEMPLAZAR"
nombre_sistema=$(hostname)  # Obtener el nombre del sistema (servidor o instancia)
fecha=$(date +"%A %d/%m/%Y")  # Fecha actual
directorio_salida=$(dirname "$(pwd)")  # Guardar en un directorio antes del actual
archivo_salida="$directorio_salida/sistema_info.txt"  # Archivo de salida en un directorio antes

# Escribir encabezado en el archivo de salida
{
    echo "___________________________________________________________________________________________________________________________________"
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

# Mensaje de finalización
echo "La información se ha guardado en $archivo_salida"

# Volver al directorio superior y eliminar la carpeta linux-info-update
cd "$directorio_salida"
rm -rf linux-info-update

# Confirmación de eliminación
echo "Se eliminó la carpeta linux-info-update"

# Volver al directorio padre nuevamente para ver el archivo
cd

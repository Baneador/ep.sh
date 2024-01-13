#!/bin/bash

# Verificar si se proporciona el nombre del archivo como argumento
if [ -z "$1" ]; then
    echo "Uso: $0 <archivo_nmap>"
    exit 1
fi

archivo_nmap="$1"

# Verificar si el archivo existe
if [ ! -f "$archivo_nmap" ]; then
    echo "El archivo $archivo_nmap no existe."
    exit 1
fi

# Extraer puertos utilizando grep y awk
puertos=$(grep -oP '\d+/open' "$archivo_nmap" | awk -F/ '{print $1}' | tr '\n' ',' | sed 's/,$//')

# Verificar si hay puertos antes de copiar al portapapeles
if [ -n "$puertos" ]; then
    echo -n "$puertos" | xclip -selection clipboard
    echo "Puertos copiados al portapapeles: $puertos"
else
    echo "No se encontraron puertos abiertos en la captura de nmap."
fi

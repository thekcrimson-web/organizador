#!/bin/bash

#verificar que se haya dado un directorio 

if [ -z "$1"  ]; then 
  echo "Error: No ha especificado un directorio"
  echo "Uso:$0 <directorio>"
  exit 1
fi

#Verifica que ya exista el directorio

if [ ! -d "$1" ]; then
  echo "Error:El Directorio '$1' no existe"
  exit 1
fi

#Guarda el directorio que se da 

DIRECTORIO="$1"

#Fecha actual

FECHA=$(date +%Y-%m-%d)

#Crea la carpeta backup

BACKUP="$DIRECTORIO/backup_$FECHA"
 mkdir -p "$BACKUP"

#contar los archivos 
CONTADOR=0

#Recorre cada archivo .txt  en el directorio
for ARCHIVO in "$DIRECTORIO"/*.txt
do

#verificar que sea un archivo 

if [ -f "$ARCHIVO" ]; then 

 #obtiene solo el nombre del archivob

  NOMBRE=$(basename "$ARCHIVO")

#crea  el nuevo con la fecha 
  NUEVO_NOMBRE="${FECHA}_${NOMBRE}"

#copea el archivo a la carpeta backup

  cp "$ARCHIVO" "$BACKUP/$NUEVO_NOMBRE"

#aumenta el contador 
  CONTADOR=$((CONTADOR +1))

  echo "copiado: $NOMBRE -> $NUEVO_NOMBRE"

fi
done

#crea el archivo.log
{ 
   echo "========================="
   echo "    Resumen de backup    "
   echo "========================="
   echo "Directorio: $DIRECTORIO"
   echo "Fecha: $FECHA"
   echo ""
   echo "Archivos .txt Copiados"

#lista de archivos cp
   for ARCHIVO_BACKUP in  "$BACKUP"/*.txt
   do
      if [ -f "$ARCHIVO_BACKUP" ]; then
         basename "$ARCHIVO_BACKUP"
      fi
  done
   echo ""
   echo "Total de acrchivos.txt: $CONTADOR"
   echo "=========================="
}> "$BACKUP/resumen.log"


echo ""
echo"----------------------------------"
echo "Backup completado correctamente"
echo "Archivos copiados: $CONTADOR"
echo "Carpeta creada: $BACKUP"
echo "Resumen: $BACKUP/resumen.log"
echo "---------------------------------"

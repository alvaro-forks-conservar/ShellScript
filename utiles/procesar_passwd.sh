#/bin/bash
#J. Enrique Agudo
#Busca un usuario y muestra su información de /etc/passwd
if [ $# -ne 1 ]; then
  echo "USO: $0 usuario"
  exit 1
fi

while read linea; do 
  if echo $linea | grep $1 > /dev/null; then
    echo "Nombre:" $(echo $linea | cut -d ":" -f1)
    echo "Password:" $(echo $linea | cut -d ":" -f2)
    echo "UID:" $(echo $linea | cut -d ":" -f3)
    echo "GUID:" $(echo $linea | cut -d ":" -f4)
    datos=$(echo $linea | cut -d ":" -f5)
    if echo $datos | grep "," > /dev/null;then # Si el campo tiene comas, hay más datos
      echo $datos
      echo "  Nombre: " $(echo $datos | cut -d "," -f1)
      echo "  Despacho: " $(echo $datos | cut -d "," -f2)
      echo "  Teléfono trabajo: " $(echo $datos | cut -d "," -f3)
      echo "  Teléfono casa: " $(echo $datos | cut -d "," -f4)
      echo "  Otro: " $(echo $datos | cut -d "," -f5)     
    else  
      echo "Nombre completo:" $datos
    fi
    echo "Home:" $(echo $linea | cut -d ":" -f6)
    echo "Shell:" $(echo $linea | cut -d ":" -f7)
  fi
done < "/etc/passwd"

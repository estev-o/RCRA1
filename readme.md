# Encode.py
El script encode.py soporta tanto un archivo concreto como el directorio donde se encuentran los dominios.
En caso de que se ejecute sobre un directorio lo que hará será codificar los dominios y guardarlos en el directorio de los dominios.
El nombre del archivo del dominio codificado es igual al del dominio sin codificar. Lo unico que cambia es la extensión del archivo:
  dom00.txt -> dom00.lp
```bash
python3 encode.py examples
```
o
```bash
python3 encode.py examples/domXX.txt
```
# Ejecución del solver
El solver está codificado en el archivo yinyangKB.lp.
El siguiente ejemplo muestra como ejecutar el solver sobre el dominio 0:
```bash
clingo 0 yinyangKB.lp examples/dom00.lp
```

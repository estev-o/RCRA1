#AUTORES: Estevo Aldea Arias, Alejandro Fernández Otero
import sys
import os
from os import listdir
import re

#### VARIABLES DEL PROGRAMA ####
filenameRegex = r"^dom\d+.txt"
whiteTemplate = "circle(ROW, COL, white)."
blackTemplate = "circle(ROW, COL, black)."
nTemplate = "#const n=N."
 
# que valores recibira un elemento que este en la primera fila y en la primera columna
# en representacion de clingo (se usa para generar las posiciones del resto de elementos)
rowStart = 1
colStart = 1
###############################

def usage():
    print("Uso: encode.py [<dir> || <file>]")
    print("                                ")
    print("<dir>: directorio con archivos nombrados con formato domXX.txt")
    print("<file>: archivo nombreado con formato domXX.txt")

def changeExtension(filename, ext):
    dotIndex = filename.rfind('.')
    newFilename = filename[:dotIndex] + ext
    return newFilename

def parse(row, col, template):
    template = template.replace("COL", str(col))
    template = template.replace("ROW", str(row))
    return template

def parseChar(char, row, col):
    if char == '0':
        return parse(row, col, whiteTemplate)
    elif char == '1':
        return parse(row,col, blackTemplate)
    else:
        ""

def parseFile(filePath):
    newFilename = changeExtension(filePath, ".lp")
    file = open(filePath, "r")
    newFile = open(newFilename, "w")

    row = rowStart

    for line in file:
        if line == "\n":
            continue
        col = colStart
        
        for char in line:
            parsed = parseChar(char,row,col)
            if parsed:
                newFile.write(parsed + "\n")
            
            col += 1

        row += 1
    
    n = nTemplate.replace("N", str(row-1))
    newFile.write(n + "\n")
    
    newFile.close()
    file.close()

def isDom(filename):
    return re.match(filenameRegex, filename)

def parseDir(path):
    for file in listdir(path):
        if isDom(file):
            parseFile(path + "/" + file)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        usage()
        sys.exit(1)

    path = sys.argv[1]

    if os.path.isdir(path):
        parseDir(path)
        sys.exit(0)
    elif os.path.isfile(path):
        parseFile(path)
        sys.exit(0)
    else :
        usage()
        print("ERROR: " + path + " no es ni un directorio ni un archivo.")
        sys.exit(1)
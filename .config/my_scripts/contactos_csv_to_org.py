#!/usr/bin/env Y
#
#
# Este programa pretende hacer dos cosas
#  - Generar un archivo de contactos en formato org-mode con la información obtenida de exportar los contactos de google en csv
#  - Generar un archivo de cumpleaños para la agenda de org-mode
#

import csv

with open('contacts.csv', 'r') as csvfile:
    lector = csv.reader(csvfile, delimiter=',')
    # lector.next()   ## nos saltamos la linea con los nombres de las variables
    primera = True
    for row in lector:
        if not(primera):
            # row_parts = row.split(",")
            # 0 debería ser nombre
            nombre = row[0]
            cumple = row[14]
            notas = row[25]
            email = row[30]
            phone = row[36]
            address = row[42]
            line = "* {0}\n:PROPERTIES:\n:ADDRESS: {1}\n:BIRTHDAY: {2}\n:EMAIL: {3}\n:PHONE: {4}\n:NOTE: {5}\n:TAGS: :importado\n:NICK: \n:END:\n".format(nombre, address, cumple, email, phone, notas)
            with open("CONTACTOS-IMPORTADOS.org", "a") as org_file:
                org_file.write(line)

            with open("CUMPLES-IMPORTADOS.org", "a") as org_file:
                if cumple:
                    year = cumple.split("-")[0]
                    if not year or year == "-":
                        year = 0000
                    month = cumple.split("-")[1]
                    day = cumple.split("-")[2]
                    line = "* {0}\n%%(org-anniversary {1} {2} {3})\n".format(nombre, year, month, day)
                    org_file.write(line)

        primera = False

#!/bin/bash

function help () {
	echo -e "$1\n"
	echo -e "Configura il display.\n"
	echo -e "USO:"
	echo -e "  $0 -h"
	echo -e "  $0 -l <N_LINES> -c <CHAR_SET>\n"
	echo -e "OPZIONI:"
	echo -e "  -h  mostra questa guida."
	echo -e "  -l  configura il numero di linee; N_LINES può essere 1 o 2."
	echo -e "  -c  configura il charset dei caratteri; CHAR_SET può essere 5x8 o 5x10.\n"
	echo -e "NOTE:"
	echo -e "  lo script utilizza la variabile d'ambiente I2C_BUS per stabilire su quale"
	echo -e "  bus lavorare. Assicurarsi che la variabile sia definita correttamente.\n"
}

if [ "$1" = "-h" ]; then
	help
	exit 0
fi

if [ -z $I2C_BUS ]; then
	help "La variabile d'ambiente I2C_BUS non è definita."
	exit 1
fi

LCD_ADDR="0x27"
REG_ADDR="0x00"

if [ "$1" = "-l" -a "$2" = "1" -a "$3" = "-c" -a "$4" = "5x8" ]; then
	# comunicazione via nibble
	i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x2C
	i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x28
	echo "Nibble OK"	

	# 1 linea e caratteri 5x8
	i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x2C
	i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x28
	i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x0C
	i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x08
	echo -e "Lines: 1\nCharset: 5x8"

elif [ "$1" = "-l" -a "$2" = "1" -a "$3" = "-c" -a "$4" = "5x10" ]; then
        # comunicazione via nibble
        i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x2C
        i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x28
	echo "Nibble OK"

	# 1 linea e caratteri 5x10
	i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x2C
	i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x28
	i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x4C
	i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x48
        echo -e "Lines: 1\nCharset: 5x10"

elif [ "$1" = "-l" -a "$2" = "2" -a "$3" = "-c" -a "$4" = "5x8" ]; then
        # comunicazione via nibble
        i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x2C
        i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x28
	echo "Nibble OK"

        # 2 linee e caratteri 5x8
        i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x2C
        i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x28
        i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x8C
        i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x88
        echo -e "Lines: 2\nCharset: 5x8"

elif [ "$1" = "-l" -a "$2" = "2" -a "$3" = "-c" -a "$4" = "5x10" ]; then
        # comunicazione via nibble
        i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x2C
        i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x28
	echo "Nibble OK"

        # 2 linee e caratteri 5x8 
        i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x2C
        i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0x28
        i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0xCC
        i2cset -y $I2C_BUS $LCD_ADDR $REG_ADDR 0xC8
        echo -e "Lines: 2\nCharset: 5x10"

else
	# errore nei parametri
	help "Errore nei parametri"
	exit 1
fi

exit 0

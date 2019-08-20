#!/bin/bash
#
# versao 1.1
#
# NOME
#   imagesDownloadCSV 
#
# DESCRICAO
#   Fazer download de imagens de uma planilha e compactar.
#
# NOTA
#   Cria pasta para imagens compactadas
#
#
#  MODIFICADO_POR  (DD/MM/YYYY)
#	matheus.barzon	27/07/2018 - Primeira versao
#	matheus.barzon	30/07/2018 - Inserir compactacao de imagem    
#

if [ -z "$1" ] || [ -z "$2" ]
then
  echo "Parameter missed: ./imagesDownloadCSV.sh <name_of_file.csv>"
  exit 1
fi


echo "Initiated execution.."

#Faz download das imagens e salva em pasta - Nao compactado
path_file=`pwd`
if [ ! -e $path_file/ImagesCompressed ]; 
then
	mkdir ImagesCompressed & echo "Creating images folder.."
fi

echo "Download started.."
while read row; do
	column="${row%%;*}" #first column
#	column="${row##*;}" #last column

	wget $column -P $path_file/ImagesCompressed

done < $1
echo "End of download"

echo "Before compression:"
du $path_file/ImagesCompressed

echo "Inicio da compactacao.."

find $path_file/ImagesCompressed -maxdepth 1 -mindepth 1 -exec convert -quality 85 {} {} ";"

echo "End compression"

echo "After compression:"
du $path_file/ImagesCompressed

echo "End execution"











#!/bin/bash

set -e

# Configuraciones
ENV_NAME="venv-pycaret"
PYTHON_BIN="python3.11"

# Verificá que python3.11 exista
if ! command -v $PYTHON_BIN &> /dev/null; then
    echo "Python 3.11 no está instalado. Instalalo con: sudo apt install python3.11 python3.11-venv -y"
    exit 1
fi

# Crear el entorno virtual SIN pip
echo " Creando entorno virtual sin pip: $ENV_NAME"
$PYTHON_BIN -m venv $ENV_NAME --without-pip

# Activar entorno
source $ENV_NAME/bin/activate

# Instalar pip manualmente
echo " Instalando pip manualmente dentro del venv..."
curl -sS https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
rm get-pip.py

# Verificar que pip funcione dentro del entorno
echo " pip está ubicado en: $(which pip)"

# Actualizar pip y setuptools dentro del venv
echo " Actualizando pip y setuptools..."
pip install --upgrade pip setuptools

# Instalar PyCaret
echo " Instalando PyCaret..."
pip install pycaret
pip install pycaret[models]
pip install cuml

# Fin
echo "Entorno '$ENV_NAME' creado y listo para usar."
echo "Para activarlo: source $ENV_NAME/bin/activate"
echo "Luego abrí Jupyter y elegí el kernel: Python (PyCaret)"

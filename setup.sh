#!/bin/bash

set -e

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

rm setup.log

# Redirect all output to both stdout and setup.log
exec > >(tee -a setup.log) 2>&1

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
log "Current script directory: $SCRIPT_DIR"

log "Creating Python virtual environment..."
python -m venv ./install

log "Upgrading pip in the virtual environment..."
./install/bin/python -m pip install --upgrade pip

export CMAKE_PREFIX_PATH=${SCRIPT_DIR}/install:$CMAKE_PREFIX_PATH

export CC=$(which mpicc)
export CXX=$(which mpic++)

log "Building and installing IOR..."
if [ ! -d "${SCRIPT_DIR}/software/ior" ]; then
    log "Cloning IOR repository..."
    git clone https://github.com/hpc/ior.git "${SCRIPT_DIR}/software/ior"
    cd "${SCRIPT_DIR}/software/ior"
    git checkout tags/4.0.0 -b v4.0.0
    cd -
fi
cd software/ior
./bootstrap
./configure --prefix=${SCRIPT_DIR}/install
make -j
make install -j
cd -

log "Checking SQLite version..."
SQLITE_VERSION=$(sqlite3 --version 2>/dev/null | cut -d' ' -f1 || echo "0.0.0")
REQUIRED_VERSION="3.35.0"

# Function to compare versions
version_compare() {
    if [[ $1 == $2 ]]; then
        return 0
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++)); do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++)); do
        if [[ -z ${ver2[i]} ]]; then
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]})); then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]})); then
            return 2
        fi
    done
    return 0
}

set +e  # Temporarily disable exit on error for version comparison
version_compare $SQLITE_VERSION $REQUIRED_VERSION
val=$?
set -e  # Re-enable exit on error
is_custom_sqlite=0
case $val in
    0) log "SQLite version $SQLITE_VERSION is equal to required version $REQUIRED_VERSION" ;;
    1) log "SQLite version $SQLITE_VERSION is greater than required version $REQUIRED_VERSION" ;;
    2) 
        log "SQLite version $SQLITE_VERSION is less than required version $REQUIRED_VERSION"
        log "Installing SQLite 3.50.4..."
        
        cd "${SCRIPT_DIR}/software"
        if [ ! -f "sqlite-autoconf-3500400.tar.gz" ]; then
            log "Downloading SQLite source..."
            wget https://sqlite.org/2025/sqlite-autoconf-3500400.tar.gz
        fi
        
        if [ ! -d "sqlite-autoconf-3500400" ]; then
            log "Extracting SQLite source..."
            tar -xzf sqlite-autoconf-3500400.tar.gz
        fi
        
        cd sqlite-autoconf-3500400
        log "Configuring SQLite..."
        ./configure --prefix="${SCRIPT_DIR}/install"
        log "Building SQLite..."
        make -j
        log "Installing SQLite..."
        make install -j
        cd -
        is_custom_sqlite=1
        
        log "SQLite installation completed"
        ;;
esac

cd $SCRIPT_DIR
log "Activating Python virtual environment..."
source ./install/bin/activate

export CMAKE_PREFIX_PATH=${SCRIPT_DIR}/install:$CMAKE_PREFIX_PATH

log "Installing Python requirements..."
pip install --no-binary="mpi4py" --no-binary="dftracer-utils" -v -r requirements.txt

if [ $is_custom_sqlite -eq 1 ]; then
    log "Reinstalling dftracer-utils to link against the custom SQLite installation..."
    pip uninstall -y dftracer-utils
    pip install --no-binary="dftracer-utils" --no-cache-dir -v dftracer-utils==0.0.5
fi

log "Setup completed successfully."
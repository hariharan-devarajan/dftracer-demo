#!/bin/bash

set -e

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

SCRIPT_DIR=$PWD

log "Loading modules..."
module load craype-x86-trento libfabric/2.1 flux_wrappers/0.1 StdEnv  gcc/12.2.0 craype/2.7.34 cray-libsci/25.03.0 python/3.11.5 craype-network-ofi  perftools-base/25.03.0  xpmem/2.6.5       mpifileutils/0.12     gcc-native/12.2  cray-mpich/8.1.32  PrgEnv-gnu/8.6.0   cray-python/3.11.7

log "Creating Python virtual environment..."
python -m venv ./install

log "Activating Python virtual environment..."
source ./install/bin/activate

log "Installing dlio_benchmark..."
cd software/dlio_benchmark
pip install .
cd -

log "Building and installing IOR..."
cd software/ior
./bootstrap
./configure --prefix=${SCRIPT_DIR}/install
make -j
make install -j
cd -

log "Installing Python requirements..."
pip install -r requirements.txt

export CC=$(which mpicc)
export CXX=$(which mpic++)

pip install --force-reinstall --no-binary "mpi4py" mpi4py

log "Setup completed successfully."
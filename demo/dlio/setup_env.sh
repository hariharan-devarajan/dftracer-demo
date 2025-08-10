#!/bin/bash

install_dir=$1
# module load craype-x86-trento perftools-base/25.03.0 flux_wrappers/0.1 cce/19.0.0 craype-network-ofi craype/2.7.3 xpmem/2.6.5 cray-libsci/25.03.0 libfabric/2.1 PrgEnv-cray/8.6.0 StdEnv cray-mpich/8.1.32
module load craype-x86-trento libfabric/2.1 flux_wrappers/0.1 StdEnv  gcc/12.2.0 craype/2.7.34 cray-libsci/25.03.0 python/3.11.5 craype-network-ofi  perftools-base/25.03.0  xpmem/2.6.5       mpifileutils/0.12     gcc-native/12.2  cray-mpich/8.1.32  PrgEnv-gnu/8.6.0   cray-python/3.11.7
export LD_LIBRARY_PATH=/opt/cray/pe/mpich/8.1.32/ofi/crayclang/18.0/lib/libmpi.so:/usr/tce/updates/toss4_cray_2025_06_04/backend/installations/linux-rhel8-x86_64/cce-19.0.0/tce-compiler-wrappers-3.0-3qstea3x3cfjfdkngipusfh54sppu22t/cce/x86_64/lib/:$LD_LIBRARY_PATH
# export LD_LIBRARY_PATH=/usr/tce/packages/cuda/cuda-11.8.0/lib64:/opt/rocm-6.2.4/lib:/opt/rocm-6.2.4/hip/lib:/opt/rocm-6.2.4/hsa/lib:/opt/rocm-6.2.4/llvm/lib:/opt/cray/pe/lib64:/opt/cray/lib64:/opt/cray/pe/papi/7.1.0.4/lib64:/opt/cray/libfabric/2.1/lib64::{install_dir}/lib/python3.11/site-packages/nvidia/cudnn/lib/:{install_dir}/lib/python3.11/site-packages/nvidia/cuda_cupti/lib:{install_dir}/lib/python3.11/site-packages/nvidia/cusparse/lib:{install_dir}/lib/python3.11/site-packages/nvidia/cufft/lib/:{install_dir}/lib/python3.11/site-packages/cusparselt/lib:{install_dir}/lib/python3.11/site-packages/nvidia/cublas/lib/:{install_dir}/lib/python3.11/site-packages/nvidia/nccl/lib:{install_dir}/lib/python3.11/site-packages/torch/lib:$LD_LIBRARY_PATH

source $install_dir/bin/activate
ulimit -c unlimited
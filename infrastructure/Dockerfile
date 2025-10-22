FROM ubuntu:22.04

# Set noninteractive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    wget \
    python3 \
    python3-pip \
    python3-dev \
    python3-venv \
    libhdf5-dev \
    libopenmpi-dev \
    openmpi-bin \
    autoconf \
    automake \
    autoconf-archive \
    pkg-config \
    libtool \
    m4 \
    cmake \
    g++ \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip "setuptools<70.0.0" wheel

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"


# Install Jupyter
RUN pip install --no-cache-dir jupyter

# Install IOR
RUN git clone https://github.com/hpc/ior.git /opt/ior && \
    cd /opt/ior && \
    ./bootstrap && \
    ./configure --prefix=/opt/venv && \
    make && \
    make install

# Copy project files into the workspace directory
COPY .. /workspace

# Set working directory
WORKDIR /workspace

# Install DLIO Benchmark
RUN pip install -r ./requirements.txt

ENV USER=root

# Expose Jupyter port
EXPOSE 8888

# Start Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
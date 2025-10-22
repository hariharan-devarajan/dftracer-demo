# Docker Infrastructure Guide

This guide provides detailed instructions for building and running the dftracer-demo Docker container.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed on your system
- At least 4GB of free disk space for the container image
- Basic familiarity with Docker commands

## Building the Docker Container

Navigate to the project root directory and run:

```bash
docker build -f infrastructure/Dockerfile -t dftracer-demo:latest .
```

## Running the Container

### Method 1: Jupyter Notebook (Default)

Start the container with Jupyter Notebook:

```bash
docker run -p 8888:8888 -v $(pwd):/workspace dftracer-demo:latest
```

Then open your browser to: **http://localhost:8888**

For command-line access:

```bash
docker run -it -p 8888:8888 -v $(pwd):/workspace dftracer-demo:latest /bin/bash
```

## Opening and Using the Notebooks

### Access Jupyter Lab

1. **Start the container** (using any method above)
2. **Open your browser** to `http://localhost:8888`
3. **Navigate to demo notebooks**:
   - IOR Demo: `demo/ior/demo.ipynb`
   - DLIO Demo: `demo/dlio/demo.ipynb`

### Starting Jupyter Manually

If you're in an interactive shell:

```bash
# Start Jupyter Lab
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root

# Or start Jupyter Notebook
jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root
```

### Port Configuration

If port 8888 is already in use:

```bash
# Use a different port
docker run -p 8889:8888 -v $(pwd):/workspace dftracer-demo:latest

# Then access via http://localhost:8889
```

## Container Management

### Useful Docker Commands

**List running containers:**
```bash
docker ps
```

**Stop a container:**
```bash
docker stop dftracer-container
```

**Remove a container:**
```bash
docker rm dftracer-container
```

**View container logs:**
```bash
docker logs dftracer-container
```

**Check container resource usage:**
```bash
docker stats dftracer-container
```

### Data Persistence

The container mounts your local workspace to `/workspace` inside the container, so:

- **Notebook changes are preserved** when you stop/restart the container
- **Generated data and logs** are saved to your local filesystem
- **Environment and installed packages** are reset when the container is removed

## Troubleshooting

### Common Issues

**Build fails with "transferring context" taking too long:**
- Create/update `.dockerignore` to exclude large files
- Check if `install/`, `output/`, or `logs/` directories are very large

**Port 8888 already in use:**
```bash
# Find what's using the port
lsof -i :8888

# Use a different port
docker run -p 8889:8888 -v $(pwd):/workspace dftracer-demo:latest
```

**Permission issues with mounted files:**
```bash
# Run with user ID mapping
docker run --user $(id -u):$(id -g) -p 8888:8888 -v $(pwd):/workspace dftracer-demo:latest
```

**Container runs but Jupyter is not accessible:**
- Check if the container is running: `docker ps`
- Check container logs: `docker logs <container-name>`
- Verify port mapping is correct

### Getting Help

**Check container status:**
```bash
docker ps -a
```

**Access container shell for debugging:**
```bash
docker exec -it <container-name> /bin/bash
```

**View detailed container information:**
```bash
docker inspect <container-name>
```

## Container Contents

The Docker container includes:

- **Ubuntu 22.04** base system
- **Python 3.x** with virtual environment
- **Jupyter Lab/Notebook**
- **IOR benchmark** (compiled from source)
- **DLIO benchmark** (installed via pip)
- **MPI and HDF5** libraries
- **DFTracer** and related tools
- **Build tools** and development dependencies

The container automatically:
1. Sets up the Python virtual environment
2. Installs all required dependencies
3. Compiles IOR from source
4. Installs DLIO benchmark
5. Starts Jupyter Notebook on port 8888

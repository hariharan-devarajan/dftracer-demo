# dftracer-demo

A demo to run dftracer with different workloads.

## Getting Started

1. **Setup the environment**:

   ```bash
   ./setup.sh
   source ./install/bin/activate
   ```

2. **Launch Jupyter**:

   ```bash
   jupyter lab
   ```

3. **Follow the demo guides**:
   - **Quick Start**: See `QUICK_START.md` for a brief overview
   - **Complete Guide**: See `DEMO_NARRATIVE_GUIDE.md` for detailed instructions

## Demo Contents

- **IOR Benchmark Demo** (`demo/ior/demo.ipynb`): Traditional I/O benchmarking with DFTracer
- **DLIO Benchmark Demo** (`demo/dlio/demo.ipynb`): Deep learning I/O pattern analysis

## What You'll Learn

- How to configure and use DFTracer for I/O profiling
- Understanding different I/O patterns in HPC workloads
- Analyzing trace data to identify performance bottlenecks
- Using DFAnalyzer for visualization and insights

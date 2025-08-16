# DFTracer Demo Quick Guide

## What This Demo Shows

This demonstration teaches you how to use **DFTracer** to profile and analyze I/O performance in HPC applications through two hands-on examples:

1. **IOR Benchmark** - Traditional I/O benchmarking and analysis
2. **DLIO Benchmark** - Deep learning I/O pattern analysis

## Before You Start

Ensure the environment is set up by running:

```bash
./setup.sh
source ./install/bin/activate
```

## Demo Flow

### IOR Demo (`demo/ior/demo.ipynb`)

1. **Setup**: Configure directories and environment
2. **Configure DFTracer**: Set tracing parameters
3. **Run IOR**: Execute benchmark with I/O tracing
4. **Process Traces**: Compact and examine trace files
5. **Analyze**: Generate visualizations and insights

### DLIO Demo (`demo/dlio/demo.ipynb`)

1. **Setup**: Prepare for deep learning workload
2. **Data Generation**: Create training data with tracing
3. **Training Phase**: Run ML training with I/O monitoring
4. **Advanced Analysis**: Multi-phase trace analysis
5. **ML Insights**: Understand deep learning I/O patterns

## Key Learning Outcomes

- How to configure and use DFTracer effectively
- Understanding I/O patterns in different workload types
- Identifying performance bottlenecks through trace analysis
- Using DFAnalyzer for visualization and insights
- Best practices for I/O profiling in HPC environments

## Tips for Success

- Execute cells sequentially in each notebook
- Pay attention to the DFTracer configuration variables
- Examine the generated trace files to understand the data format
- Compare results between different phases or configurations
- Use the visualizations to identify optimization opportunities

## Getting Help

- Check the full narrative guide: `DEMO_NARRATIVE_GUIDE.md`
- Visit DFTracer documentation: <https://dftracer.readthedocs.io/>
- Examine trace files if analysis seems incomplete
- Ensure all environment variables are properly set

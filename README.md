

# Octopus Optimization Algorithm: a novel single- and multi-objective optimization algorithm for optimization problems
Author and Programmer: Meijia Song 

email: chris_study@163.com

This repository contains the source code for the proposed Octopus Optimization Algorithm

The implementation is based on the PlatEMO platform, a widely used MATLAB-based framework for evolutionary multi-objective optimization.

## Requirements
To run the code, ensure the following are installed:

**MATLAB** (version R2020b or later recommended).

**PlatEMO platform**:
Clone or download the PlatEMO repository from [here](https://github.com/BIMK/PlatEMO).
Add the PlatEMO directory to the MATLAB path before running the scripts.

## Getting Started
Step 1: Clone this repository to your local machine

Step 2: Copy the entire MOOA directory to the PlatEMO algorithms folder:

```
cp -r /path/to/this/repository/MOOA/ PlatEMO/Algorithms/Multi-objective optimization/
```

Step 3: Run the Algorithm

To run the algorithm, use the following command in MATLAB:

```matlab
platemo('algorithm',@MOOA_final,'problem',@DTLZ1);
```
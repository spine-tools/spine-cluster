#!/bin/bash
#SBATCH -n 1 # 1 core
#SBATCH --mem-per-cpu=8G # 8GB per core	# guest users can use maximum 48 cores and 128G total RAM
#SBATCH --time=1:00:00 # 1-hour run-time
#SBATCH --tmp=2G # Local scratch space per node
#SBATCH --job-name=InstallSpineOpt
#SBATCH --mail-type=BEGIN,END,FAIL # send an email when the job begins, ends, and fails
# #SBATCH --error=errors.log # append job’s error messages to errors.log

# Prerequest 1: `julia` is installed and available in PATH
# Option 1 (current & recommended): official release via `juliaup` ("https://julialang.org/install/")
# Option 2: Euler default -> `module load julia` (use `module spider julia` to see available versions)

# Prerequest 2: `conda` is installed and available in PATH

# to submit this script to run: "sbatch < path/to/install_SpineOpt.sh"
# to fix DOS line breaks error, run "dos2unix path/to/install_SpineOpt.sh" in the terminal first

# System module setup
module load gurobi 

# unload default loaded python to avoid conflict with our own conda python
# module unload python

# activate the `conda` command (given that a `conda` is installed, explanations see the "install_SpineOpt.jl")
source $HOME/.bashrc
# eval "$(conda shell.bash hook)"

# Create the dedicated conda env w. the latest python (remove any existing `env` by "-y")
# replace the `python` by `python=3.1x` for a specific version
# more packages, e.g. `pip`, can be explicitly added before/after the `python`
conda create -n julia-spineopt python -y
conda activate julia-spineopt

conda update --all -y

# Place this script in the same directory as the install_SpineOpt.jl
julia ./install_SpineOpt.jl

# # standby command to install Spine-Database-API
# python -m pip install --user 'git+https://github.com/Spine-project/Spine-Database-API@master'

conda clean --all -y
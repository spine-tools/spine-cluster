"""
Author: Huang, Jiangyi (Chair of Energy System Analysis, ETH Zurich)
Date: 2025-Aug-15

- Install SpineOpt.jl and associated julia packages
- Config PyCall.jl with using the activated conda python environment
- Install Spine-Database-API into the conda python confired to julia
"""

#=
Step 1: Before running this script, in bash terminal
- 1.1 system modules
    module load gurobi  # since we want to use Gurobi solver
    module unload python    # default python that would conflic with `conda`

- 1.2 (Only needed in sbatch scripts) Ensure `conda` command available
    source $HOME/.bashrc
eval "$(conda shell.bash hook)"

- 1.3 (Optional) Ensure `conda xx` demands get executed in bash (latest shatch system seem to have this by default)
    eval "$(conda shell.bash hook)"
    
    Reasons:
    - https://docs.conda.io/projects/conda/en/latest/dev-guide/deep-dives/activation.html?highlight=conda%20activate#conda-activate
    - what does `eval` do: https://unix.stackexchange.com/a/156993   

- 1.3 use the dedicated conda python environment
    conda create -n julia-spineopt python -y
    conda activate julia-spineopt

Step 2: Default command to run this script in bash: 
julia /path/to/install_SpineOpt.jl, e.g.
    julia $HOME/Tools/SpineOpt/install_SpineOpt.jl
=#

# Use the directory of this script as the default directory for
# the julia virtual environment that accommodates SpineOpt.jl and the associated packages
path_to_SpineOpt_env = @__DIR__

# (Optional Step 2) 
# Specify the directory for the julia virtual environment in the script
target_directory = ENV["HOME"]*"/Tools/SpineOpt"
!isdir(target_directory) ? mkdir(target_directory) : path_to_SpineOpt_env = target_directory

# (Optional Step 2) 
#= Specify the directory for the julia virtual environment in the first argument on running this script in bash, e.g.
    julia $HOME/install_SpineOpt.jl $HOME/Tools/SpineOpt
=#
isempty(ARGS) ? nothing : path_to_SpineOpt_env = ARGS[1]

# Activate the julia virtual environment
cd(path_to_SpineOpt_env)
using Pkg; Pkg.activate("."); Pkg.update()

# Install needed packages
## Julia-only packages
Pkg.add("JuMP"); 
Pkg.add("Gurobi"); Pkg.build("Gurobi")
Pkg.add(url="https://github.com/Spine-tools/SpineInterface.jl.git", rev="master")
Pkg.add(url="https://github.com/Spine-tools/SpineOpt.jl.git", rev="master")
## Python-related packages
Pkg.add("PyCall")
## Update all installed packages to the latest version as Pkg.add() does not update the packages
Pkg.update()

# A. Config `PyCall.jl` -> use the activated conda python
ENV["PYTHON"] = Sys.which("python"); Pkg.build("PyCall")
using PyCall
PythonForSpineDB_API = PyCall.python
@show PyCall.python
println("PyCall.jl should use the activated conda python, i.e.")
println("\'PyCall.python\' should be \'$(ENV["CONDA_PREFIX"])/bin/python\'.")

command_install_SpineDB_API = PythonForSpineDB_API * " -m pip install --user 'git+https://github.com/Spine-project/Spine-Database-API@master'"
run(`bash -c $command_install_SpineDB_API`)
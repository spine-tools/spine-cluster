#!/bin/sh 
### General options 
### -- specify queue -- 
#BSUB -q hpc
### -- set the job Name -- 
#BSUB -J Skive
### -- ask for number of cores (default: 1) -- 
#BSUB -n 4 
### -- specify that the cores must be on the same host -- 
#BSUB -R "span[hosts=1]"
### -- specify that we need 4GB of memory per core/slot -- 
#BSUB -R "rusage[mem=4GB]"
### -- specify that we want the job to get killed if it exceeds 20 GB per core/slot -- 
#BSUB -M 20GB
### -- set walltime limit: hh:mm -- 
#BSUB -W 24:00 
### -- set the email address -- 
##BSUB -u lilang@dtu.dk
### -- send notification at start -- 
#BSUB -B 
### -- send notification at completion -- 
#BSUB -N 
### -- Specify the output and error file. %J is the job-id -- 
### -- -o and -e mean append, -oo and -eo mean overwrite -- 
#BSUB -o Skive/output/output_%J.out 
#BSUB -e Skive/output/output_%J.err 

# here follow the commands you want to execute with input.in as the input file
cd Skive
cat input/input.sqlite >> output/input/$LSB_JOBID-input.sqlite
module load python3/3.9.14
source .venv/bin/activate
module load gurobi/10.0.0 
module load julia/1.7.3

export comment=""
#export scenario= "Inv_NH3_PPA_2.0x_cont" 
export LD_LIBRARY_PATH=/appl/sqlite3/3.38.3/lib:$LD_LIBRARY_PATH 
export job=$LSB_JOBID
julia  skive.jl


# TRANSFER INPUT!!!!!!!!!!!!!!!
# TRANSFER INPUT!!!!!!!!!!!!!!!
# TRANSFER INPUT!!!!!!!!!!!!!!!
# TRANSFER INPUT!!!!!!!!!!!!!!!
# TRANSFER INPUT!!!!!!!!!!!!!!!
# TRANSFER INPUT!!!!!!!!!!!!!!!
# TRANSFER INPUT!!!!!!!!!!!!!!!

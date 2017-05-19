#!/bin/bash 
# 
# Define Slurm options 
#SBATCH --job-name=T1 
#SBATCH --output=T1.out 
#SBATCH --time=00:05:00 
#SBATCH --ntasks=1 
#SBATCH --cpus-per-task=1 
#SBATCH --mem-per-cpu=4000 
# GPU settings 
#SBATCH --partition=titanx 
#SBATCH --gres=gpu:1

srun T1

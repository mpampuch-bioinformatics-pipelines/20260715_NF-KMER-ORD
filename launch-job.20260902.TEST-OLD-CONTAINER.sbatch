#!/usr/bin/env bash
#SBATCH --time=7-23:00:00                     # Set your job walltime (D-HH:MM:SS)
#SBATCH --nodes=1                           # Set how many compute nodes / machines to request
#SBATCH --cpus-per-task=1                   # Set how many CPU's / threads you need
#SBATCH --ntasks=1                          # Set how many tasks / processes you need (generally 1 for serial tasks)
#SBATCH --mem=5G                            # Set how much memory should be allocated per node
#SBATCH --partition=batch                   # Set which partition / queue your job will run in.
#SBATCH --output=SLURM_LOGS/.slurm_%j.out   # Set where SLURM stdout will go
#SBATCH --error=SLURM_LOGS/.slurm_%j.err    # Set where SLURM stderr will go
#SBATCH --mail-type=ALL                     # Set emailing rules for this job (options: BEGIN, END, FAIL, REQUEUE, ALL, NONE)
#SBATCH --job-name=TEST-OLD-KMER-ORD-CONTAINER            # Set your job name

# Load modules
module load nextflow
module load singularity/3.9.7

# Configure up environment variables
export NXF_OPTS='-Xms3G -Xmx5G' # Allocate Java VM Heap memory range (for main process)
export NXF_SINGULARITY_CACHEDIR=/ibex/scratch/projects/c2303/NXF_SINGULARITY_CACHEDIR 
export NXF_APPTAINER_CACHEDIR=/ibex/scratch/projects/c2303/NXF_APPTAINER_CACHEDIR
export NXF_WORK=/ibex/scratch/projects/c2303/work

# Activate your environment for your job (if necessary)
# source env.sh 

# Activate a conda enviroment (if necessary)
# source "/ibex/user/pampum/mambaforge/etc/profile.d/conda.sh" # Initialize Conda for use in this script
# conda activate "$(pwd)/env" # Activate the conda environment

# Put in your file paths
# E.g.
INPUT_FILE="/ibex/scratch/projects/c2303/20260715_NF-KMER-ORD/samplesheet.20260902.FOR-OLD-CONTAINER.yaml"
CONFIG_FILE="nextflow.config"
NXF_OUTPUT_DIR="OUTPUTS/$(date -Iseconds | sed 's/-//g; s/://g; s/T/_/; s/+.*//')"
NXF_LOG_FILE="$NXF_OUTPUT_DIR/nextflow.log"

# Create output directory and copy useful files there for an easier time decipher the pipeline execution afterwards
mkdir -p "$NXF_OUTPUT_DIR"
cp "$INPUT_FILE" "$NXF_OUTPUT_DIR"
cp "$CONFIG_FILE" "$NXF_OUTPUT_DIR"
cp "$0" "$NXF_OUTPUT_DIR/slurm_script.sbatch" # Copy the script to the output directory
echo "$(pwd)" > "$NXF_OUTPUT_DIR/projectDir.txt"

# Run your job script here
nextflow -log "$NXF_LOG_FILE" run . -c "$CONFIG_FILE" -with-report -profile kaust --input "$INPUT_FILE" --outdir "$NXF_OUTPUT_DIR" -ansi-log false -resume 1b86b7ac-9cfb-4963-97fd-82896df65762
# -resume 1b86b7ac-9cfb-4963-97fd-82896df65762 added on 2026-09-04 after adding more resources to visualize process in config to get visualizations to run to resume the job from the previous run
#!/usr/bin/env bash

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
INPUT_FILE="/ibex/scratch/projects/c2303/20260715_NF-KMER-ORD/samplesheet.20260903.testdata-to-see-if-visualization-working.yaml"
CONFIG_FILE="nextflow.TEST-NEW-RAM-EFFICIENT-CONTAINER.config"
NXF_OUTPUT_DIR="/ibex/scratch/projects/c2303/20260715_NF-KMER-ORD/TESTS/TEST_OUTPUTS/$(date -Iseconds | sed 's/-//g; s/://g; s/T/_/; s/+.*//')"
NXF_LOG_FILE="$NXF_OUTPUT_DIR/nextflow.log"

# Create output directory and copy useful files there for an easier time decipher the pipeline execution afterwards
mkdir -p "$NXF_OUTPUT_DIR"
cp "$INPUT_FILE" "$NXF_OUTPUT_DIR"
cp "$CONFIG_FILE" "$NXF_OUTPUT_DIR"
cp "$0" "$NXF_OUTPUT_DIR/job_script.sh" # Copy the script to the output directory
echo "$(pwd)" > "$NXF_OUTPUT_DIR/projectDir.txt"

# Run your job script here
nextflow -log "$NXF_LOG_FILE" run . -c "$CONFIG_FILE" -with-report -profile kaust --input "$INPUT_FILE" --outdir "$NXF_OUTPUT_DIR" -ansi-log true

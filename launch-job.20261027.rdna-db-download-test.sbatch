#!/usr/bin/env bash
#SBATCH --time=2-00:00:00                     # Set your job walltime (D-HH:MM:SS)
#SBATCH --nodes=1                           # Set how many compute nodes / machines to request
#SBATCH --cpus-per-task=1                   # Set how many CPU's / threads you need
#SBATCH --ntasks=1                          # Set how many tasks / processes you need (generally 1 for serial tasks)
#SBATCH --mem=5G                            # Set how much memory should be allocated per node
#SBATCH --partition=batch                   # Set which partition / queue your job will run in.
#SBATCH --output=SLURM_LOGS/.slurm_%j.out   # Set where SLURM stdout will go
#SBATCH --error=SLURM_LOGS/.slurm_%j.err    # Set where SLURM stderr will go
#SBATCH --mail-type=ALL                     # Set emailing rules for this job (options: BEGIN, END, FAIL, REQUEUE, ALL, NONE)
#SBATCH --job-name=rdna-db-download-test    # Set your job name

# Load modules
module load nextflow
module load singularity/3.9.7

# Configure up environment variables
export NXF_OPTS='-Xms3G -Xmx5G' # Allocate Java VM Heap memory range (for main process)
export NXF_SINGULARITY_CACHEDIR=/ibex/scratch/projects/c2303/NXF_SINGULARITY_CACHEDIR 
export NXF_APPTAINER_CACHEDIR=/ibex/scratch/projects/c2303/NXF_APPTAINER_CACHEDIR
export NXF_WORK=/ibex/scratch/projects/c2303/work

# Put in your file paths
PARAMS_FILE="params.20261027.rdna-db-download-test.yaml"
INPUT_FILE="samplesheet.20261027.rdna-db-download-test.yaml"
NXF_OUTPUT_DIR="OUTPUTS/$(date -Iseconds | sed 's/-//g; s/://g; s/T/_/; s/+.*//')"
NXF_LOG_FILE="$NXF_OUTPUT_DIR/nextflow.log"

# Create output directory and copy useful files there for an easier time decipher the pipeline execution afterwards
mkdir -p "$NXF_OUTPUT_DIR"
cp "$PARAMS_FILE" "$NXF_OUTPUT_DIR"
cp "$INPUT_FILE" "$NXF_OUTPUT_DIR"
cp "$0" "$NXF_OUTPUT_DIR/slurm_script.sbatch" # Copy the script to the output directory
echo "$(pwd)" > "$NXF_OUTPUT_DIR/projectDir.txt"

# Uses nextflow.config. rdna_db_dir in the params file is an empty directory,
# so KMER_ORD_RDNA_DB installs the databases before the small pca projection.
nextflow -log "$NXF_LOG_FILE" run . -params-file "$PARAMS_FILE" -with-report -profile kaust --outdir "$NXF_OUTPUT_DIR" -ansi-log true -resume

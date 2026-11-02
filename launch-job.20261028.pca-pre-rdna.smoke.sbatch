#!/usr/bin/env bash
#SBATCH --time=12:00:00                     # Driver waits on the project task (up to 4h, longer on retry)
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --ntasks=1
#SBATCH --mem=6G
#SBATCH --partition=batch
#SBATCH --output=SLURM_LOGS/.slurm_%j.out
#SBATCH --error=SLURM_LOGS/.slurm_%j.err
#SBATCH --mail-type=ALL
#SBATCH --job-name=smoke.pca-pre-rdna

# Load modules
module load nextflow
module load singularity/3.9.7

# Leave headroom under the 6G SLURM allocation for the Nextflow JVM.
export NXF_OPTS='-Xms2G -Xmx4G'
export NXF_SINGULARITY_CACHEDIR=/ibex/scratch/projects/c2303/NXF_SINGULARITY_CACHEDIR
export NXF_APPTAINER_CACHEDIR=/ibex/scratch/projects/c2303/NXF_APPTAINER_CACHEDIR
export NXF_WORK=/ibex/scratch/projects/c2303/work

# Same settings as 65_Cyanobacteria_pca_pre_rdna, on the 0.5% test FASTA.
# The smoke config only shrinks KMER_ORD_PROJECT and KMER_ORD_VISUALISE.
# Do not point this job at nextflow.LichenSubsets.HyperParamScreen.config:
# that file requests 400 GB for projection.
INPUT_FILE="samplesheet.20261028.pca-pre-rdna.smoke.yaml"
CONFIG_FILE="nextflow.20261028.pca-pre-rdna.smoke.config"
NXF_OUTPUT_DIR="TESTS/TEST_OUTPUTS/$(date -Iseconds | sed 's/-//g; s/://g; s/T/_/; s/+.*//')"
NXF_LOG_FILE="$NXF_OUTPUT_DIR/nextflow.log"

mkdir -p "$NXF_OUTPUT_DIR"
cp "$INPUT_FILE" "$NXF_OUTPUT_DIR"
cp "$CONFIG_FILE" "$NXF_OUTPUT_DIR"
cp "$0" "$NXF_OUTPUT_DIR/slurm_script.sbatch"
echo "$(pwd)" > "$NXF_OUTPUT_DIR/projectDir.txt"

nextflow -log "$NXF_LOG_FILE" run . -c "$CONFIG_FILE" -with-report -profile kaust --input "$INPUT_FILE" --outdir "$NXF_OUTPUT_DIR" --run_clustering false -ansi-log true -resume

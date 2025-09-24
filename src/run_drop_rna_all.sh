#!/bin/bash
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --time=1-00:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --mem=360G
#SBATCH --partition=hpc1

# Set paths
DROP_SIF=/work/ldybov5s/rnaseq/drop.sif
DROP_DIR=/work/ldybov5s/rnaseq/second_run/drop_bam
DROP_CONFIG=$DROP_DIR/config.yaml
R_LIBS_DIR=/work/ldybov5s/rnaseq/second_run/drop_bam/r_libs
export TMPDIR=/work/ldybov5s/rnaseq/second_run/drop_bam/tmp
mkdir -p "$TMPDIR"

# Move to DROP project directory (after 'drop init')
cd "$DROP_DIR"
mkdir -p "$R_LIBS_DIR"

# Run DROP pipeline using snakemake inside the container
apptainer exec --bind "$R_LIBS_DIR:/opt/conda/envs/drop_env/lib/R/library" "$DROP_SIF" snakemake \
  --configfile "$DROP_CONFIG" \
  --snakefile Snakefile \
  --config mode=run \
  --cores 120 \
  --jobs 12 \
  --latency-wait 60 \
  --resources mem_mb=350000 \
  --use-conda \
  --rerun-incomplete \
  --printshellcmds \
  --keep-going

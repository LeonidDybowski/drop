#!/bin/bash
#SBATCH --partition=hpc1
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --mem=360G
#SBATCH --time=3-00:00:00
#SBATCH --output=%j.out
#SBATCH --error=%j.err

# load modules
export PATH=$HOME/.local/java/jdk-17.0.10+7/bin:$PATH

RNA_PATH="../../"

"${RNA_PATH}nextflow" run nf-core/rnaseq -profile singularity \
  --with-singularity "{$RNA_PATH}nfcore_rnaseq_3.18.0.sif" \
  --input samplesheet_nfcore_rnaseq_rna_all.csv \
  --outdir nfcore_results_rna_all \
  --fasta "${RNA_PATH}reference_genome_Ensembl/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.gz" \
  --gtf "${RNA_PATH}reference_genome_Ensembl/Homo_sapiens.GRCh38.113.gtf.gz" \
  --max_cpus 128 \
  --process.executor=local



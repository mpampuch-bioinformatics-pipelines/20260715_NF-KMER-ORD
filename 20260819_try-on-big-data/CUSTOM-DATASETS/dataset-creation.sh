#!/bin/bash

# Combined coral dataset
cat /ibex/scratch/projects/c2303/20260715_NF-KMER-ORD/20260819_try-on-big-data/OUTPUTS/20260820_203217/fastq/SRX27934295_SRR32629517.fastq.gz /ibex/scratch/projects/c2303/20260715_NF-KMER-ORD/20260819_try-on-big-data/OUTPUTS/20260820_203217/fastq/SRX27934296_SRR32629516.fastq.gz > /ibex/scratch/projects/c2303/20260715_NF-KMER-ORD/20260819_try-on-big-data/CUSTOM-DATASETS/platygryra-daedalea-reads.fastq.gz

# Combined lichen metagenome dataset
cat /ibex/scratch/projects/c2303/20260715_NF-KMER-ORD/20260819_try-on-big-data/OUTPUTS/20260820_203217/fastq/SRX9925339_SRR13514087.fastq.gz /ibex/scratch/projects/c2303/20260715_NF-KMER-ORD/20260819_try-on-big-data/OUTPUTS/20260820_203217/fastq/SRX9925340_SRR13514086.fastq.gz > /ibex/scratch/projects/c2303/20260715_NF-KMER-ORD/20260819_try-on-big-data/CUSTOM-DATASETS/umbilicaria-phaea-metagenome-reads.fastq.gz

# Combined coral and lichen metagenome dataset
cat /ibex/scratch/projects/c2303/20260715_NF-KMER-ORD/20260819_try-on-big-data/CUSTOM-DATASETS/platygryra-daedalea-reads.fastq.gz /ibex/scratch/projects/c2303/20260715_NF-KMER-ORD/20260819_try-on-big-data/CUSTOM-DATASETS/umbilicaria-phaea-metagenome-reads.fastq.gz > /ibex/scratch/projects/c2303/20260715_NF-KMER-ORD/20260819_try-on-big-data/CUSTOM-DATASETS/platygryra-daedalea-and-umbilicaria-phaea-reads.fastq.gz
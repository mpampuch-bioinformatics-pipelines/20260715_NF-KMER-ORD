# nf-core/pipeline: Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## v1.0.0dev - 2026-07-15

Wire `kmer-ord project` into the pipeline and switch input from FastQ pairs to FASTA reads.

### `Added`

- Integrate `KMER_ORD_PROJECT` into the main workflow (`workflows/pipeline.nf`)
- Publish `kmer-ord project` results under `${outdir}/${meta.id}/kmer_ord_project`
- Module docs, conda env, and test config for `modules/local/kmer-ord/project`
- nf-test coverage for real and stub runs against local FASTA test data
- Set `HOME=$PWD` in the process so numba/UMAP can cache under Singularity `--no-home`

### `Changed`

- Samplesheet schema: `sample,fastq_1,fastq_2` → `id,reads` (FASTA / `.fa` / `.fna`, optionally gzipped)
- Simplify sample-sheet channel to `[ meta, reads ]` (drop FastQ endedness validation)
- Point Singularity container at the local Ibex `kmer-ord` SIF
- Pin reported `kmer-ord` version to commit `aa22b130`
- Default nf-test profile to `singularity,test`; resolve test samplesheet via `${projectDir}`

### `Fixed`

- Stub output path aligned with real run (`${prefix}_kmerord_project`)
- Process/test names corrected to `KMER_ORD_PROJECT`

### `Dependencies`

- `kmer-ord` via local Singularity image (`aa22b130903e8f6aa71c881b22c4b18b2efd2486`)

### `Deprecated`

- FastQ paired/single-end samplesheet format (`sample`, `fastq_1`, `fastq_2`)

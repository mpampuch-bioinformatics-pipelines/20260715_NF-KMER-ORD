Apptainer> kmer-ord -h

Usage: kmer-ord [OPTIONS] COMMAND [ARGS]...

╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────╮
│ --help -h Show this message and exit. │
╰────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Pipeline ─────────────────────────────────────────────────────────────────────────────────────────╮
│ project [+] Projection pipeline: │
│ Convert sequences (FASTQ/FASTA) into k-mer feature space, │
│ compute sequence-level metrics, and generate a low-dimensional │
│ (2D/3D) embedding that captures geometric relationships in k-mer space. │
│ Results are stored in the database for dowstream exploration and annotation. │
│ | fastq -> fasta -> sequence stats -> kmer-counting -> -> DR -> database | │
│ cluster [+] Cluster inference pipeline : │
│ Construct a high-dimensional embedding of k-mer feature space │
│ and perform unsupervised clustering to infer intrinsic structure │
│ among sequences. Embeddings and cluster assignments are │
│ integrated into the database for downstream analysis. │
│ | kmer-profiles -> High-D embedding -> clustering -> database | │
╰────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Analysis ─────────────────────────────────────────────────────────────────────────────────────────╮
│ visualise Visualise database tables. │
│ - Feature distributions and categorical comparisons │
│ - Embedding visualisations (UMAP, t-SNE, etc.) │
│ inject Inject new feature columns from a TSV file into the database features table. │
│ bin Launch interactive Dash app for binning sequences. │
╰────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Modules ──────────────────────────────────────────────────────────────────────────────────────────╮
│ fastq-to-fasta Convert fastq (or fastq.gz) to fasta. Uses seqkit by default; --biopython for │
│ legacy fallback. │
│ fasta-stats Calculate per-sequence and overall statistics from a fasta file. │
│ kmer-count Count k-mers for a fasta file and save tsv matrix. │
│ kmer-metrics Compute per-sequence k-mer metrics (Shannon diversity, unique k-mers, etc.). │
│ dr Run dimensionality reduction on an existing k-mer matrix. │
│ clustering Cluster sequences using existing embedding. │
│ run-tiara Run Tiara classification on a fasta file. │
│ build-db Build Spatialite database from available artifacts. │
╰────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Installation ─────────────────────────────────────────────────────────────────────────────────────╮
│ setup Setup all required external dependencies: │
│ - tools environment (kmer-counter, rust) │
│ - tiara environment (optional, pass --no-tiara to skip) │
│ - kmer-counter Rust installation from GitHub │
│ - rDNA-miner environment │
╰────────────────────────────────────────────────────────────────────────────────────────────────────╯
Apptainer> kmer-ord cluster -h

Usage: kmer-ord cluster [OPTIONS]

[+] Cluster inference pipeline : Construct a high-dimensional embedding of k-mer feature space and  
 perform unsupervised clustering to infer intrinsic structure among sequences. Embeddings and  
 cluster assignments are integrated into the database for downstream analysis. | kmer-profiles ->  
 High-D embedding -> clustering -> database |

╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────╮
│ _ --input -i <path> Input fasta/fastq file [required] │
│ _ --output -o <path> Output directory [required] │
│ --kmer -k <int> [default: 6] │
│ --dims -d <int> High-dimensional embedding size [default: 15] │
│ --dr <str> [default: umap] │
│ --scale -s <str> Dataset scale presets for DR hyperparameters (auto, small, │
│ medium, large, default) │
│ [default: auto] │
│ --norm <str> [default: clr] │
│ --pca-pre Apply PCA before DR │
│ --keep-pcs <int> Number of principal components to retain │
│ --keep-variance <float> Variance threshold for PCA (e.g. 0.9) │
│ --screen_params Run parameter screening for supported DR methods │
│ --cluster <str> Comma-separated clustering methods (leiden,hdbscan,dbscan) │
│ [default: hdbscan] │
│ --leiden-sweep Run Leiden resolution sweep │
│ --hdbscan-sweep Run HDBSCAN min_cluster_size sweep │
│ --dbscan-sweep Run DBSCAN eps sweep │
│ --threads -t <int> [default: 4] │
│ --force -f │
│ --db <path> Optional path to existing SQLite/SpatiaLite DB │
│ --help -h Show this message and exit. │
╰────────────────────────────────────────────────────────────────────────────────────────────────────╯

Apptainer> kmer-ord visualise -h

Usage: kmer-ord visualise [OPTIONS]

Visualise database tables. - Feature distributions and categorical comparisons - Embedding  
 visualisations (UMAP, t-SNE, etc.)

╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────╮
│ \* --db -d <path> Path to the SQLite/SpatiaLite database │
│ [required] │
│ --max-categories <int> Max number of categories for categorical │
│ feature plots │
│ [default: 10] │
│ --embeddings --no-embeddings Generate embedding plots [default: embeddings] │
│ --embedding-mode <str> Embedding plot mode: density, categorical, │
│ continuous, all │
│ [default: all] │
│ --features --no-features Generate feature plots [default: features] │
│ --help -h Show this message and exit. │
╰────────────────────────────────────────────────────────────────────────────────────────────────────╯

Apptainer> kmer-ord inject -h

Usage: kmer-ord inject [OPTIONS]

Inject new feature columns from a TSV file into the database features table.

Rules:

- First column must be named 'sequence_id' (matches the pipeline convention)
- All sequence_ids in the database are preserved (left join)
- Sequences in the input with no DB match are ignored
- Sequences in the DB with no input row get NULL for the new columns
- Columns whose name already exists in the features table are skipped
- Duplicate sequence_ids in the input file are rejected

╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────╮
│ _ --db -d <path> Path to the SQLite/SpatiaLite database [required] │
│ _ --input -i <path> Tab-separated file (.tsv/.txt) with sequence_id column and new feature │
│ columns to add │
│ [required] │
│ --help -h Show this message and exit. │
╰────────────────────────────────────────────────────────────────────────────────────────────────────╯

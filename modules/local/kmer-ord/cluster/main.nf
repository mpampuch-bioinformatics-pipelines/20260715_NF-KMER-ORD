process KMER_ORD_CLUSTER {

  tag "${meta.id}_k=${meta.kmer}"
  label 'process_high'
  label 'process_high_memory'
  label 'process_long'

  conda "${moduleDir}/environment.yml"
  container "${workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container
    ? '/ibex/project/c2303/20260614_make-kmer-ord-singularity-container/kmer-ord.linux.amd64.potentiallyWorking.needsTesting.20260924.RAM-efficient-fork.v7.sif'
    : 'docker://PLACEHOLDER_DOCKER_IMAGE'}"

  input:
  // Runs independently of KMER_ORD_PROJECT so both stages can execute in parallel.
  // Cluster assignment TSVs are later injected into the project DB.
  tuple val(meta), path(input)

  output:
  tuple val(meta), path("results"), emit: results_dir
  tuple val(meta), path("results/kmerord.sqlite"), emit: db
  tuple val(meta), path("results/clusters/*.tsv"), emit: cluster_tsvs
  path "versions.yml", emit: versions

  when:
  task.ext.when == null || task.ext.when

  script:
  def args = task.ext.args ?: ""

  if (meta.threads != null && meta.threads > task.cpus) {
    error("Sample ${meta.id} requests ${meta.threads} threads, but KMER_ORD_CLUSTER was allocated ${task.cpus} CPUs.")
  }

  def threads = meta.threads ?: task.cpus

  // cluster_dims is the high-dimensional embedding size used for clustering and
  // is intentionally distinct from meta.dims (the 2D/3D projection used by
  // KMER_ORD_PROJECT), so a sample can carry both without collision.
  // Use meta.dr_cluster only — project has its own meta.dr_project.
  // --pca-pre-method/--pca-pre-batch-size are gated on --pca-pre, since the CLI
  // only reads them alongside that toggle.
  // Screen spec fields are repeatable CLI flags: one token per samplesheet list item.
  def sample_args = ["--dims ${meta.cluster_dims}", meta.dr_cluster ? "--dr ${meta.dr_cluster.join(',')}" : null, "--scale ${meta.scale}", "--norm ${meta.norm}", meta.pca_pre ? "--pca-pre" : null, meta.pca_pre && meta.pca_pre_method ? "--pca-pre-method ${meta.pca_pre_method}" : null, meta.pca_pre && meta.pca_pre_batch_size != null ? "--pca-pre-batch-size ${meta.pca_pre_batch_size}" : null, meta.keep_pcs != null ? "--keep-pcs ${meta.keep_pcs}" : null, meta.keep_variance != null ? "--keep-variance ${meta.keep_variance}" : null, meta.screen_params ? "--screen_params" : null, meta.screen_values1 ? meta.screen_values1.collect { spec -> "--screen_values1 ${spec}" }.join(" ") : null, meta.screen_values2 ? meta.screen_values2.collect { spec -> "--screen_values2 ${spec}" }.join(" ") : null, meta.screen_range1 ? meta.screen_range1.collect { spec -> "--screen_range1 ${spec}" }.join(" ") : null, meta.screen_range2 ? meta.screen_range2.collect { spec -> "--screen_range2 ${spec}" }.join(" ") : null, meta.screen_grid ? "--screen_grid ${meta.screen_grid}" : null, meta.cluster ? "--cluster ${meta.cluster.join(',')}" : null, meta.leiden_sweep ? "--leiden-sweep" : null, meta.hdbscan_sweep ? "--hdbscan-sweep" : null, meta.dbscan_sweep ? "--dbscan-sweep" : null].findAll { argument -> argument }.join(" ")

  """
    export HOME=\$PWD

    mkdir -p results

    kmer-ord cluster \\
        --input ${input} \\
        --output results \\
        --threads ${threads} \\
        --kmer ${meta.kmer} \\
        ${sample_args} \\
        ${args}

    # Standalone cluster writes discovery.sqlite; project writes kmerord.sqlite.
    # Rename so pipeline I/O stays consistent across stages.
    if [ -f results/discovery.sqlite ] && [ ! -f results/kmerord.sqlite ]; then
        mv results/discovery.sqlite results/kmerord.sqlite
    fi

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        kmer-ord: aa22b130903e8f6aa71c881b22c4b18b2efd2486
    END_VERSIONS
    """

  stub:
  """
    mkdir -p results/clusters

    touch results/stub.txt
    touch results/kmerord.sqlite
    touch results/clusters/stub_hdbscan_clusters.tsv

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        kmer-ord: stub
    END_VERSIONS
    """
}

process KMER_ORD_PROJECT {

  tag "${meta.id}_k=${meta.kmer}"
  label 'process_high'
  label 'process_high_memory'
  label 'process_long'

  conda "${moduleDir}/environment.yml"
  container "${workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container
    ? '/ibex/project/c2303/20260614_make-kmer-ord-singularity-container/kmer-ord.linux.amd64.potentiallyWorking.needsTesting.20260719.sif'
    : 'docker://PLACEHOLDER_DOCKER_IMAGE'}"

  input:
  tuple val(meta), path(input)

  output:
  tuple val(meta), path("results"), emit: results_dir
  tuple val(meta), path("results/kmerord.sqlite"), emit: db
  path "versions.yml", emit: versions

  when:
  task.ext.when == null || task.ext.when

  script:
  def args = task.ext.args ?: ""
  if (meta.threads != null && meta.threads > task.cpus) {
    error("Sample ${meta.id} requests ${meta.threads} threads, but KMER_ORD_PROJECT was allocated ${task.cpus} CPUs.")
  }
  def threads = meta.threads ?: task.cpus

  // Use meta.dr_project only — cluster has its own meta.dr_cluster.
  def sample_args = [
      meta.tiara ? "--tiara" : null,
      meta.dr_project ? "--dr ${meta.dr_project.join(',')}" : null,
      "--scale ${meta.scale}",
      "--norm ${meta.norm}",
      "--dims ${meta.dims}",
      meta.pca_pre ? "--pca-pre" : null,
      meta.keep_pcs != null ? "--keep-pcs ${meta.keep_pcs}" : null,
      meta.keep_variance != null ? "--keep-variance ${meta.keep_variance}" : null,
      meta.screen_params ? "--screen-params" : null
  ].findAll { argument -> argument }.join(" ")

  """
    export HOME=\$PWD

    mkdir -p results

    kmer-ord project \\
        --input ${input} \\
        --output results \\
        --threads ${threads} \\
        --kmer ${meta.kmer} \\
        ${sample_args} \\
        ${args}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        kmer-ord: aa22b130903e8f6aa71c881b22c4b18b2efd2486
    END_VERSIONS
    """

  stub:
  """
    mkdir -p results

    touch results/stub.txt
    touch results/kmerord.sqlite

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        kmer-ord: stub
    END_VERSIONS
    """
}

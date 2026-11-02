process KMER_ORD_RDNA_DB {

  tag "${db_dir}"
  label 'process_medium'
  label 'process_long'

  conda "${moduleDir}/environment.yml"
  container "${workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container
    ? '/ibex/project/c2303/20260614_make-kmer-ord-singularity-container/kmer-ord.linux.amd64.potentiallyWorking.needsTesting.20261029.RAM-efficient-fork.v14.sif'
    : 'docker://PLACEHOLDER_DOCKER_IMAGE'}"

  // The database is a shared host path, not a staged input. Bind it so the
  // download is written on the host filesystem rather than the container overlay.
  // The workflow creates the directory first; Singularity will not mount a missing path.
  containerOptions { "--bind ${db_dir}:${db_dir}" }

  input:
  val(db_dir)

  output:
  val(db_dir), emit: db_dir
  path "versions.yml", emit: versions

  when:
  task.ext.when == null || task.ext.when

  script:
  // Install into the shared directory itself. Do not pass --force: databases
  // that are already present are left in place, and missing ones are filled in.
  """
    export HOME=\$PWD

    kmer-ord rdna-db install all --db-dir '${db_dir}'

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        kmer-ord: aa22b130903e8f6aa71c881b22c4b18b2efd2486
    END_VERSIONS
    """

  stub:
  """
    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        kmer-ord: stub
    END_VERSIONS
    """
}

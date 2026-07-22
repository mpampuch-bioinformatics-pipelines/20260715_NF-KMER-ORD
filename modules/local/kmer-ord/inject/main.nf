process KMER_ORD_INJECT {

  tag "${meta.id}"
  label 'process_low'

  conda "${moduleDir}/environment.yml"
  container "${workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container
    ? '/ibex/project/c2303/20260614_make-kmer-ord-singularity-container/kmer-ord.linux.amd64.potentiallyWorking.needsTesting.20260719.sif'
    : 'docker://PLACEHOLDER_DOCKER_IMAGE'}"

  input:
  tuple val(meta), path(db), path(input)

  output:
  tuple val(meta), path("results/kmerord.sqlite"), emit: db
  path "versions.yml", emit: versions

  when:
  task.ext.when == null || task.ext.when

  script:
  def args = task.ext.args ?: ""

  // `kmer-ord inject` edits the database in place. The staged ${db} is a symlink
  // to an upstream module's output, so inject a private copy instead to avoid
  // mutating (and re-publishing changes to) that upstream file.
  """
    export HOME=\$PWD

    mkdir -p results
    cp ${db} results/kmerord.sqlite

    kmer-ord inject \\
        --db results/kmerord.sqlite \\
        --input ${input} \\
        ${args}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        kmer-ord: aa22b130903e8f6aa71c881b22c4b18b2efd2486
    END_VERSIONS
    """

  stub:
  """
    mkdir -p results
    touch results/kmerord.sqlite

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        kmer-ord: stub
    END_VERSIONS
    """
}
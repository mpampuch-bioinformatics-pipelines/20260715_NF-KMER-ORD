process KMER_ORD_INJECT {

  tag "${meta.id}_k=${meta.kmer}"
  label 'process_low'

  conda "${moduleDir}/environment.yml"
  container "${workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container
    ? '/ibex/project/c2303/20260614_make-kmer-ord-singularity-container/kmer-ord.linux.amd64.potentiallyWorking.needsTesting.20260719.sif'
    : 'docker://PLACEHOLDER_DOCKER_IMAGE'}"

  input:
  // tsvs: one or more feature TSVs (cluster assignments and/or optional samplesheet inject_tsv)
  tuple val(meta), path(db), path(tsvs)

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
  //
  // Non-sequence_id columns are cast to string before inject so cluster IDs
  // (integers) are treated as categorical features by kmer-ord visualise.
    """
    export HOME=\$PWD
    
    mkdir -p results
    cp ${db} results/kmerord.sqlite
    
    for tsv in ${tsvs}; do
        CASTED="casted_\$(basename "\$tsv")"
    
        python3 - "\$tsv" "\$CASTED" <<'PY'
    import sys
    import pandas as pd
    from pathlib import Path
    
    src = Path(sys.argv[1])
    out = Path(sys.argv[2])
    
    df = pd.read_csv(src, sep='\t')
    
    if 'sequence_id' not in df.columns:
        raise SystemExit(f"ERROR: {src} missing required 'sequence_id' column")
    
    for col in df.columns:
        if col != 'sequence_id':
            df[col] = df[col].astype(str)
    
    df.to_csv(out, sep='\t', index=False)
    PY
    
        kmer-ord inject \
            --db results/kmerord.sqlite \
            --input "\$CASTED" \
            ${args}
    done
    
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

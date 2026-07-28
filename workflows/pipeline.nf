/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    IMPORT MODULES / SUBWORKFLOWS / FUNCTIONS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
include { KMER_ORD_PROJECT       } from '../modules/local/kmer-ord/project/main'
include { KMER_ORD_CLUSTER       } from '../modules/local/kmer-ord/cluster/main'
include { KMER_ORD_INJECT        } from '../modules/local/kmer-ord/inject/main'
include { KMER_ORD_VISUALISE     } from '../modules/local/kmer-ord/visualise/main'
include { softwareVersionsToYAML } from '../subworkflows/nf-core/utils_nfcore_pipeline'

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    RUN MAIN WORKFLOW
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

workflow PIPELINE {

    take:
    ch_samplesheet // channel: [ val(meta), path(reads), path(inject_tsv) ]
    main:

    ch_versions = channel.empty()

    // reads-only view for the modules that consume the fasta/fastq input
    ch_reads = ch_samplesheet.map { meta, reads, _inject_tsv -> [meta, reads] }

    // Filter reads for projection workflow based on params.run_projection and sample meta.dr_project
    ch_project_reads = ch_reads.filter { meta, _reads ->
        (params.run_projection == null || params.run_projection) && meta.dr_project
    }

    // Filter reads for clustering workflow based on params.run_clustering and sample meta.dr_cluster
    ch_cluster_reads = ch_reads.filter { meta, _reads ->
        (params.run_clustering == null || params.run_clustering) && meta.dr_cluster
    }

    //
    // MODULE: Projection (optional)
    //
    KMER_ORD_PROJECT(ch_project_reads)
    ch_versions = ch_versions.mix(KMER_ORD_PROJECT.out.versions)

    //
    // MODULE: Clustering (optional)
    //
    KMER_ORD_CLUSTER(ch_cluster_reads)
    ch_versions = ch_versions.mix(KMER_ORD_CLUSTER.out.versions)

    //
    // MODULE: Inject cluster assignment columns (and/or optional samplesheet inject_tsv)
    // into each sample's project database features table.
    //
    ch_inject_input = KMER_ORD_PROJECT.out.db
        .join(KMER_ORD_CLUSTER.out.cluster_tsvs, remainder: true)
        .join(ch_samplesheet.map { meta, _reads, inject_tsv -> [meta, inject_tsv] })
        .map { meta, db, cluster_tsvs, inject_tsv ->
            def tsvs = []
            if (cluster_tsvs) {
                tsvs += (cluster_tsvs instanceof List ? cluster_tsvs : [cluster_tsvs])
            }
            if (inject_tsv) {
                tsvs += (inject_tsv instanceof List ? inject_tsv : [inject_tsv])
            }
            [meta, db, tsvs]
        }
        .branch { meta, db, tsvs ->
            inject: db != null && !tsvs.isEmpty()
            no_inject: db != null && tsvs.isEmpty()
            skip: db == null
        }

    KMER_ORD_INJECT(ch_inject_input.inject)
    ch_versions = ch_versions.mix(KMER_ORD_INJECT.out.versions)

    // Combine injected databases and non-injected databases for visualization
    ch_vis_db = KMER_ORD_INJECT.out.db.mix(
        ch_inject_input.no_inject.map { meta, db, _tsvs -> [meta, db] }
    )

    //
    // MODULE: Visualise database tables (feature distributions + embedding plots)
    // Visualization is executed automatically whenever projection workflow is run.
    //
    KMER_ORD_VISUALISE(ch_vis_db)
    ch_versions = ch_versions.mix(KMER_ORD_VISUALISE.out.versions)

    //
    // Collate and save software versions
    //
    def topic_versions = Channel.topic("versions")
        .distinct()
        .branch { entry ->
            versions_file: entry instanceof Path
            versions_tuple: true
        }

    def topic_versions_string = topic_versions.versions_tuple
        .map { process, tool, version ->
            [ process[process.lastIndexOf(':')+1..-1], "  ${tool}: ${version}" ]
        }
        .groupTuple(by:0)
        .map { process, tool_versions ->
            tool_versions.unique().sort()
            "${process}:\n${tool_versions.join('\n')}"
        }

    softwareVersionsToYAML(ch_versions.mix(topic_versions.versions_file))
        .mix(topic_versions_string)
        .collectFile(
            storeDir: "${params.outdir}/pipeline_info",
            name:  'pipeline_software_'  + 'mqc_'  + 'versions.yml',
            sort: true,
            newLine: true
        ).set { ch_collated_versions }

    emit:
    multiqc_report = channel.empty() // MULTIQC removed
    versions       = ch_versions     // channel: [ path(versions.yml) ]

}

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    THE END
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

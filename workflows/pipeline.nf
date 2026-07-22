/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    IMPORT MODULES / SUBWORKFLOWS / FUNCTIONS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
include { KMER_ORD_PROJECT       } from '../modules/local/kmer-ord/project/main'
include { KMER_ORD_CLUSTER       } from '../modules/local/kmer-ord/cluster/main'
include { KMER_ORD_INJECT        } from '../modules/local/kmer-ord/inject/main'
include { KMER_ORD_VISUALISE     } from '../modules/local/kmer-ord/visualise/main'
include { MULTIQC                } from '../modules/nf-core/multiqc/main'
include { paramsSummaryMap       } from 'plugin/nf-schema'
include { paramsSummaryMultiqc   } from '../subworkflows/nf-core/utils_nfcore_pipeline'
include { softwareVersionsToYAML } from '../subworkflows/nf-core/utils_nfcore_pipeline'
include { methodsDescriptionText } from '../subworkflows/local/utils_nfcore_pipeline_pipeline'

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
    ch_multiqc_files = channel.empty()

    // reads-only view for the modules that consume the fasta/fastq input
    ch_reads = ch_samplesheet.map { meta, reads, _inject_tsv -> [meta, reads] }

    //
    // MODULE: Projection pipeline -> builds kmerord.sqlite (stats, k-mer counts, 2D/3D embedding)
    //
    KMER_ORD_PROJECT(ch_reads)
    ch_versions = ch_versions.mix(KMER_ORD_PROJECT.out.versions)

    //
    // MODULE: Cluster inference pipeline -> integrates high-D embedding + cluster assignments
    // into the same database. Joined on meta so each run's reads meet their own project DB.
    //
    ch_cluster_input = ch_reads.join(KMER_ORD_PROJECT.out.db)
    KMER_ORD_CLUSTER(ch_cluster_input)
    ch_versions = ch_versions.mix(KMER_ORD_CLUSTER.out.versions)

    //
    // MODULE: Optionally inject extra feature columns from a per-sample TSV before visualising.
    // Samples without an inject_tsv (value []) bypass KMER_ORD_INJECT untouched.
    //
    ch_db_with_inject = KMER_ORD_CLUSTER.out.db
        .join(ch_samplesheet.map { meta, _reads, inject_tsv -> [meta, inject_tsv] })
        .branch { _meta, _db, inject_tsv ->
            inject: inject_tsv
            passthrough: true
        }

    KMER_ORD_INJECT(ch_db_with_inject.inject)
    ch_versions = ch_versions.mix(KMER_ORD_INJECT.out.versions)

    ch_db_for_visualise = KMER_ORD_INJECT.out.db
        .mix(ch_db_with_inject.passthrough.map { meta, db, _inject_tsv -> [meta, db] })

    //
    // MODULE: Visualise database tables (feature distributions + embedding plots)
    //
    KMER_ORD_VISUALISE(ch_db_for_visualise)
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


    //
    // MODULE: MultiQC
    //
    ch_multiqc_config        = channel.fromPath(
        "$projectDir/assets/multiqc_config.yml", checkIfExists: true)
    ch_multiqc_custom_config = params.multiqc_config ?
        channel.fromPath(params.multiqc_config, checkIfExists: true) :
        channel.empty()
    ch_multiqc_logo          = params.multiqc_logo ?
        channel.fromPath(params.multiqc_logo, checkIfExists: true) :
        channel.empty()

    summary_params      = paramsSummaryMap(
        workflow, parameters_schema: "nextflow_schema.json")
    ch_workflow_summary = channel.value(paramsSummaryMultiqc(summary_params))
    ch_multiqc_files = ch_multiqc_files.mix(
        ch_workflow_summary.collectFile(name: 'workflow_summary_mqc.yaml'))
    ch_multiqc_custom_methods_description = params.multiqc_methods_description ?
        file(params.multiqc_methods_description, checkIfExists: true) :
        file("$projectDir/assets/methods_description_template.yml", checkIfExists: true)
    ch_methods_description                = channel.value(
        methodsDescriptionText(ch_multiqc_custom_methods_description))

    ch_multiqc_files = ch_multiqc_files.mix(ch_collated_versions)
    ch_multiqc_files = ch_multiqc_files.mix(
        ch_methods_description.collectFile(
            name: 'methods_description_mqc.yaml',
            sort: true
        )
    )

    MULTIQC (
        ch_multiqc_files.collect(),
        ch_multiqc_config.toList(),
        ch_multiqc_custom_config.toList(),
        ch_multiqc_logo.toList(),
        [],
        []
    )

    emit:multiqc_report = MULTIQC.out.report.toList() // channel: /path/to/multiqc_report.html
    versions       = ch_versions                 // channel: [ path(versions.yml) ]

}

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    THE END
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process ALDY_GENOTYPE {
    tag "${sample_id}:${gene}"
    publishDir { "${params.outdir}/${sample_id}" }, mode: 'copy'

    input:
    tuple val(sample_id), path(bam), path(bai), val(gene)

    output:
    tuple val(sample_id), val(gene), path("${sample_id}_${gene}.aldy")
    path "${sample_id}_${gene}.log"

    script:
    """
    aldy genotype \\
        -p ${params.sequencer} \\
        --genome ${params.genome} \\
        -g ${gene} \\
        -o ${sample_id}_${gene}.aldy \\
        --log ${sample_id}_${gene}.log \\
        ${bam}
    """
}

workflow {
    bam_ch = Channel
        .fromPath(params.bams)
        .map { bam -> tuple(bam.simpleName, bam, file("${bam}.bai", checkIfExists: true)) }

    gene_ch = Channel.fromList(params.genes.tokenize())

    ALDY_GENOTYPE(bam_ch.combine(gene_ch))
}

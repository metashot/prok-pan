#!/usr/bin/env nextflow

nextflow.enable.dsl=2

include { prokka } from './modules/prokka'
include { roary; roary_plots } from './modules/roary'
include { raxml } from './modules/gubbins'

workflow {
    
    Channel
        .fromPath( params.genomes )
        .map { file -> tuple(file.baseName, file) }
        .set { genomes_ch }

    proteins_file = file(params.proteins, type: 'file')

    prokka(genomes_ch, proteins_file)

    gff_collection_ch = prokka.out.gff
        .map { row -> row[1] }
        .collect()

    roary(gff_collection_ch)

    if (!params.skip_core_tree){
        raxml(roary.out.aln)
        tree_ch = raxml.out.tree
    }
    else {
        tree_ch = roary.out.accessory_tree
    }

    roary_plots(tree_ch, roary.out.gene_pa)
}


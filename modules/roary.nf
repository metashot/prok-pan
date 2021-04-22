nextflow.enable.dsl=2

process roary {
    publishDir "${params.outdir}" , mode: 'copy'

    input:
    path(gffs)
    
    output:
    path "roary/*"
    path "roary/core_gene_alignment.aln", emit: aln
    path "roary/gene_presence_absence.csv", emit: gene_pa
    path "roary/accessory_binary_genes.fa.newick", emit: accessory_tree
   
    script:
    if( params.mode == 'Viruses') {
        param_translation = '-t 1'
    }
    else if ( params.mode == 'Mitochondria' ) {
        param_translation = '-t 4'
    }
    else {
        param_translation = '-t 11'
    }

    param_dont_split_paralogs = params.dont_split_paralogs ? '-s' : ''
    """
    roary \
        -e -n \
        ${param_translation} \
        -p ${task.cpus} \
        -f roary \
        -i ${params.min_ident} \
        -cd ${params.min_prev_core} \
        ${param_dont_split_paralogs} \
        ${gffs}
    """
}


process roary_plots {
    publishDir "${params.outdir}/roary" , mode: 'copy'

    input:
    path(tree)
    path(gene_pa)

    output:
    path "pangenome_*"

    script:
    """
    roary_plots.py ${tree} ${gene_pa}
    """
}

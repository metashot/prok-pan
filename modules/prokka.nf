nextflow.enable.dsl=2

process prokka {
    tag "${id}"

    publishDir "${params.outdir}/prokka" , mode: 'copy'

    input:
    tuple val(id), path(genome)
    path (proteins)

    output:
    path "${id}/*"
    tuple val(id), path ("${id}/${id}.gff"), emit: gff

    script:
    param_proteins = params.proteins != 'none' ? "--proteins $proteins" : ''
    """
    prokka \
        $genome \
        --outdir ${id} \
        --prefix ${id} \
        --kingdom ${params.mode} \
        $param_proteins \
        --cpus ${task.cpus}
    """
}


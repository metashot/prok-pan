nextflow.enable.dsl=2

process raxml {
    publishDir "${params.outdir}/raxml" , mode: 'copy'
    
    input:
    path(aln)

    output:
    path "*.run"
    path "RAxML_bestTree.run", emit: tree

    script:
    """
    raxmlHPC-PTHREADS-SSE3 \
        -f d \
        -m GTRCAT \
        -p 42 \
        -T ${task.cpus} \
        -n run \
        -N ${params.raxml_nsearch} \
        -s ${aln}
    """
}

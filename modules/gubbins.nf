nextflow.enable.dsl=2

process raxml {
    publishDir "${params.outdir}/raxml" , mode: 'copy'
    
    input:
    path(aln)

    output:
    path "*.run"
    path "RAxML_bestTree.run", emit: tree

    script:
    if (params.raxml_mode == 'default')
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

    else if ( params.raxml_mode == 'rbs' )
        """
        raxmlHPC-PTHREADS-SSE3 \
            -f a \
            -x 43 \
            -N ${params.raxml_nboot} \
            -m GTRCAT \
            -p 42 \
            -T ${task.cpus} \
            -n run \
            -s ${aln}
        """
        
    else
        error "Invalid RAxML mode: ${params.raxml_mode}"

}

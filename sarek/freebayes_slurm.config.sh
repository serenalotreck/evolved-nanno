process {
    executor = 'slurm'

    withName: 'FREEBAYES' {
        ext.args   = { '-p 1 --pooled-continuous --pooled-discrete --min-alternate-fraction 0.1 --min-mapping-quality 1' }
        //To make sure no naming conflicts ensure with module BCFTOOLS_SORT & the naming being correct in the output folder
        ext.prefix = { meta.num_intervals <= 1 ? "${meta.id}" : "${meta.id}.${target_bed.baseName}" }
        ext.when   = { params.tools && params.tools.split(',').contains('freebayes') }
        publishDir = [
            enabled: false
        ]
    }

    // PAIR_VARIANT_CALLING
    if (params.tools && params.tools.split(',').contains('freebayes')) {
        withName: '.*:BAM_VARIANT_CALLING_SOMATIC_ALL:BAM_VARIANT_CALLING_FREEBAYES:FREEBAYES' {
            ext.args = { "-p 1 \
                            --pooled-continuous \
                    --pooled-discrete \
                            --genotype-qualities \
                            --report-genotype-likelihood-max \
                            --allele-balance-priors-off \
                            --min-alternate-fraction 0.03 \
                            --min-repeat-entropy 1 \
                            --min-alternate-count 2 " }
        }
    }
}

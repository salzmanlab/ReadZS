include { CONCAT_REFS   } from  '../../../modules/local/donor/concat_refs'
include { BOWTIE2_BUILD } from  '../../../modules/nf-core/modules/bowtie2/build/main'

workflow MAKE_REF {
    take:

    main:
    // STEP 0: Make reference file
    if (params.reference) {
        fasta = file(params.reference)
    } else {
        CONCAT_REFS (
            params.reference_samplesheet,
            params.reference_type,
            params.run_name
        )
        fasta = CONCAT_REFS.out.fasta
    }

    // STEP 1: Build bowtie2 reference
    BOWTIE2_BUILD (
        CONCAT_REFS.out.fasta
    )

    emit:
    index = BOWTIE2_BUILD.out.index
}
process MERGE {
  tag "${basename}"
  label 'process_low'

  publishDir "${params.outdir}/${subDir}",
    mode: 'copy'

  input:
  path chr_merge_list
  val runName
  val subDir
  val removeHeader

  output:
  path "*.txt", emit: merged

  script:
  basename = chr_merge_list.baseName
  outputFile = "${runName}_${basename}.txt"

  if (removeHeader == true)
    """
    rm -f ${outputFile}
    cat ${chr_merge_list} |
        while read f; do
        tail -n +2 \$f
        done >> ${outputFile}
    """
  else
    """
    rm -f ${outputFile}
    cat ${chr_merge_list} |
        while read f; do
        cat \$f
        done >> ${outputFile}
    """
}

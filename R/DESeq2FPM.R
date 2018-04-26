#' @importFrom DESeq2 fpm
#' @importFrom reshape2 melt
#' @importFrom ggplot2 ggplot
globalVariables(".")


NULL

#' Calculates FPM from DESeq2 object

#' @param DESeq2_object created using feat2deseq2 function
#' @param feat_count A tsv file from featurecount
#' @param outdir A folder to write all the files
#'
#'
#' @return creates CSV fpm table based off DEDeq2 object
#'
#' @export
#'
#'

DESeq2FPM <- function(DESeq2_object, feat_count, outdir){

    base::ifelse(!base::dir.exists(outdir), base::dir.create(outdir), print("already exist"))

    fpm_results <- DESeq2::fpm(DESeq2_object, robust=TRUE)
    out_fpm <- base::file.path(outdir,
                                base::paste(base::strsplit(base::basename(feat_count),
                                                           ".tsv")[[1]],
                                            "_FPM.csv", sep=""))

    utils::write.csv(fpm_results, file = out_fpm, row.names = TRUE)
    return(fpm_results)
}

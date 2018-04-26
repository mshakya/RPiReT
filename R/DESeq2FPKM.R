#' @importFrom DESeq2 fpkm
#' @importFrom dplyr filter_all
#' @importFrom reshape2 melt
#' @importFrom ggplot2 ggplot
globalVariables(".")


NULL

#' Calculates FPKM from DESeq2 object and creates corresponding figures

#' @param DESeq2_object created using feat2deseq2 function
#' @param feat_count A tsv file from featurecount
#' @param outdir A folder to write all the files
#'
#'
#' @return creates CSV fpkm table base off DEDeq2 object
#'
#' @export
#'
#'

DESeq2FPKM <- function(DESeq2_object, feat_count, outdir){

    base::ifelse(!base::dir.exists(outdir), base::dir.create(outdir), print("already exist"))

    fpkm_results <- DESeq2::fpkm(DESeq2_object, robust=TRUE)
    out_fpkm <- base::file.path(outdir,
                                base::paste(base::strsplit(base::basename(feat_count),
                                                           ".tsv")[[1]],
                                            "_FPKM.csv", sep=""))

    utils::write.csv(fpkm_results, file = out_fpkm, row.names = TRUE)
}

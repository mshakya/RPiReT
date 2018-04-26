#' @importFrom DESeq2 fpm
#' @importFrom pheatmap pheatmap
#' @importFrom utils read.csv
#'
#'

NULL

#' Produces heatmap plots based on the FPKM table

#' @param fpm_table A csv table with fpm, generated using DESeq2FPKM
#' @param exp_desn  An experimental design file of PiReT
#' @param outdir A folder to write all the files
#'
#'
#' @return creates PDF and PNG figures from FPM tables
#'
#' @export
#'
#'

FPM_heatmap <- function(fpm_table, exp_desn, outdir){

    base::ifelse(!base::dir.exists(outdir), base::dir.create(outdir), print("already exist"))
    fpm_df <- utils::read.csv(fpm_table, row.names = 1)

    fpm_heatmap_pdf <- file.path(outdir,
                                  paste(strsplit(basename(fpm_table), ".csv")[[1]],
                                        "_heatmap.pdf", sep=""))
    fpm_heatmap_png <- file.path(outdir,
                                  paste(strsplit(basename(fpm_table), ".csv")[[1]],
                                        "_heatmap.png", sep=""))
    pheatmap::pheatmap(as.matrix(fpm_df), legend=TRUE, filename = fpm_heatmap_pdf)
    pheatmap::pheatmap(as.matrix(fpm_df), legend=TRUE, filename = fpm_heatmap_png)

}

#' @importFrom DESeq2 fpkm
#' @importFrom pheatmap pheatmap
#' @importFrom utils read.csv
#'

NULL

#' Produces heatmap plots based on the FPKM table

#' @param fpkm_table A csv table with fpkm, generated using DESeq2FPKM
#' @param exp_desn  An experimental design file of PiReT
#' @param outdir A folder to write all the files
#'
#'
#' @return creates PDF and PNG figures from FPKM tables
#'
#' @export
#'
#'

FPKM_heatmap <- function(fpkm_table, exp_desn, outdir){

    base::ifelse(!base::dir.exists(outdir), base::dir.create(outdir), print("already exist"))
    fpkm_df <- utils::read.csv(fpkm_table, row.names = 1)

    fpkm_heatmap_pdf <- file.path(outdir,
                                      paste(strsplit(basename(fpkm_table), ".csv")[[1]],
                                            "_heatmap.pdf", sep=""))
    fpkm_heatmap_png <- file.path(outdir,
                                      paste(strsplit(basename(fpkm_table), ".csv")[[1]],
                                            "_heatmap.png", sep=""))
    pheatmap::pheatmap(as.matrix(fpkm_df), legend=TRUE, filename = fpkm_heatmap_pdf)
    pheatmap::pheatmap(as.matrix(fpkm_df), legend=TRUE, filename = fpkm_heatmap_png)

}

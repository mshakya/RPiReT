#' @importFrom ggplot2 ggplot
#' @importFrom pheatmap pheatmap
#' @importFrom utils read.csv
globalVariables(".")
#'
#'

NULL

#' Produces heatmap plots based on the FPKM table

#' @param f_table A csv table with fpm, generated using DESeq2FPKM
#' @param exp_desn  An experimental design file of PiReT
#' @param score_type FPM or FPKM
#' @param feature_name name of the feature from gff table that is being counted
#' @param outdir A folder to write all the files
#'
#'
#' @return creates PDF and PNG figures from FPM/FPKM tables
#'
#' @export
#'
#'

DESeq2_histogram <- function(f_table, exp_desn, outdir, score_type, feature_name){

    base::ifelse(!base::dir.exists(outdir), base::dir.create(outdir), print("already exist"))
    df <- utils::read.csv(f_table, row.names = 1)
    histogram_pdf <- file.path(outdir,
                                 paste(strsplit(basename(f_table), ".csv")[[1]],
                                       "_histogram.pdf", sep=""))
    histogram_png <- file.path(outdir,
                                 paste(strsplit(basename(f_table), ".csv")[[1]],
                                       "_histogram.png", sep=""))

    df_results <- dplyr::filter_all(as.data.frame(df), dplyr::any_vars(. != 0))
    f_data <- reshape2::melt(as.data.frame(df_results), variable.name="sample", value.name=score_type)
    f_hist <- ggplot2::ggplot(data = f_data, mapping = ggplot2::aes_string(x = score_type)) +  ggplot2::theme_bw() +
             ggplot2::geom_histogram(bins=100) + ggplot2::xlab(score_type) + ggplot2::ylab(feature_name) + ggplot2::facet_wrap(~sample)
    ggplot2::ggsave(histogram_pdf, f_hist, device = "pdf")
    ggplot2::ggsave(histogram_png, f_hist, device = "png")

}

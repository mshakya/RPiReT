#' @importFrom ggplot2 ggplot
#' @importFrom utils read.csv
globalVariables(".")
#'
#'

NULL

#' Produces violin plots based on the FPKM/FPM table

#' @param f_table A csv table with fpm or fpkm, generated using DESeq2FPKM or DESeq2FPM
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

DESeq2_violin <- function(f_table, exp_desn, outdir, score_type, feature_name){

    base::ifelse(!base::dir.exists(outdir),
                 base::dir.create(outdir),
                 print("already exist"))
    df <- utils::read.csv(f_table, row.names = 1)
    violin_pdf <- file.path(outdir,
                               paste(strsplit(basename(f_table), ".csv")[[1]],
                                     "_violin.pdf", sep = ""))
    violin_png <- file.path(outdir,
                               paste(strsplit(basename(f_table), ".csv")[[1]],
                                     "_violin.png", sep = ""))

    df_results <- dplyr::filter_all(as.data.frame(df), dplyr::any_vars(. != 0))
    f_data <- reshape2::melt(as.data.frame(df_results),
                             variable.name = "sample", value.name = score_type)
    group_table <- read.delim(exp_desn, row.names = 1)
    group_table <- dplyr::select(group_table, "Group")
    group_table2 <- tibble::rownames_to_column(group_table, "sample")
    f_data_boxplot <- merge(x = f_data, y = group_table2)
    print(head(f_data_boxplot))
    f_violin <- ggplot2::ggplot(data = f_data_boxplot, mapping = ggplot2::aes_string(x = "Group", y = score_type)) +
        ggplot2::theme_bw() + ggplot2::geom_violin(ggplot2::aes(fill = factor(Group)))

    ggplot2::ggsave(violin_pdf, f_violin, device = "pdf")
    ggplot2::ggsave(violin_png, f_violin, device = "png")

}

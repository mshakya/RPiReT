#' @importFrom ggplot2 ggplot
globalVariables(".")
#'
#'

NULL

#' Produces CA plot

#' @param feat_count Count table from featurecounts
#' @param DESeq2_object A DESeq2 object
#' @param feature_name name of the feature from gff table that is being counted
#' @param outdir A folder to write all the files
#'
#'
#' @return creates PCA plot of PDF and PNG figures
#'
#' @export
#'
#'

DESeq2_CAplot <- function(feat_count, DESeq2_object, outdir, feature_name){

    base::ifelse(!base::dir.exists(outdir),
                 base::dir.create(outdir),
                 print("already exist"))
    dds <- DESeq2::DESeq(DESeq2_object)
    pca_pdf <- file.path(outdir,
                         paste(strsplit(basename(feat_count), ".tsv")[[1]],
                               "_PCA.pdf", sep = ""))
    pca_png <- file.path(outdir,
                         paste(strsplit(basename(feat_count), ".tsv")[[1]],
                               "_PCA.png", sep = ""))

    dds_vts <- DESeq2::varianceStabilizingTransformation(dds)
    pca <- DESeq2::plotPCA(dds_vts, intgroup = c("Group"))
    ggplot2::ggsave(pca_pdf, pca, device = "pdf")
    ggplot2::ggsave(pca_png, pca, device = "png")

}

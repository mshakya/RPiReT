#' @importFrom GenomicRanges makeGRangesFromDataFrame
#' @importFrom  DESeq2 DESeqDataSetFromMatrix counts
#' @importFrom dplyr select
#' @importFrom utils read.table write.csv


NULL

#' Creates a DESeq2 object from featurecount table and experimental design file

#' @param feat_count A tsv file from featurecount
#' @param exp_desn experimental design file for PiReT
#'
#'
#' @return DESeq2 object with features that dont have any counts removed
#'
#' @export
#'
#'

feat2deseq2 <- function(feat_count, exp_desn){

    # read table
    read_counts <- utils::read.table(feat_count, sep = "\t", header = TRUE,
                                     row.names = 1)
    names(read_counts) <- base::gsub(".*mapping_results.", "",
                                     names(read_counts),
                                     perl = TRUE)
    names(read_counts) <- base::gsub("_srt.bam", "", names(read_counts), perl = TRUE)
    gene_info <- read_counts[, c(1:6)]
    #gene_ranges <- GenomicRanges::makeGRangesFromDataFrame(gene_info)

    #read in the table with group info
    group_table <- utils::read.table(exp_desn, colClasses = c("character"),
                                     comment.char = "#", row.names = 1,
                                     sep = "\t", header = FALSE)
    colnames(group_table) <- c("Files", "Group")
    group_table <- dplyr::select(group_table, Group)
    read_counts <- read_counts[, rownames(group_table)]
    deseq_ds <- DESeq2::DESeqDataSetFromMatrix(countData = read_counts,
                                              colData = group_table,
                                              design = ~ Group,
                                              tidy = FALSE)
#                                              rowRanges = gene_ranges)

    featureData <- data.frame(basepairs = gene_info$Length)
    S4Vectors::mcols(deseq_ds) <- S4Vectors::DataFrame(S4Vectors::mcols(deseq_ds),
                                            featureData)

  # remove genes without any counts
  deseq_ds <- deseq_ds[base::rowSums(DESeq2::counts(deseq_ds)) > 0, ]

  return(deseq_ds)
}

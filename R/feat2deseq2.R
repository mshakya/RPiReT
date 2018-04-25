#' @importFrom GenomicRanges makeGRangesFromDataFrame
#' @importFrom  DESeq2 DESeqDataSetFromMatrix
#' @importFrom dplyr select
#' @importFrom utils read.table


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
    read.counts <- read.table(feat_count, sep = "\t", header = TRUE, row.names = 1)
    names(read.counts) <- base::gsub(".*mapping_results.", "", names(read.counts),
                                     perl = TRUE)
    names(read.counts) <- base::gsub("_srt.bam", "", names(read.counts), perl = TRUE)
    gene.info <- read.counts[, c(1:5)]
    gene.ranges <- GenomicRanges::makeGRangesFromDataFrame(gene.info)

    #read in the table with group info
    group_table <- utils::read.delim(exp_desn, row.names = 1)
    group_table <- dplyr::select(group_table, Group)
    read.counts <- read.counts[, rownames(group_table)]
    deseq_ds <- DESeq2::DESeqDataSetFromMatrix(countData = read.counts,
                                              colData = group_table,
                                              design = ~ Group,
                                              tidy = FALSE,
                                              rowRanges=gene.ranges)

  # remove genes without any counts
  deseq_ds <- deseq_ds[base::rowSums(counts(deseq_ds)) > 0, ]

  return(deseq_ds)
}


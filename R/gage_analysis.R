#' @importFrom dplyr select
#' @importFrom utils read.table write.csv


NULL

#' Conducts GAGE analysis using fold change data.

#'
#' @param fc A table produced by edgeR or DESeq2 that contains fold change information.
#' @param type edgeR or DESeq2.
#' @param org An organism code provided by KEGG.
#' @param out_dir Output directory where tables are written.
#'
#'
#' @return Table with list of pathways and their corresponding p-values indicating if they are differently expressed between two conditions
#'
#' @export

gage_analysis <- function(fc, type, org, out_dir){

    if (type == "edgeR") {
        edger <- utils::read.csv(fc, header = TRUE, row.names = 1)
        edger.fc <- edger$logFC
        base::names(edger.fc) <- base::row.names(edger)
        exp.fc <- edger.fc

    }

    else if (type == "DESeq2") {
        deseq2 <- utils::read.csv(fc, header = TRUE, row.names = 1)
        deseq2.fc <- deseq2$log2FoldChange
        base::names(deseq2.fc) <- base::row.names(deseq2)
        exp.fc <- deseq2.fc
    }

    else
    {
        stop("Please pick the program that was used to find differentially expressed genes")
    }
    gsets <- gage::kegg.gsets(org)
    fc.kegg.p <- gage::gage(exp.fc, gsets = gsets, ref = NULL, samp = NULL)

    base::dir.create(file.path(out_dir), showWarnings = FALSE)
    greater <- base::file.path(out_dir, "greater.csv")
    lower <- base::file.path(out_dir, "less.csv")
    statf <- base::file.path(out_dir, "stat.csv")
    write.csv(fc.kegg.p$greater, greater)
    write.csv(fc.kegg.p$lower, lower)
    write.csv(fc.kegg.p$stats, statf)
}

#'@title Creates a csv with summary information
#'
#'@description Creates a csv file with information on number of featueres that,
#' were significantly
#'
#' @importFrom S4Vectors metadata
globalVariables(".")
#'
#'

NULL

#' Produces CA plot

#' @param object A DESeq2 object
#' @param alpha alpha
#' @param pair1 condition 1
#' @param pair2 condition 2
#' @param feature_name name of the feature that is being compared, for example, CDS
#' @param outdir A folder to write all the files
#'
#'
#' @return creates a csv file with summary information from deseq2 object with number of genes that up, down, and not significantly different between two conditions.
#'
#' @export
#'
#'

DESeq2_summary <- function(object, alpha, pair1, pair2, feature_name, outdir){

    if (missing(alpha)) {
        alpha <- if (is.null(S4Vectors::metadata(object)$alpha)) {
            0.1
        }
        else {
            S4Vectors::metadata(object)$alpha
        }
    }

    base::ifelse(!base::dir.exists(outdir),
                 base::dir.create(outdir),
                 print("already exist"))
    notallzero <- sum(object$baseMean > 0)
    up <- sum(object$padj < alpha & object$log2FoldChange > 0,
              na.rm = TRUE)
    down <- sum(object$padj < alpha & object$log2FoldChange <
                    0, na.rm = TRUE)
    not_sig = notallzero - up - down
    summ_table <- data.frame(Down = down,  NotSig = not_sig, Up = up)
    summ_file <- file.path(outdir, paste(pair1, pair2, feature_name,
                                         "summary.csv", sep = "__"))
    print(summ_file)
    write.csv(summ_table, summ_file)
    return(summ_table)
}


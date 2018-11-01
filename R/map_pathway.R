#' @importFrom utils read.csv


NULL

#' Gets pathway maps and paints colors based on expression level of genes

#' @param sig_table A table file from DESeq2 or edgeR
#' @param type Is it DESeq2 or edgeR?
#' @param org KEGG organism code
#' @param out output folder
#'
#' @return A folder containing pathway with fold change value mapped
#'
#' @export
#'
#'

map_pathway <- function(sig_table, type, org_code, out){
    if (type == "edgeR") {
        genes <- utils::read.csv(sig_table, row.names = 1) # read the sig table
        greg <- base::subset.data.frame(genes, select = c("logFC")) # only keep logFC
        path_ids <- KEGGREST::keggLink("pathway", org_code)
        path_list <- list()
        for (gene_id in row.names(greg)) {
            gene_id = base::paste(org_code, gene_id, sep = ":")
            path_list[gene_id] = path_ids[gene_id]
        }
        path_list <- path_list[!is.na(path_list)] # remove NA

        for (path in unique(path_list)) {
            print(path)
            pathway <- base::strsplit(path, split = ":", fixed = TRUE)[[1]][2]
            Sys.sleep(20)
            pathview::pathview(gene.data = greg, pathway.id = pathway, species = org_code, gene.idtype = "KEGG")

        }
        filestocopy <- base::list.files(".", "*.png|*.xml")
        ifelse(!dir.exists(file.path(out)), dir.create(file.path(out)), FALSE)
        base::file.copy(from = filestocopy, to = out,
                        overwrite = TRUE, recursive = FALSE,
                        copy.mode = TRUE)
        base::file.remove(filestocopy)

    }
    else if (type == "DESeq2") {
        genes <- utils::read.csv(sig_table, row.names = 1)
        greg <- base::subset.data.frame(genes, select = c("log2FoldChange"))
        path_ids <- KEGGREST::keggLink("pathway", org_code)
        path_list <- list()
        for (gene_id in row.names(greg)) {
            gene_id = base::paste(org_code, gene_id, sep = ":")
            path_list[gene_id] = path_ids[gene_id]
        }
        path_list <- path_list[!is.na(path_list)] # remove NA from the list

        for (path in unique(path_list)) {
            pathway <- base::strsplit(path, split = ":", fixed = TRUE)[[1]][2]
            Sys.sleep(20)
            pathview::pathview(gene.data = greg, pathway.id = pathway, species = org_code, gene.idtype = "KEGG")

        }
        filestocopy <- base::list.files(".", "*.png|*.xml")
        ifelse(!dir.exists(file.path(out)), dir.create(file.path(out)), FALSE)
        base::file.copy(from = filestocopy, to = out,
                        overwrite = TRUE, recursive = FALSE,
                        copy.mode = TRUE)
        base::file.remove(filestocopy)
    }
    else
        {
        stop("Please pick the program that was used to find differentially expressed genes")
    }

    return()
}

context("test_map_pathway.R")
#
# create deseq2 object
#

#
# run edgeR results
map_pathway("../test_data/edgeR_gene_count__liver__spleen__gene__et.csv", "edgeR", "bar", "outdir")
#

#
#run DESeq2 results
#
map_pathway("../test_data/deseq2_liver__spleen__gene__et.csv", "DESeq2", "bar", "outdir")

#
# check if pdf file exist test
#
expect_true(file.exists(file.path("outdir", "bar00250.pathview.png")))

#
# check if png file exist test
#
expect_true(file.exists(file.path("outdir", "bar00010.pathview.png")))

#
unlink("outdir", recursive = TRUE)

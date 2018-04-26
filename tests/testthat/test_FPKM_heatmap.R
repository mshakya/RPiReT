context("test_FPKM_heatmap.R")
#
# create deseq2 object
#

#FPM
FPKM_heatmap("../test_data/chr22_ERCC92_CDS_count_FPKM.csv", "../test_data/test_euk.txt", "outdir")

#
# check if pdf file exist test
#
expect_true(file.exists(file.path("outdir", "chr22_ERCC92_CDS_count_FPKM_heatmap.pdf")))

#
# check if png file exist test
#
expect_true(file.exists(file.path("outdir", "chr22_ERCC92_CDS_count_FPKM_heatmap.png")))

#
unlink("outdir", recursive = TRUE)

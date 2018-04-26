context("test_FPM_heatmap.R")
#
# create deseq2 object
#

#FPM
FPM_heatmap("../test_data/chr22_ERCC92_CDS_count_FPM.csv", "../test_data/test_euk.txt", "outdir")

#
# check if pdf file exist test
#
expect_true(file.exists(file.path("outdir", "chr22_ERCC92_CDS_count_FPM_heatmap.pdf")))

#
# check if png file exist test
#
expect_true(file.exists(file.path("outdir", "chr22_ERCC92_CDS_count_FPM_heatmap.png")))

#
unlink("outdir", recursive = TRUE)

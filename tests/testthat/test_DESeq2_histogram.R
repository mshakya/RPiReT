context("test_DESeq2_histogramp.R")
#
# create deseq2 object
#

#FPM
DESeq2_histogram("../test_data/chr22_ERCC92_CDS_count_FPM.csv", "../test_data/test_euk.txt",
                 "outdir", "FPM", "CDS")

#FPKM
DESeq2_histogram("../test_data/chr22_ERCC92_CDS_count_FPKM.csv", "../test_data/test_euk.txt",
                 "outdir", "FPKM", "CDS")


#
# check if pdf file exist test
#
expect_true(file.exists(file.path("outdir", "chr22_ERCC92_CDS_count_FPM_histogram.pdf")))

#
# check if png file exist test
#
expect_true(file.exists(file.path("outdir", "chr22_ERCC92_CDS_count_FPM_histogram.png")))


#
# check if pdf file exist test
#
expect_true(file.exists(file.path("outdir", "chr22_ERCC92_CDS_count_FPKM_histogram.pdf")))

#
# check if png file exist test
#
expect_true(file.exists(file.path("outdir", "chr22_ERCC92_CDS_count_FPKM_histogram.png")))
#
unlink("outdir", recursive = TRUE)

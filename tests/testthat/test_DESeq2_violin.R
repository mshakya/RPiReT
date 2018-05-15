context("test_DESeq2_violin.R")
#
# create deseq2 object
#

#FPM
DESeq2_violin("../test_data/chr22_ERCC92_CDS_count_FPM.csv", "../test_data/test_euk.txt",
                 "outdir", "FPM", "CDS")

#FPKM
DESeq2_violin("../test_data/chr22_ERCC92_CDS_count_FPKM.csv", "../test_data/test_euk.txt",
                 "outdir", "FPKM", "CDS")


#
# check if pdf file exist test
#
expect_true(file.exists(file.path("outdir", "chr22_ERCC92_CDS_count_FPM_violin.pdf")))

#
# check if png file exist test
#
expect_true(file.exists(file.path("outdir", "chr22_ERCC92_CDS_count_FPM_violin.png")))


#
# check if pdf file exist test
#
expect_true(file.exists(file.path("outdir", "chr22_ERCC92_CDS_count_FPKM_violin.pdf")))

#
# check if png file exist test
#
expect_true(file.exists(file.path("outdir", "chr22_ERCC92_CDS_count_FPKM_violin.png")))
#
unlink("outdir", recursive = TRUE)

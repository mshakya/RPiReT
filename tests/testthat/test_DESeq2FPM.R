context("test_DESeq2FPM.R")
#
# create deseq2 object
#
deseq_object <- feat2deseq2(feat_count = "../test_data/chr22_ERCC92_gene_count.tsv",
                            exp_desn = "../test_data/test_euk.txt")

#FPM
DESeq2FPM(DESeq2_object = deseq_object,
           feat_count = "../test_data/chr22_ERCC92_gene_count.tsv",
           outdir = "outdir")

# read back the FPM table
fpm_table <- read.csv("outdir/chr22_ERCC92_gene_count_FPM.csv")

#
# dimension test
#
expect_equal(dim(fpm_table)[1], 717)

#
# string match
#
expect_match(colnames(fpm_table)[[2]], "samp1")

#
unlink("outdir", recursive = TRUE)

context("test_DESeq2FPKM.R")
#
# create deseq2 object
#
deseq_object <- feat2deseq2(feat_count = "../test_data/chr22_ERCC92_gene_count.tsv",
                            exp_desn = "../test_data/test_euk.txt")

print(deseq_object)
#FPKM
DESeq2FPKM(DESeq2_object = deseq_object,
           feat_count = "../test_data/chr22_ERCC92_gene_count.tsv",
           outdir = "outdir")

# read back the FPKM table
fpkm_table <- read.csv("outdir/chr22_ERCC92_gene_count_FPKM.csv")

#
# dimension test
#
expect_equal(dim(fpkm_table)[1], 717)

#
# string match
#
expect_match(colnames(fpkm_table)[[2]], "samp1")

#
unlink("outdir", recursive = TRUE)

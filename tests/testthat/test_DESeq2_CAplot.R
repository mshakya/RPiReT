context("test_DESeq2_CAplot.R")

#
# create deseq2 object
#
deseq_object <- feat2deseq2(feat_count = "../test_data/chr22_ERCC92_gene_count.tsv",
                            exp_desn = "../test_data/test_euk.txt")



DESeq2_CAplot(feat_count = "../test_data/chr22_ERCC92_gene_count.tsv",
              DESeq2_object = deseq_object, outdir = "outdir",
              feature_name = "CDS")


#
# check if pdf file exist test
#
expect_true(file.exists(file.path("outdir", "chr22_ERCC92_gene_count_PCA.pdf")))

#
# check if png file exist test
#
expect_true(file.exists(file.path("outdir", "chr22_ERCC92_gene_count_PCA.png")))


unlink("outdir", recursive = TRUE)

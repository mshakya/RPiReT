context("test_DESeq2_summary.R")

#
# create deseq2 object
#
deseq_object <- feat2deseq2(feat_count = "../test_data/chr22_ERCC92_gene_count.tsv",
                            exp_desn = "../test_data/test_euk.txt")

dds <- DESeq2::DESeq(deseq_object)
pair1 <- "HBR"
pair2 <- "UBR"

deseq_diff <- DESeq2::results(dds, contrast = c("Group", pair1, pair2))

X <- DESeq2_summary(object = deseq_diff, alpha = 0.1,
                    pair1 = pair1, pair2 = pair2, feature_name = "gene", outdir = "outdir")

print(X)
#
# check if pdf file exist test
#
expect_true(file.exists(file.path("outdir", "HBR__UBR__gene__summary.csv")))

#
# test if number of rows in dataframe is One
#
expect_equal(1, nrow(X))


unlink("outdir", recursive = TRUE)

context("test_feat2deseq2.R")
#
# create deseq2 object
#
deseq_object <- feat2deseq2(feat_count = "../test_data/chr22_ERCC92_gene_count.tsv",
            exp_desn = "../test_data/test_euk.txt")


deseq_object_euk <- feat2deseq2(feat_count = "../test_data/eukarya_test_CDS_count.tsv",
                            exp_desn = "../test_data/test_prok.txt")

# dimension test
expect_equal(dim(deseq_object)[1], 717)


# dimension test
expect_equal(dim(deseq_object_euk)[1], 90)


# create deseq2 object
deseq_object <- feat2deseq2(feat_count = "../test_data/chr22_ERCC92_gene_count.tsv",
            exp_desn = "../test_data/test_euk.txt")

# dimension test
expect_equal(dim(deseq_object)[1], 717)

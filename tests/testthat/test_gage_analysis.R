context("test_gage_analysis.R")
#
# create deseq2 object
#

#
# run edgeR results
gage_analysis(fc = "../test_data/edgeR_gene_count__liver__spleen__gene__et.csv",
              type = "edgeR",
              org = "bar", out_dir = "out_test")
#

#
#run DESeq2 results
#
gage_analysis("../test_data/deseq2_liver__spleen__gene__et.csv", type = "DESeq2",
             org = "bar", out_dir = "out_test")

#
# check if pdf file exist test
#
expect_true(file.exists(file.path("out_test", "stat.csv")))

#
# check if png file exist test
#
expect_true(file.exists(file.path("out_test", "stat.csv")))

#
unlink("out_test", recursive = TRUE)

library(vcfR)
#install.packages("vcfR")

results <- "results/aldy"
vcf_files <- list.files(results, recursive = TRUE, pattern = "vcf$",
full.names = TRUE)


# extract major and minor alleles from vcf files
lapply(vcf_files, function(v) {
    gene <- stringr::str_extract(v, "(?<=_)[^_]+(?=\\.vcf$)")
    sample <- stringr::str_extract(v, "(?<=/)[^/_]+(?=_)")
    x <- vcfR::read.vcfR(v)
    allele <- colnames(x@gt)[2] |> stringr::str_extract("[^:]+$")
    tibble::tibble(Sample = sample, Gene = gene, Allele = allele)
}) |>
dplyr::bind_rows()


RNA-seq Differential Expression Analysis for ePRVs in Tomato Fruit Development

This README file documents the analysis pipeline and scripts used to perform differential gene expression (DGE) analysis of endogenous pararetroviruses (ePRVs) in tomato (Solanum lycopersicum) across multiple fruit ripening stages. The workflow includes read counting, normalization, statistical analysis with DESeq2, and visualization through heatmaps and UpSet plots.

----------------------------------------
📂 Directory and Input File Structure
----------------------------------------

Ensure your directory includes:

- Aligned BAM files (e.g., SRR5724168Aligned.sortedByCoord.out.bam)
- Gene annotation file (GTF format):
  - NBL4.1_slyco_complete_eprv.gtf
- ePRV gene IDs list (CSV):
  - gene_ids_eprv_solyc.txt (or similar)
- R Script (provided analysis script)

----------------------------------------
📦 Packages Required
----------------------------------------

The following R/Bioconductor packages are required and automatically installed by the script:

- DESeq2
- Rsubread
- edgeR
- apeglm
- pheatmap
- UpSetR
- tidyverse
- ggplot2

----------------------------------------
🧬 Analysis Workflow Overview
----------------------------------------

1. Read Counting (featureCounts)
----------------------------------------

- Alignments (.bam) are quantified against the provided GTF annotation.
- Command used:

featureCounts(files = samples$fileName,
              annot.ext = gtfFile,
              isPairedEnd = FALSE,
              strandSpecific = 0,
              nthreads = 28,
              isGTFAnnotationFile = TRUE,
              GTF.attrType="gene_id",
              GTF.featureType="gene",
              useMetaFeatures=TRUE,
              allowMultiOverlap=TRUE,
              countMultiMappingReads=TRUE)

- Output saved as: featureCounts_counts_meta.RData

2. Differential Expression Analysis (DESeq2)
----------------------------------------

- Raw counts from featureCounts are normalized and analyzed using DESeq2.
- Stages compared against the "Anthesis" control stage.
- Thresholds for significant DEGs:
  - Adjusted p-value < 0.05
  - Log2 fold-change > |1|
- DESeq2 object saved as: dds_object_meta.RData

Significant genes per stage saved as CSV:
DEG_[Stage].csv

3. Generating Log2 Fold-Change Matrix
----------------------------------------

- Generates a comprehensive log2FC matrix for significant ePRV genes across ripening stages.
- Matrix filtered for significant ePRVs across any stage.

Output:
- DEG_logFC_matrix_clean.txt

4. Heatmaps Visualization
----------------------------------------

- Heatmaps of significant ePRVs, clustered by expression pattern.

Outputs (PDF format):
- DEG_ePRV_Heatmap_new.pdf
- DEG_ePRV_Heatmap_new2_eprv_solyc.pdf

5. UpSet Plot Analysis
----------------------------------------

- Visualization of gene overlap among ripening stages.

Outputs (PDF format):
- Upregulated genes:
  - Upregulated_ePRV_UpSetPlot_Ordered1.pdf
  - Upregulated_ePRV_UpSetPlot_Ordered2.pdf
  - Upregulated_ePRV_UpSetPlot_Ordered2_eprv_solyc.pdf

- Downregulated genes:
  - Downregulated_ePRV_UpSetPlot_Ordered1.pdf
  - Downregulated_ePRV_UpSetPlot_Ordered2.pdf
  - Downregulated_ePRV_UpSetPlot_Ordered2_eprv_solyc.pdf

6. Extracting Final DEG Matrices
----------------------------------------

- Generates and filters the complete log2FC matrix to retain only statistically significant genes across all stages.

Output file:
- DEG_logFC_matrix_fulldeg_significant_only.txt

----------------------------------------
📌 Quick Start Guide
----------------------------------------

1. Ensure all BAM files and annotation files are in the correct path as specified in the script (fileName and gtfFile).

2. Run the R script:

Rscript your_script_name.R

3. Check outputs (CSV, TXT, PDF files) generated in your working directory.

----------------------------------------
🗃 Interpreting the Results
----------------------------------------

- CSV files list significant genes per stage with fold changes and adjusted p-values.
- Heatmaps visualize expression patterns across stages for rapid identification of biologically relevant ePRVs.
- UpSet plots illustrate overlaps and unique genes significantly up- or downregulated at different ripening stages.

----------------------------------------
🔍 Support
----------------------------------------

For questions or further support regarding this pipeline, contact the repository maintainer or the script developer.

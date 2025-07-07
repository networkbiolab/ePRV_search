
WGCNA + GO Enrichment Analysis Pipeline for Tomato ePRV-Associated Genes

This README documents the usage of two R scripts to perform weighted gene co-expression network analysis (WGCNA) and gene ontology (GO) enrichment on tomato RNA-seq data, with a focus on endogenous pararetrovirus (ePRV)-associated genes.

----------------------------------------
📄 Scripts Included
----------------------------------------

1️⃣ WGCNA_GO_pipeline.R
    - Defines the `run_wgcna_pipeline()` function, which runs the full WGCNA and downstream analyses, including:
      • Sample clustering and outlier detection
      • Network construction and module detection
      • Module-trait correlation heatmaps
      • Module membership (kME) analysis
      • Cytoscape export of edges and node attributes
      • GO enrichment of modules and of Solyc genes connected to ePRVs

2️⃣ Run_WGCNA.R
    - Executes the pipeline by:
      • Loading the DESeq2 object (`dds_object_new.RData`)
      • Defining trait labels for each sample
      • Calling `run_wgcna_pipeline()` with required input files

----------------------------------------
📂 Required Input Files
----------------------------------------

- `dds_object_new.RData` : DESeq2 object with normalized expression counts
- `gene_ids_eprv_only.txt` : List of ePRV gene IDs (one per line)
- `sol_gene2go.txt` : Gene-to-GO mapping file in two-column tab-separated format

----------------------------------------
⚙️ How to Run
----------------------------------------

1️⃣ Prepare your working directory with the required input files.

2️⃣ Start R in the directory and execute:

```R
source("Run_WGCNA.R")
```

This will source `WGCNA_GO_pipeline.R`, load the DESeq2 object, and execute the full pipeline.

----------------------------------------
🧬 Outputs Generated
----------------------------------------

- PDF plots:
  • Sample clustering dendrogram
  • Soft threshold selection
  • Module-trait heatmap
  • Module eigengene clustering
  • Dendrogram with merged modules
  • ePRV kME heatmap
  • GO enrichment barplots for each module and for Solyc-ePRV connections

- Tables:
  • Module-trait correlations
  • Module membership (kME) for ePRVs
  • kME for all genes in modules containing ePRVs
  • Cytoscape edge list and node attributes
  • GO enrichment tables per module and for ePRV-connected Solyc genes
  • Genes grouped by module

----------------------------------------
📖 Notes
----------------------------------------

- You may adjust parameters like `minEdgeWeight` or `mergeCutHeight` inside `Run_WGCNA.R` or when calling the function.
- Trait labels must match your experimental design and sample order.
- Output files are prefixed with `TomatoWGCNA`.

----------------------------------------
🔍 Support
----------------------------------------

For questions or issues with the pipeline, please contact me or refer to the R package documentation for WGCNA and topGO.

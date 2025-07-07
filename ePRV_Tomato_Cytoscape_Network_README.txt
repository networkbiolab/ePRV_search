
README - Supplemental Data S8  
WGCNA ePRV–Tomato Gene Correlation Network in Ripening Stages

This file documents the contents of **Supplemental Data S8**, which accompanies the manuscript.  
It contains the weighted gene co-expression network analysis (WGCNA) results showing representative connections between *Solanum lycopersicum* (tomato) genes and endogenous pararetrovirus (ePRV) loci during fruit ripening stages.

===================================================
📄 File: eprv_tomato_net_gen_annot.cys
===================================================

This Cytoscape `.cys` session file contains the full gene co-expression network derived from WGCNA, visualized as a graph where:
- Nodes represent ePRV sequences and tomato genes.
- Edges represent weighted correlations between ePRV and tomato gene expression profiles.

The table below (Supplemental Data S8) lists a subset of representative edges extracted from the network, with additional gene annotation information for the tomato genes.

===================================================
🧬 Table Columns Description
===================================================

| Column                | Description |
|-----------------------|-------------|
| **ePRV**              | Identifier of the endogenous pararetrovirus locus (e.g., `Slyco_ePRV10992.1`). |
| **Solyc_ID**          | Solyc gene identifier of the connected tomato gene. |
| **weight**            | Weighted correlation value (WGCNA edge weight) between the ePRV and tomato gene. |
| **interpro**          | InterPro protein domain accession(s) associated with the tomato gene, if available. |
| **pfam**              | Pfam protein family accession(s) associated with the tomato gene, if available. |
| **GO annotations**    | Gene Ontology terms (biological process, molecular function, or cellular component) annotated for the tomato gene. |
| **Notes**             | Functional description or predicted protein annotation for the tomato gene (e.g., AHRD annotation). |

===================================================
📊 Example Entry

| ePRV               | Solyc_ID             | weight       | interpro    | pfam    | GO annotations                 | Notes |
|--------------------|----------------------|--------------|-------------|---------|-------------------------------|-------|
| Slyco_ePRV10992.1  | Solyc01g007940.4     | 0.403679353  | IPR004839   | PF00155 | GO:0030170,GO:0009058         | Alanine aminotransferase 2 |

===================================================
📂 Notes

- Weighted correlations ≥ 0.4 are reported in this table to illustrate moderately strong associations.
- Gene functional annotations were derived from AHRD (Automatic Annotation of Plant Genes), InterPro, Pfam, and Gene Ontology databases.

===================================================
🔍 Usage

- Open `eprv_tomato_net_gen_annot.cys` in Cytoscape (v3.7 or higher) to explore the full network graph interactively.
- Use the supplemental table for reference when discussing specific ePRV–tomato gene associations of interest.

===================================================
✍️ Contact

For any questions regarding this dataset or annotations, please contact the corresponding author of the manuscript.

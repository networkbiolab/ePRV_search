EPRV-PRV HMM Matrix for Endogenous Pararetrovirus (ePRV) search.

This repository contains a Hidden Markov Model (HMM) profile specifically designed to detect endogenous pararetrovirus (ePRV) sequences integrated into plant genomes.

Included Files:
build_eviral.hmm (Primary HMM profile)

build_eviral.hmm.h3f (HMM indexed binary file)

build_eviral.hmm.h3i (HMM indexed binary file)

build_eviral.hmm.h3m (HMM indexed binary file)

build_eviral.hmm.h3p (HMM indexed binary file)

All listed files are packaged within the archive:

EPRV_PRV_HMM.zip

Prerequisites:
Ensure that the HMMER toolkit (nhmmer) is installed on your system.
Refer to HMMER installation guide for instructions.

Usage:
Run the following command to search for ePRV sequences within your plant genome:

nhmmer --tblout=tabla_nhmm_plant_genome_evirussearch.txt --cpu=<num_cores> ../build_eviral.hmm plant_genome.fna

Replace <num_cores> with the number of CPU cores to allocate.

Replace plant_genome.fna with the FASTA file of your plant genome.

Reviewing and Transforming Output:
After running nhmmer, carefully review and filter the tabular output (tabla_nhmm_plant_genome_evirussearch.txt) to retain high-confidence ePRV hits. Depending on downstream analyses or visualization needs, this filtered data can be transformed into GTF format for genome annotation or visualization purposes.

Store the final GTF file alongside the original HMM files for convenient data management:

Example output filename:

plant_genome_eprv_annotations.gtf


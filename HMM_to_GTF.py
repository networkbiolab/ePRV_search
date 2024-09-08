#!/usr/bin/env python3
import argparse

def main():
    # Setup command-line argument parsing
    parser = argparse.ArgumentParser(description="Convert HMM output to GTF format with customizable gene ID prefixes.")
    parser.add_argument("-i", "--input_file", required=True, help="Path to the input HMM table file.")
    parser.add_argument("-o", "--output_file", required=True, help="Path to the output GTF file.")
    parser.add_argument("-p", "--prefix", default="Slyco_ePRV", help="Prefix for gene IDs (default: Slyco_ePRV)")

    args = parser.parse_args()

    def sort_key(line):
        columns = line.split()
        chrom = columns[0]
        start, end = int(columns[6]), int(columns[7])
        if start > end:
            start, end = end, start
        chrom_number = int(chrom.split("ch")[-1])  # Assuming format like 'SL4.0ch01'
        return chrom_number, start

    # Read the input file and sort the lines
    with open(args.input_file, 'r') as infile:
        lines = infile.readlines()
        sorted_lines = sorted(lines, key=sort_key)

    # Process the sorted lines and write to the output file
    with open(args.output_file, 'w') as outfile:
        attribute_number = 0  # Counter for the attribute number

        for line in sorted_lines:
            columns = line.strip().split()
            if len(columns) != 16:
                continue

            chrom = columns[0]
            start, end = int(columns[6]), int(columns[7])
            strand = columns[11].strip()

            if start > end:
                start, end = end, start

            attribute_number += 1

            gene_id = f"{args.prefix}{attribute_number}.1"
            gtf_gene_line = f"{chrom}\teVirusDB\tgene\t{start}\t{end}\t.\t{strand}\t.\tgene_id \"{gene_id}\";"
            outfile.write(gtf_gene_line + '\n')

            exon_id = f"{gene_id}.2"
            gtf_exon_line = f"{chrom}\teVirusDB\texon\t{start}\t{end}\t.\t{strand}\t.\tgene_id \"{gene_id}\"; transcript_id \"{exon_id}\";"
            outfile.write(gtf_exon_line + '\n')

    print(f"Processed and sorted the input file and saved the result to {args.output_file}.")

if __name__ == "__main__":
    main()

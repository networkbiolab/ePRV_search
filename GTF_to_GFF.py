#!/usr/bin/env python3

import sys

def process_gtf_to_gff(input_file, output_file):
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        # Writing the GFF3 header
        outfile.write("##gff-version 3\n")
        
        for line in infile:
            if line.startswith("#"):
                continue  # Skip header lines in GTF
            
            parts = line.strip().split('\t')
            if len(parts) < 9:
                continue  # Not a valid GTF line
            
            chrom, source, feature_type, start, end, score, strand, phase, attributes = parts
            attributes_dict = {attr.split()[0]: attr.split()[1].strip('"') for attr in attributes.split(';') if attr}
            
            # Construct the GFF3 output line
            ID = attributes_dict.get('ID', '')
            Name = attributes_dict.get('Name', '')
            Parent = attributes_dict.get('Parent', '').replace("gene:", "")
            
            # Formatting attributes for GFF3
            gff_attributes = f"ID={ID};Name={Name}"
            if 'Parent' in attributes_dict:
                gff_attributes += f";Parent={Parent}"
            
            outfile.write(f"{chrom}\t{source}\t{feature_type}\t{start}\t{end}\t{score}\t{strand}\t{phase}\t{gff_attributes}\n")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python script_name.py input_file.gtf output_file.gff")
        sys.exit(1)
    
    input_file_path = sys.argv[1]
    output_file_path = sys.argv[2]
    process_gtf_to_gff(input_file_path, output_file_path)

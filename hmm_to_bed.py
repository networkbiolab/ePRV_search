#!/usr/bin/env python3
import argparse

# Setup command-line argument parsing
def main():
    parser = argparse.ArgumentParser(description="Convert HMM output to BED format.")
    parser.add_argument("input_file", help="Path to the input HMM table file.")
    parser.add_argument("output_file", help="Path to the output BED file.")
    
    args = parser.parse_args()
    
    # Process the input file and write the result to the output file
    with open(args.input_file, 'r') as infile, open(args.output_file, 'w') as outfile:
        for line in infile:
            # Skip comment lines (those that start with '#')
            if line.startswith("#"):
                continue
            
            columns = line.split()
            # Get values from columns 0, 6, 7, and 11
            col0, col6, col7, col11 = columns[0], int(columns[6]), int(columns[7]), columns[11]
            # If col6 is bigger than col7, swap their values
            if col6 > col7:
                col6, col7 = col7, col6
            # Write the transformed line to the output file
            outfile.write(f"{col0}\t{col6}\t{col7}\t{col11}\n")
    
    print(f"Processed the input file and saved the result to {args.output_file}.")

if __name__ == "__main__":
    main()

#!/bin/bash


# Download all MAGs of the uSGB 19436
./download_files.sh sequence_url_opendata_19436.txt input_bins/

# Find executables
[[ -z $(which phylophlan_get_reference) ]] && ppa_get_ref="phylophlan_get_reference.py" || ppa_get_ref=$(which phylophlan_get_reference)
[[ -z $(which phylophlan) ]] && ppa="phylophlan.py" || ppa=$(which phylophlan)

# Download up to 1 reference genomes for each species of the Epsilonproteobacteria class
$ppa_get_ref -g g__Epsilonproteobacteria \
    -n -1 \
    -o input_bins \
    --verbose 2>&1 | tee logs/phylophlan_get_reference__epsilonproteobacteria.log

# Download up to 1 reference genomes for each species of the Spirocaethes phylum to be used as an outgroup
$ppa_get_ref -g p__Spirochaetes \
    -n -1 \
    -o input_bins \
    --verbose 2>&1 | tee logs/phylophlan_get_reference__spirochaetes.log

# Retrieve 10 Ethiopian MAGs assigned to the uSGB 19436
for i in $(grep uSGB_19436 ../03_metagenomic/output_metagenomic.tsv | cut -f1); do
    cp -a ../03_metagenomic/input_metagenomic/$i.fna input_bins/;
done;

# Build the phylogeny
$ppa -i input_bins \
    -d phylophlan \
    --diversity high \
    --accurate \
    -f proteobacteria_config.cfg \
    -o output_proteobacteria \
    --force_nucleotides \
    --nproc 4 \
    -t a \
    --verbose 2>&1 | tee logs/phylophlan__input_bins.log 

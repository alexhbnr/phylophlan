#!/bin/bash


# This script assumes that PhyloPhlAn is installed and the commands are available in the command line


if [[ $# -ne 1 ]]; then
    outd='.'
else
    outd=$1
fi;

if [[ ! -d $outd ]]; then
    echo "ERROR! Folder not found: $1";
    exit 2;
fi;

# supermatrix_nt.cfg
phylophlan_write_config_file -o $outd/supermatrix_nt.cfg \
    -d n \
    --db_dna makeblastdb \
    --map_dna blastn \
    --msa mafft \
    --trim trimal \
    --tree1 fasttree \
    --tree2 raxml \
    --overwrite \
    --verbose

# supertree_nt.cfg
phylophlan_write_config_file -o $outd/supertree_nt.cfg \
    -d n \
    --db_dna makeblastdb \
    --map_dna blastn \
    --msa mafft \
    --trim trimal \
    --gene_tree1 fasttree \
    --gene_tree2 raxml \
    --tree1 astral \
    --overwrite \
    --verbose

# supermatrix_aa.cfg
phylophlan_write_config_file -o $outd/supermatrix_aa.cfg \
    -d a \
    --db_aa diamond \
    --map_dna diamond \
    --map_aa diamond \
    --msa mafft \
    --trim trimal \
    --tree1 fasttree \
    --tree2 raxml \
    --overwrite \
    --verbose

# supertree_aa.cfg
phylophlan_write_config_file -o $outd/supertree_aa.cfg \
    -d a \
    --db_aa diamond \
    --map_dna diamond \
    --map_aa diamond \
    --msa mafft \
    --trim trimal \
    --gene_tree1 fasttree \
    --gene_tree2 raxml \
    --tree1 astral \
    --overwrite \
    --verbose

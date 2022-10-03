#!/bin/bash

# THe following command is a one-liner to get all the scores openstructure can calculate
 docker run --rm -v  $(pwd):/home registry.scicore.unibas.ch/schwede/openstructure:latest compare-structures       --model ./crystal/H/1A6U.pdb       --reference ./IgFold/H/1A6U.pdb       --output output.json       --molck       --remove oxt hyd unk nonstd       --clean-element-column       --map-nonstandard-residues       --structural-checks       --bond-tolerance 15.0       --angle-tolerance 15.0       --residue-number-alignment       --consistency-checks       --lddt       --inclusion-radius 15.0 --save-per-residue-scores



# docker run --rm -v  $(pwd):/home registry.scicore.unibas.ch/schwede/openstructure:latest try.py >> output_new.txt
#!/bin/bash

#SBATCH --output=cleanprogress.txt
#SBATCH --time 30
#SBATCH -p production   

/share/siegellab/software/Rosetta_rf/main/source/bin/relax.linuxgccrelease -database /share/siegellab/software/Rosetta_rf/main/database -constrain_relax_to_start_coords -relax:coord_constrain_sidechains -relax:ramp_constraints false -ignore_unrecognized_res true -s 1BYH.clean.pdb

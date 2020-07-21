#!/bin/bash
#SBATCH --output=logs1
#SBATCH --mem-per-cpu=1G
#SBATCH --nodes=1
#SBATCH --time=120
#SBATCH --array=1-5000
#SBATCH --partition=production

/share/siegellab/steph/software/Rosetta_old/Rosetta/main/source/bin/rosetta_scripts.default.linuxgccrelease -database /share/siegellab/steph/software/Rosetta_old/Rosetta/main/database @flags -parser:protocol Design.xml -s 1AUR_402.pdb -nstruct 1 -suffix _0$SLURM_ARRAY_TASK_ID

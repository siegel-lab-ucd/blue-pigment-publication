# blue-pigment-publication
Supplementary Files for Blue Pigment Publication

Files for enzyme-ligand docking and design using Rosetta Enzyme Design. Additional details about these files can be found in doi:10.1371/journal.pone.0019230
  
    clean.sh
      converts PDB files taken directly from the Protein Data Bank into a version that Rosetta scripts recognize

    1AUR_402.pdb
      is a composite PDB file that contains the 1AUR pdb produced by clean.sh, with a PDB of the ligand (in this case peak 6), positioned roughly in the active site. This is       one of the input files for the docking and design script

    Design.xml
      designates which Rosetta movers to apply to your docking simulation. The complete list of options for movers can be found in the Rosetta documentation.

    402.params
      provides the internal coordinates of the ligand to be docked (peak 6 in this case). This file also indicates to Rosetta the identity of the conformer library

    402.conf.pdb
      is a library of potential conformers that Rosetta samples as it attempts to find a docking pose.

    flags
      Rosetta has a an extensive list of flags that can be applied that affect how it samples docking poses and how they are scored. This file contains the flags used for           this study. For a complete list of flags, please refer to Rosetta's documentation. 

    cst_1aur_peak4.enzdes.cst
      is a file that contains geometric constraints to be upweighted when Rosetta scores docking poses. The intention of these constraints is to capture the well-known and         specific geometry that occurs at the interface of a ligand and enzyme in a transition state. It is crucial this geometry is met if one is trying to accurately    
        model enzyme-ligand interactions.
    
    1AUR_402_0001.pdb
      example output file from Rosetta EnzDes Docking or Design protocols
      
Files for Molecular dynamics simulations reveal the conformational landscape of monoacylated anthocyanins peak 3 and peak B, using GROMACS 

    gromacs_make_topologies.sh
    gromacs_processed_topology.top
    gromacs_starting_conf.gro
    qe_dynamics.in
    qe_optimise.in
    qe_spectrum.in

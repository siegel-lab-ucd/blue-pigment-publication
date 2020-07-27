
module load gromacs
module load plumed
module load openmpi/1.8.3/intel/14.0 


# ten replicas
nrep=10
# "effective" temperature range
tmin=300
tmax=1100

# build geometric progression
list=$(
awk -v n=$nrep \
    -v tmin=$tmin \
    -v tmax=$tmax \
  'BEGIN{for(i=0;i<n;i++){
    t=tmin*exp(i*log(tmax/tmin)/(n-1));
    printf(t); if(i<n-1)printf(",");
  }
}'
)

# clean directory
rm -fr \#*
rm -fr topol*

for((i=0;i<nrep;i++))
do

  temp=$(echo $list | awk 'BEGIN{FS=",";}{print $'$((i+1))';}')
cat > grompp$i.mdp << ***
; RUN CONTROL PARAMETERS
integrator             = md
dt                     = 0.001
nsteps                 = 29000000 
comm-mode              = Linear
comm_grps              = MOL Water

; OUTPUT CONTROL OPTIONS
nstenergy              = 10000                    ; frequency to write energies to energy file
nstxout                = 10000                    ; save coordinates every ps
nstvout                = 10000                    ; save velocities every ps
nstlog                 = 10000                    ; update log file every ps
nstxtcout              = 10000
energygrps             = MOL Water

; Ewald Setup and NEIGHBORSEARCHING PARAMETERS
coulombtype            = PME
pbc                    = xyz

rlist                  = 1.1 
rcoulomb               = 1.1                      ; long range electrostatic cut-off

vdw-type                 = switch
rvdw-switch              = 1.0
rvdw                   = 1.1                      ; long range Van der Waals cut-off

; Temperature coupling
tcoupl                   = v-rescale
tc_grps                  = System
tau_t                    = 0.1
ref_t                    = 300

gen_vel                  = yes
;gen_temp                 = 300
;gen_seed                 = 13122149
constraints            = h-bonds

; Pressure coupling
;pcoupl              = parrinello-rahman
;pcoupltype          = isotropic
;tau_p               = 1.0
;compressibility     = 4.5e-5                       ; water (1atm&300K) it is 4.5e-5 [bar-1]
;ref_p               = 1.0

***

# choose lambda as T[0]/T[i]
# remember that high temperature is equivalent to low lambda
  lambda=$(echo $list | awk 'BEGIN{FS=",";}{print $1/$'$((i+1))';}')
echo $list > templist.dat
echo $lambda >> lambdalist.dat
# process topology
# (if you are curious, try "diff topol0.top topol1.top" to see the changes)
mpirun -np 1 plumed partial_tempering $lambda < processed.top > topol$i.top
# prepare tpr file
# -maxwarn is often needed because box could be charged
 grompp_mpi  -maxwarn 1 -o topol$i.tpr -f grompp$i.mdp -p topol$i.top -c conf.gro
done

#! /bin/bash -l

#####SBATCH --job-name=$1
#SBATCH --partition=lr3
#SBATCH --qos=lr_normal
#SBATCH --ntasks=16
#SBATCH -t 24:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=satyarth@lbl.gov
#SBATCH --account=pc_farea
#SBATCH --output=ats%jodid.out
#SBATCH --error=ats%jodid.err
#######SBATCH -C lr6_cas      NOTE: cas: cascade. has around 40 cpus per node.

module purge
module load gcc/9.2.0
module load openmpi/4.0.1-gcc

mpirun -np 16 /global/home/groups-sw/pc_ideas/amanzi-master3/install/bin/amanzi --xml_file="farea_3d_tritium.xml" > out.log


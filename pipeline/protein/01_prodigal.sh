#!/usr/bin/bash -l
#SBATCH -p short -c 1 --mem 1gb -N 1 -n 1 --out logs/prodigal.%A.log -a 1-948

#948 is number of bins, update to total number when adding more seqs to the folder

module load prodigal

CPU=2
if [ $SLURM_CPUS_ON_NODE ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi

IN=input
OUT=annotation
mkdir -p $OUT
N=${SLURM_ARRAY_TASK_ID}
if [ -z $N ]; then
  N=$1
fi
if [ -z $N ]; then
  echo "cannot run without a number provided either cmdline or --array in sbatch"
  exit
fi
GENOME=$(ls $IN/*.fasta | sed -n ${N}p)
BASE=$(basename $GENOME .fasta)

prodigal -a $OUT/$BASE.aa -d $OUT/$BASE.cds -o $OUT/$BASE.gbk -q -i $GENOME

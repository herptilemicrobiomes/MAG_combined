#!/usr/bin/bash -l
#SBATCH --nodes 1 --ntasks 8 --mem 8gb -p short
#SBATCH --job-name=kofamscan -a 1-948
#SBATCH --output=logs/domains.kofamscan.%a.log

EXT=aa
PROTEINS=annotation
DOMAINS=domains

mkdir -p $DOMAINS/kofam
module load kofamscan

CPUS=$SLURM_CPUS_ON_NODE
if [ ! $CPUS ]; then
 CPUS=1
fi

IN=${SLURM_ARRAY_TASK_ID}

if [ ! $IN ]; then
 IN=$1
 if [ ! $IN ]; then
   IN=1
   echo "defaulting to IN value is 1 - specify with --array or cmdline"
 fi
fi

TOTAL=$(ls $PROTEINS/*.${EXT} | wc -l)
if [ $IN -gt $TOTAL ]; then
 echo "Only $TOTAL files in folder $PROTEINS, skipping $IN"
 exit
fi
INFILE=$(ls $PROTEINS/*.${EXT} | sed -n ${IN}p)
OUT=$DOMAINS/kofam/$(basename ${INFILE} .${EXT}).kofam.tsv
OUTRICH=$DOMAINS/kofam/$(basename ${INFILE} .${EXT}).kofam.txt
if [ ! -s $OUT ]; then
	exec_annotation -o $OUT --cpu $CPUS -f mapper -E 0.0001 -k $KOFAM_DB/ko_list $INFILE
	exec_annotation -o $OUTRICH --cpu $CPUS -f detail -E 0.0001 -k $KOFAM_DB/ko_list $INFILE 
fi

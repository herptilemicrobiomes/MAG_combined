#!/usr/bin/bash -l
#SBATCH -p highmem -c 32 -N 1 -n 1 --mem 256gb  --out logs/gtkdb.log --time 48:00:00
CPUS=2
if [ $SLURM_CPUS_ON_NODE ]; then
  CPUS=$SLURM_CPUS_ON_NODE
fi

module load gtdbtk
if [ ! -f 214 ]; then
	ln -s /bigdata/operations/pkgadmin/srv/projects/db/gtdbtk/214
fi
IN=input
mkdir -p tmp
GTDBTK_DATA_PATH=214 gtdbtk classify_wf --genome_dir $IN --out_dir gtdbtk -x fasta --prefix gtdbtk --cpus $CPUS \
	--pplacer_cpus 8  --tmpdir ./tmp --mash_db mashdb.msh

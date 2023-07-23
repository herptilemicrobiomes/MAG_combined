#!/usr/bin/bash -l
#SBATCH -p short
BASE=orig
FINAL=input
mkdir -p $FINAL
for STRAIN in $(ls $BASE)
do
	for BIN in $(ls $BASE/$STRAIN/*.fasta)
	do
		D=$FINAL/$(basename `dirname $BIN`)
		if [ ! -d $D ]; then
			mkdir -p $D
		fi
		B=$(basename $BIN .fasta | perl -p -e 's/_R//')
		echo "B=$B BIN=$BIN D=$D"
		perl -p -e "s/>/>$B./" $BIN > $D/$(basename $BIN)
	done
done
pushd $FINAL
for file in $(ls *.bin_*)
do
	m=$(echo -n $file | perl -p -e 's/bin_/bin./')
	mv $file $m
done

for file in $(ls *_R.*)
do
	m=$(echo -n $file | perl -p -e 's/_R\.//')
	mv $file $m
done


mkdir -p orig
pushd orig
# STP701 ended up being all HOST DNA so skipping
for a in $(ls ../../Fecal/results | grep -v STP701); 
do 
	nm=$(basename $a); echo $nm
	mkdir -p $nm
	ln -s $(realpath ../../Fecal/results/$a)/bins/*.fa $nm
	pushd $nm
	for b in $(ls *.fa)
	do 
		mv $b ${b}sta # rename so these are all .fasta named
	done
	popd
done
mkdir -p UHM840.12199
ln -s $(realpath ../../PhaseGenomics/UHM840/UHM840.12199/MAGs/microbial_genomes/uhm840-12199_787132_clusters)/*.fasta UHM840.12199/

mkdir -p UHM51.10867
pushd UHM51.10867
ln -s $(realpath ../../../Pilot_2022_10/results/UHM51.10867/bins/)/*.fa .
for b in $(ls *.fa)
do
	mv $b ${b}sta # rename so these are all .fasta named
done
popd
mkdir -p UHM51.10868
pushd UHM51.10868
ln -s $(realpath ../../../Pilot_2022_10/results/UHM51.10868/bins/)/*.fa .
for b in $(ls *.fa)
do
        mv $b ${b}sta # rename so these are all .fasta named
done
popd
popd


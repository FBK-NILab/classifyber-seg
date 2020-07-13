#!/bin/bash

t1=$1
tck=$2

DIR=$(dirname "${t1}")

WARP_DIR=${DIR}/warp_dir
OUT_DIR=${DIR}/track_aligned
mkdir -p ${WARP_DIR}
mkdir -p ${OUT_DIR}

atlas=MNI152_T1_1.25mm_brain.nii.gz

if [ -f ${OUT_DIR}/track_MNI.tck ]; then 
    echo "Tractogram already registered in MNI space."
else 
    echo "Computing warp to MNI space..."
    ./ants_t1w_transformation.sh $t1 $atlas

	mv space_MNI_var-t1w_affine.txt $WARP_DIR
	mv space_MNI_var-t1w_warp.nii.gz $WARP_DIR
	mv space_MNI_var-t1w4tck_warp.nii.gz $WARP_DIR	

	if [ -z "$(ls -A -- "$WARP_DIR")" ]; then    
		echo "Transformation failed."
		exit 1
	else    
		echo "Transformation done."
	fi		

	echo "Registering the tractogram to MNI space..."
	tcktransform $tck ${WARP_DIR}/space_MNI_var-t1w4tck_warp.nii.gz \
	             $OUT_DIR/track_MNI.tck -nthreads 0 -force -quiet

	if [ -z "$(ls -A -- "$OUT_DIR")" ]; then    
		echo "Registration failed."
		exit 1
	else    
		echo "Registration done."
	fi

fi
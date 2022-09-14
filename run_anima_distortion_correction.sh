
# bash function that runs distortion correction 
run_anima_dc () {
    phase_encode=$1 #0,1,2 - x,y,z
    echo "Phase encode is $phase_encode"
    cd /data/
    echo1=$2
    echo2=$3
    echo "Running animaDistortionCorrection"
    init=${echo1/.nii.gz/}_init_correction.nii.gz
    /anima/animaDistortionCorrection -d $phase_encode -f $echo1 -b $echo2 -o $init -s 2 > log_animaDistortionCorrection
    echo "Running animaBMDistortionCorrection"
    bm_corrected=${echo1/.nii.gz/}_bm_corrected_image.nii.gz
    bm_correction=${echo1/.nii.gz/}_bm_correction.nii.gz
    /anima/animaBMDistortionCorrection -d $phase_encode -f $echo1 -b $echo2 -i $init -o $bm_corrected -O $bm_correction > log_animaBMDistortionCorrection
    /anima/animaApplyDistortionCorrection -f $echo1 -t $bm_correction -o ${echo1/.nii.gz/_corrected.nii.gz} > log_animaApplyDistortionCorrection
}

phase_encode=$1
echo1=$2
echo2=$3
run_anima_dc $phase_encode $echo1 $echo2

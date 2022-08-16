
# bash function that runs distortion correction 
run_anima_dc () {
    phase_encode=$1 #0,1,2 - x,y,z
    echo "Phase encode is $phase_encode"
    cd /data/
    echo1=$2
    echo2=$3
    echo "Running animaDistortionCorrection"
    /anima/animaDistortionCorrection -d $phase_encode -f $echo1 -b $echo2 -o Init_Correction.nii.gz -s 2 > log_animaDistortionCorrection
    echo "Running animaBMDistortionCorrection"
    /anima/animaBMDistortionCorrection -d $phase_encode -f $echo1 -b $echo2 -i Init_Correction.nii.gz -o BM_Corrected_Image.nii.gz -O BM_Correction.nii.gz > log_animaBMDistortionCorrection
    T=BM_Correction.nii.gz
    echo "Running animaApplyDistortionCorrection"
    /anima/animaApplyDistortionCorrection -f $echo1 -t $T -o ${AP/.nii.gz/_corrected.nii.gz} > log_animaApplyDistortionCorrection
}

phase_encode=$1
echo1=$2
echo2=$3
run_anima_dc $phase_encode $echo1 $echo2
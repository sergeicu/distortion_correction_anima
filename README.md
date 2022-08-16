# Example 

Example script + data for how to run [anima's Distortion Correction tool](https://anima.readthedocs.io/en/latest/registration.html).

```
# get docker image 
docker pull sergeicu/anima:latest

# specify files 
echo1=./example_data/echo1.nii.gz
echo2=./example_data/echo2.nii.gz

# specify phase encode - 0, 1, 2 == x,y,z (see more details below) 
phase_encode=1

# run docker 
docker run --rm -v $PWD:/data sergeicu/anima /bin/bash /data/run_anima_distortion_correction.sh $phase_encode $echo1 $echo2 & 



```


## How to get correct phase encode 

### Using json file 

Uses .json file that is generated by `dcm2niix` during dicom to nifti conversion. 

See example json file in `./example_data/example_anonymized.json`.   
If `InPlanePhaseEncodingDirectionDICOM` is `COL`, then `phase_encode` is `1`, else `phase_encode` is `0`.

### Using dicomfile 

Alternatively, check `InPlanePhaseEncoding` field in the correct dicom file from which the data was generated, and apply the same logic as in the json example above. 
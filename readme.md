## Deep Alignment Network Based Multi-person Tracking with Occlusion and Motion Reasoning

* **Introduction**: This repository contains the implementation of paper [Deep Alignment Network Based Multi-person Tracking with Occlusion and Motion Reasoning](https://ieeexplore.ieee.org/abstract/document/8488599).

* **Abstract**: Tracking-by-detection is one of the most common paradigms for multi-person tracking, due to the availability of automatic pedestrian detectors. However, existing multi-person trackers are greatly challenged by misalignment in the pedestrian detectors (i.e., excessive background and part missing) and occlusion. To address these problems, we propose a deep alignment network based multi-person tracking method with occlusion and motion reasoning. Specifically, the inaccurate detections are firstly corrected via a deep alignment network, in which an alignment estimation module is used to automatically learn the spatial transformation of these detections. As a result, the deep features from our alignment network will have a better representation power and thus lead to more consistent tracks. Then, a coarse-to-fine schema is designed for construing a discriminative association cost matrix with spatial, motion and appearance information. Meanwhile, a principled approach is developed to allow our method to handle occlusion with motion reasoning and the re-identification ability of the pedestrian alignment network. Finally, a simple yet real-time Hungarian algorithm is employed to solve the association problem. Comprehensive experiments on MOT16, ISSIA soccer, PETS09 and TUD datasets validate the effectiveness and robustness of the proposed method.


## Citation: 
```
@article{zhou2018deep,
  title={Deep Alignment Network Based Multi-person Tracking with Occlusion and Motion Reasoning},
  author={Zhou, Qinqin and Zhong, Bineng and Zhang, Yulun and Li, Jun and Fu, Yun},
  journal={IEEE Transactions on Multimedia},
  year={2018},
  publisher={IEEE}
}
```

## Preparation:

You need to compile the implementation of the Hungarian algorithm by running make.m in the tracking directory.

Usage:

1) Download the MOT16 sequences from https://motchallenge.net/data/MOT16/ and place them in data folder. Download the traied deep align model from https://pan.baidu.com/s/1UL5EfgvQJSRDbT3JIrMzXw (umdx) and place it in models folder.  
   
2) Preparing Matconvnet and run 'gpu_compile.m' to compile the files used in establishing the deep appearance model.

3) You can run the other detector to obtain the detection results first. Simply put the corresponding object_02 folder underneath the corresponding sequence folder.

   - OR -

   Alternatively, you can also use the detections provided by https://motchallenge.net in the det folder.

4) To run the tracking stage, open 'tracker.m' and modify the variables base_dir and seq_dir to point to one of the downloaded sequences. Run the script. The tracking results are stored in 'tracking_results.txt'.


## Experiments

### 1. Settings
* We conduct our experiments on 1 GTX1080ti GPU

### 2. Quantitative comparison results on the test sequences from the MOT16 benchmark
| Tracker      | MOTA | MOTP|MT|ML|FP|FN|ID SW.|Frag|Hz|Detector|
| -------------|:-------------:| :-----:|:-------------:| :-----:|:-------------:| :-----:|:-------------:| :-----:|:-------------:| :-----:|
| JPDA_m          | 26.2 |76.3| 4.1%| 67.5%| 3689 |130549| 365| 638| 22.2| Public |
| GMPHD_HDA     | 30.5| 75.4 |4.6%| 59.7% |5169| 120970| 539|731| 13.6| Public|
| CppSORT   | 31.5| 77.3| 4.3% |59.9% |3048| 120278| 1587| 2239| 687.1| Public|
| CEM         |33.2 |75.8 |7.8% |54.4%| 6837| 114322| 642| 731| 0.3| Public|
| GM_PHD_N1T      |33.3 |76.8 |5.5% |56.0% |1750| 116452 |3499 |3594| 9.9 |Public|
| TBD |33.7| 76.5 |7.2% |54.2%| 5804 |112587 |2418| 2252| 1.3| Public|
| HISP_T          |35.9 |76.1| 7.8% |50.1% |6412 |107918| 2594| 2298 |4.8| Public|
| JCmin_MOT        |36.7| 75.9| 7.5% |54.4%| 2936| 111890| 667 |831| 14.8| Public|
| LTTSC-CRF         |37.6 |75.9 |9.6% |55.2% |11969 |101343 |481| 1012| 0.6| Public|
| GMMCP         |38.1 |75.8 |8.6%| 50.9% |6607 |105315 |937| 1669 |0.5 |Public|
| OVBT|38.4| 75.4| 7.5% |47.3%| 11517 |99463 |1321| 2140 |0.3| Public|
| EAMTT_pub|38.8 |75.1 |7.9% |49.1% |8114 |102452| 965| 1657 |11.8 |Public|
| Ours|40.8| 74.4 |13.7% |38.3% |15143 |91792 |1051 |2210| 6.5| Public|

### 3. Quantitative comparison results on the PETS09-S2L2 benchmark
| Tracker| MOTA| MOTP| MT| ML|FP| FN|ID Sw.| Frag| Detector|
| -------------|:-------------:| :-----:|:-------------:| :-----:|:-------------:| :-----:|:-------------:| :-----:|:-------------:|
| GMPHD_HDA  |31.9 |69.1 |0.0%| 31.0% |467 |5965 |131| 315 |Public|
| CppSORT | 36.8| 69.3| 0.0%| 16.7% |511 |5251 |331| 480 |Public|
| JPDA_m | 37.6 |65.9| 11.9% |19.0% |1016 |4858 |139 |260 |Public|
| EAMTT_pub |39.9 |69.7 |7.1%| 14.3% |758 |4814| 218| 357 |Public|
| Ours |44.7| 68.6 |9.5%| 7.1%| 1331| 3707| 294| 546| Public|

### 4. Quantitative comparison results on the TUD-Crossing benchmark
|Tracker| MOTA| MOTP| MT| ML| FP| FN| ID Sw.| Frag| Detector|
| -------------|:-------------:| :-----:|:-------------:| :-----:|:-------------:| :-----:|:-------------:| :-----:|:-------------:|
|EAMTT_pub | 48.0 |72.9 |23.1% |15.4% |110 |436 |27 |37 |Public|
|GMPHD_HDA | 50.5 |72.3 |15.4%| 15.4%| 41 |485| 19 |29 |Public|
|CppSORT | 50.6| 74.0 |7.7% |15.4%| 22 |489| 33| 57 |Public|
|JPDA_m | 60.9 |68.4| 30.8% |23.1% |44 |385 |2 |26 |Public|
|Ours |77.1 |72.1| 76.9%| 0.0% |83 |151 |18 |27 |Public|

### 5. Quantitative comparison results on the ISSIA soccer dataset
|Tracker| MOTA| MOTP| MT| ML| FP| FN| ID Sw.| Detector|
| -------------|:-------------:| :-----:|:-------------:| :-----:|:-------------:| :-----:|:-------------:| :-----:|
|Ours with HSV| 69.5| 71.2 |18.0%| 5.0%| 1463| 2386| 369| YOLOv3|
|Ours |77.1 |77.9 |19.0% |5.0% |1374| 1992| 119| YOLOv3|

### 6. Quantitative tracking results obtained by our multi-person tracker using Faster R-CNN on MOT16 benchmark
|Tracker| MOTA| MOTP| MT| ML| FP| FN| ID Sw.| Frag|
| -------------|:-------------:| :-----:|:-------------:| :-----:|:-------------:| :-----:|:-------------:| :-----:|
|Ours(with Faster R-CNN) |59.7| 78.9 |32.4% |21.6% |11034 |61160| 1292 |1575|



## Contacts: 
If you have any question, please feel free to contact with me.

E-mail: zhouqinqin07@outlook.com




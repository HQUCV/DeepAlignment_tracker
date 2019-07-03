This is the tracking code for paper:

@article{zhou2018deep,
  title={Deep Alignment Network Based Multi-person Tracking with Occlusion and Motion Reasoning},
  author={Zhou, Qinqin and Zhong, Bineng and Zhang, Yulun and Li, Jun and Fu, Yun},
  journal={IEEE Transactions on Multimedia},
  year={2018},
  publisher={IEEE}
}


Preparation:

You need to compile the implementation of the Hungarian algorithm by running make.m in the tracking directory.

Usage:

1) Download the MOT16 sequences
   from https://motchallenge.net/data/MOT16/
   
2) Preparing Matconvnet and run 'gpu_compile.m' to compile the files used in establishing the deep appearance model.

3) You can run the other detector to obtain the detection results first. Simply put the corresponding object_02 folder underneath the corresponding sequence folder.

   - OR -

   Alternatively, you can also use the detections provided by https://motchallenge.net in the det folder.

4) To run the tracking stage, open 'tracker.m' and modify the variables base_dir and seq_dir to point to one of the downloaded sequences. Run the script. The tracking results are stored in 'tracking_results.txt'.



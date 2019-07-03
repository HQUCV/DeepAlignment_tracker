clear all; close all; dbstop error;
warning off MATLAB:MKDIR:DirectoryExists;
addpath matlab;
run matlab/vl_setupnn;
% settings
seq_dir = '/home/ZQQ/DeepAlinment_tracker/data/MOT16/test/MOT16-07';
% image directory and model type 
img_dir = [seq_dir '/img1'];
addpath('tracking');
model_type = 'person';
c=-0.4;
% read detection lables in KITTI format
detections_kitti = labels_reader([seq_dir '/det']);

% convert from KITTI format to tracking format
detections = convertFromKITTI(detections_kitti,model_type,c);

% generate tracklets
tracklets = generateTracklets(detections,img_dir);

% convert from tracking format to KITTI format
tracklets_kitti = convertToKITTI(tracklets,length(detections_kitti),model_type);

% save the tracking results and visilization
results_writer(tracklets_kitti,[seq_dir '/tracking_results.txt']);
% done
fprintf('done!\n');

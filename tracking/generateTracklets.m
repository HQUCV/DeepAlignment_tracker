function tracklet = generateTracklets(detection,img_dir,tracking_benchmark)
%% Build appearance models
if nargin<3
  tracking_benchmark = 0;
end
[ net1, net2 ] = get_appearance_models('/home/ZQQ/DeepAlinment_tracker/models/net-epoch-40.mat');

%% Pre-load images
disp('STAGE 0: Loading images ...');
first_frame = detection{1}.frame;
last_frame = detection{end}.frame;
for i=first_frame:last_frame
  if tracking_benchmark
    im = imread([img_dir '/' num2str(i,'%06d') '.png']);
  else
    im = imread([img_dir '/' num2str(i,'%06d') '.jpg']);
  end
  if length(size(im))==3
    im = rgb2gray(im);
  end
  I{i-first_frame+1} = im;
end

%% The main tracking process
tracklets  = [];
tracklet = [];
active = [];
kfstate = [];
% for all frames do
for i=1:length(detection)
  % output
  fprintf('STAGE 1: Processing frame %d/%d\n',i,length(detection));
  bbox = isempty_det(detection{i});
  % convert to object detection representation
  object1 = bboxToPosScale(bbox);
  object = bbox_refine(object1);
  % active tracklets
  idx_active = find(active); 
  % if active tracklets exist => try to associate
  if ~isempty(idx_active)
    if ~isempty(detection{i})
        % dist matrix
        dist = zeros(length(idx_active),size(object,1));
        obj_feat = extractFeature(I{i},object,net1,net2);
        % predict state and compute distance to detections
        [ kfstate, tracklets, assignment, active ] = associate_calculus( idx_active, dist, kfstate, tracklets, object, obj_feat, active, i);
    end    
    % remove assigned detections from object list
    object(assignment(assignment>0),:) = [];
  end
  
  %% Add remaining detections as new tracks
  for j=1:size(object,1)
    [ dist_geo1, dist_geo2 ] = boxoverlap_results(object, tracklets, j);
    if  dist_geo1<0.7 && dist_geo2<0.7
        tracklets{end+1}.track = [i object(j,:)];
        tracklets{end}.oc = 0;
        tracklets{end}.co = 1;
        tracklets{end}.feat = extractFeature(I{i},object(j,:),net1,net2);
        tracklets{end}.vel=[0,0];
        kfstate{end+1}   = kfinit(object(j,:),1,5);
        active(end+1) = 1;
     end
  end  
end

%% Remove unreliable tracklets
for i = 1:length(tracklets)
    if tracklets{i}.oc ~= 0
        u = size(tracklets{i}.track,1);
        u = u - tracklets{i}.oc+1;
        tracklets{i}.track(u:end,:) = [];
    end
    tracklet{end+1} = tracklets{i}.track;
end

%% Remove short tracklets (smaller than 3 frames)
if 1
  idx = [];
  for i=1:length(tracklet) 
    if size(tracklet{i},1)<3
      idx = [idx i];
    end
  end
  tracklet(idx) = [];
end

% add tracklet id
for i=1:length(tracklet)
  tracklet{i} = [tracklet{i} i*ones(size(tracklet{i},1),1)];
end
end


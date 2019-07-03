%% For MOT16
function tracklets = labels_reader (filename)

% read files in directory and concatenate tracklets
if isdir(filename)
  dirname = filename;
  files = dir([dirname '/*.txt']);
  tracklets = [];
  for i=1:length(files)
    tracklets_curr = read_file([dirname '/' files(i).name]);
    for j=1:length(tracklets_curr)
      if length(tracklets)<j
        tracklets{j} = tracklets_curr{j};
      else
        tracklets{j} = [tracklets{j} tracklets_curr{j}];
      end
    end
  end
  
% read a single file
else
  tracklets = read_file(filename);
end

function tracklets = read_file (filename)

% parse input file
fid = fopen(filename);
try
  C = textscan(fid, '%d,%d,%f,%f,%f,%f,%f,%d,%d,%d');
catch
  keyboard;
  error('This file is not in KITTI tracking format or the file does not exist.');
end
fclose(fid);

% for all objects do
tracklets = {};
nimages = max(C{1});
for f=1:nimages
  objects = [];
  idx = find(C{1}==f);
  nn=numel(idx)+1;
  for i = 1:numel(idx)
    o=idx(i);

    % extract label, truncation, occlusion
    objects(nn-i).frame      = f;       % frame
    objects(nn-i).type       = 'person';  % 'Car', 'Pedestrian', ...
    objects(nn-i).alpha      = C{2}(o); % object observation angle ([-pi..pi])

    % extract 2D bounding box in 0-based coordinates
    objects(nn-i).x1 = C{3}(o); % left
    objects(nn-i).y1 = C{4}(o); % top
    objects(nn-i).x2 = C{5}(o); % right
    objects(nn-i).y2 = C{6}(o); % bottom
    objects(nn-i).score = C{7}(o); % score
  end
  tracklets{f} = objects;
end

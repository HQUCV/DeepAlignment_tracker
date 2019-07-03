function dist = trackletLocation(object,obj_feat,tracklet)

% intersection over union
bbox1 = posScaleToBbox(object(:,1:4));
bbox2 = posScaleToBbox(tracklet.track(end,2:5));
dist = 1.0-boxoverlap(bbox1,bbox2)';
m = find(dist~=1);
if size(m,2) >= 1
    for i = 1:length(m)
        if dist(m(i)) <= 0.5
            dist(m(i))  = 0.4*dist(m(i))+0.6*sqdist(obj_feat(:,m(i)),tracklet.feat);
        else
            dist(m(i))  = 0.8*dist(m(i))+0.2*sqdist(obj_feat(:,m(i)),tracklet.feat);
        end
    end
end
dist(dist==1) = inf;
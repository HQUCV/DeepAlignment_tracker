function [ dist_geo1, dist_geo2 ] = boxoverlap_results(object, tracklets, j)
    dist_geo1=0;
    dist_geo2=0;
    for u=1:length(tracklets)
      bbox1 = posScaleToBbox(object(j,1:4));
      bbox2 = posScaleToBbox(tracklets{u}.track(end,2:5));
      dist_geo1 = boxoverlap(bbox1,bbox2)';
      if  dist_geo1>0.55
        break;
      end
    end
    for n=j+1:size(object,1)
      bbox1 = posScaleToBbox(object(j,1:4));
      bbox2 = posScaleToBbox(object(n,1:4));
      dist_geo2 = boxoverlap(bbox1,bbox2)';
      if  dist_geo2>0.55
        break;
      end
    end

end


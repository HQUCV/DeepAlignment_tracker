function bbox = isempty_det(det)
  if ~isempty(det)
      if ~isempty(det.bbox) 
          % extract bounding box
          bbox = det.bbox;
      else
        bbox=[];
      end
  else
      bbox=[];
  end
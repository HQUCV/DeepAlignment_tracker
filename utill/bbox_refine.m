function object = bbox_refine(obj1)
object=[];
for ii=1:size(obj1,1)
    dist_geo2=0;
    for jj=ii+1:size(obj1,1)
      box1 = posScaleToBbox(obj1(ii,1:4));
      box2 = posScaleToBbox(obj1(jj,1:4));
      dist_geo2 = boxoverlap_rate(box1,box2)';
      if  dist_geo2>0.8
           break;
      end
    end
    if  dist_geo2<0.8
        object(end+1,:)=obj1(ii,:);
    end
end

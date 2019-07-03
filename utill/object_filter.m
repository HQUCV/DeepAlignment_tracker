function obj=object_filter(object,param)

for i=1:size(object,1)
    scale = object(i,4)/object(i,3);
    prop = object(i,4)*object(i,3);
    if scale > param.scale || prop > param.prop
        
        object(i,:) = [];
        
    end
end





end
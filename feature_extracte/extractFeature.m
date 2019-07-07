function feat  = extractFeature(im, pos, net1,net2)

 alpha = 0.5;
 u1 = pos(:,1)-pos(:,3)/2;
 v1 = pos(:,2)-pos(:,4)/2;
 pos = [u1 v1 pos(:,3:4)];

if size(pos,1) == 1 
    % Get the search window from previous detection
    patch =  imcrop(im,pos);
    feat1 = extract_base_feat(net1,patch)';
    feat2 = extract_align_feat(net2,patch)';

    % Extracting hierarchical convolutional features
    feat = cat(1,feat1*alpha,feat2*(1-alpha));
else
    patch1=[];
    patch2=[];
    for i =1:size(pos,1)
        patch =  imcrop(im,pos(i,:));
        imt1 = imresize(patch,[256,256]);
        patch1 = cat(4,patch1,imt1);
        imt2 = imresize(patch,[227,227]);
        patch2 = cat(4,patch2,imt2);
    end
    feat1 = extract_base_feat(net1,patch1)';
       
    feat2 = extract_align_feat(net2,patch2)';
      
    % Extracting hierarchical convolutional features
    feat = cat(1,feat1*alpha,feat2*(1-alpha));
end 

end
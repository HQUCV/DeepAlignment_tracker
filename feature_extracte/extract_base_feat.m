function feat=extract_base_feat(net,img)
    
    clear netStruct;
    net.mode = 'test';
    net.move('gpu') ;
    net.conserveMemory = true;
    im_mean = net.meta(1).normalization.averageImage;

    imt = imresize(img,[256,256]);

    feat = getFeature2(net,imt,im_mean,'input','pool5n');
    feat = sum(sum(feat,1),2);
    f2 = getFeature2(net,fliplr(imt),im_mean,'input','pool5n');
    f2 = sum(sum(f2,1),2);
    feat = feat+f2;
    size4 = size(feat,4);
    feat = reshape(feat,[],size4)';
    s = sqrt(sum(feat.^2,2));
    dim = size(feat,2);
    s = repmat(s,1,dim);
    feat = feat./s;

end

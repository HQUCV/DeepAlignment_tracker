function [ net1, net2 ] = get_appearance_models( models_add )
netStruct1 = load(models_add);
    %--------add l2 norm
net1 = dagnn.DagNN.loadobj(netStruct1.net);
net1.addLayer('lrn_test',dagnn.LRN('param',[4096,0,1,0.5]),{'x18'},{'pool5n'},{});
net1.removeLayer('aff');
netStruct2 = load(models_add);
    %--------add l2 norm
net2 = dagnn.DagNN.loadobj(netStruct2.net);
net2.addLayer('lrn_test',dagnn.LRN('param',[4096,0,1,0.5]),{'x18_local'},{'pool5n_local'},{});
end


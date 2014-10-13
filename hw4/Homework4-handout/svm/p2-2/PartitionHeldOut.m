% partitions data into k segments, and randomly chooses which segment to
% leave out
%testInstanceLabel: size by 1 column vector indicating 1 where elements
%chosen to be in testing set, and 0 otherwise
function testInstanceLabel = PartitionHeldOut(size, k)
    testInstanceLabel = zeros(size,1);
    % randomly select a set to be used as test set between 1 and k
    randomlySelectedSet = round(1 + ((k-1)*rand(1,1)));
    
    % assumes this value is integer
    set_size = size/k;
    
    set_start = (set_size*(randomlySelectedSet-1))+1;
    for i=set_start:set_start+set_size-1
        testInstanceLabel(i) = 1;
    end 
    assert(sum(testInstanceLabel) == size/k)
end 

    
    
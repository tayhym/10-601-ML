% randomly assign instances to 1 of k sets, each set 
% have approximately (as close as possible) the same number of instances
% YcrossSetLabel: column vector for set the instance belongs to, 
%                 from 1 to k
function [YcrossSetLabel] = PartitionCrossSet(size,k)
    YcrossSetLabel = zeros(size,1);
    % number of elements in each set is approximately the same
    setSize = size/k;
    normal_setSize = floor(setSize);
    
    excess = 0;
    % check if decimal present
    if (normal_setSize ~= setSize)
        % excess elements present
        excess = setSize-(normal_setSize*k);
    end 
    
    index = 1; % varies from 1 to size
    for i=1:k
        % fill YcrossSetLabel vector with respective labels
        num_in_group = normal_setSize;
        if (excess~=0)
            num_in_group = num_in_group+1;
            excess = excess -1;
        end 
        while (num_in_group~=0)
            YcrossSetLabel(index) = i;
            num_in_group = num_in_group - 1;
            index = index+1;
        end 
    end
end


    
       
            
            
        
    
    
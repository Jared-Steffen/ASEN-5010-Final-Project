function [RnN] = RnN_DCM(t)
    % [RnN] 
    HN = HN_DCM(t,"LMO");

    RnH = [-1 0 0;
           0 1 0;
           0 0 -1];

    RnN = RnH*HN;
    
end


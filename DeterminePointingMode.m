function pointing_mode = DeterminePointingMode(t)
    
% Get LMO and GMO positions
NrLMO = GetInertialPos(t,"LMO");
NrGMO = GetInertialPos(t,"GMO");

% Set sun direction
n2 = [0 1 0];

% Determine if on sunlit or shadowed side of Mars
alpha = acos(dot(NrLMO,n2)/norm(NrLMO));

% Set pointing mode to sun if < 90 degrees from n2
if alpha < pi/2
    pointing_mode = "sun";
% Otherwise, find angle between LMO and GMO
else
    beta = acos(dot(NrLMO,NrGMO)/(norm(NrLMO)*norm(NrGMO)));
    if beta < deg2rad(35)
        pointing_mode = "GMO";
    else
        pointing_mode = "nadir";
    end
end

end


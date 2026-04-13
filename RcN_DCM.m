function [RcN] = RcN_DCM(t)

    
    % Get necessary rotation matrices
    HN = HN_DCM(t,"LMO");
    GN = HN_DCM(t,"GMO");

    % Make r vectors in their frames
    hLMO = 400; % [km]
    RMars = 3396.19; % [km]
    rLMO = RMars + hLMO;
    rGMO = 20424.2; % [km]

    Hrvec = [rLMO 0 0]';
    Grvec = [rGMO 0 0]';

    % [N_rLMO,~] = GetInertialState(t,"LMO");
    % [N_rGMO,~] = GetInertialState(t,"GMO");
    % Ndelta_rvec2 = N_rGMO - N_rLMO;

    % Get delta_r
    Ndelta_rvec = GN'*Grvec - HN'*Hrvec;

    % Form unit vecotrs in N frame
    Nr1 = -Ndelta_rvec./norm(Ndelta_rvec);
    n3 = [0 0 1]';
    Nr2 = cross(Ndelta_rvec,n3)./norm(cross(Ndelta_rvec,n3));
    Nr3 = cross(Nr1,Nr2);

    % [RcN]
    RcN = [Nr1';Nr2';Nr3'];
    
end


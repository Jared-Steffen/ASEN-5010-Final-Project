function [NwRnN] = NwRnN_vec(t)
% This function outputs the angualr velocity of the Rn/N in the N frame

    thetadot = 0.000884796; % [rad/s]
    HwHN = [0 0 thetadot]';
    HN = HN_DCM(t,"LMO");

    NwRnN = HN'*HwHN;

end


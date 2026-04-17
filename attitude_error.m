function [mrpBR,BwBR,mrpRN,BwRN] = attitude_error(t,mrpBN,BwBN,reference_frame)
% This function computes the attitude error between the body frame and a
% reference frame

% Get RN and NwRN
if reference_frame == "sun"
    RN = [-1 0 0;
            0 0 1;
            0 1 0];
    NwRN = [0 0 0]';
elseif reference_frame == "nadir"
    RN = RnN_DCM(t);
    NwRN = NwRnN_vec(t);
elseif reference_frame == "GMO"
    RN = RcN_DCM(t);
    NwRN = NwRcN_vec(t);
else
    error("Error: reference_frame must be 'sun','nadir', or 'GMO'")
end

% Construct BN from mrpBN, get ang vel
BN = MRPtoDCM(mrpBN);
NwBN = BN'*BwBN;

% Get BwBR
NwBR = NwBN-NwRN;
BwBR = BN*NwBR;

% Get mrpBR
BR = BN*RN';
EPs_BR = DCMtoEP(BR);
mrpBR = EPtoMRP(EPs_BR);

% Get references
BwRN = BN*NwRN;
EPs_RN = DCMtoEP(RN);
mrpRN_noswitch = EPtoMRP(EPs_RN);
if norm(mrpRN_noswitch) > 1
    mrpRN = -mrpRN_noswitch./norm(mrpRN_noswitch);
else
    mrpRN = mrpRN_noswitch;
end

end


function [NwRcN] = NwRcN_vec(t)
% This function outputs the angualr velocity of the Rn/N in the N frame
% through numerical differencing of two RcN matrices

dt = 1e-6;
RcNt = RcN_DCM(t);
RcNtdt = RcN_DCM(t+dt);
    
RcNdot = (RcNtdt-RcNt)/dt;   

wtilde = RcNdot*RcNt';

NwRcN = RcNt'*[wtilde(2,3) wtilde(3,1) wtilde(1,2)]';

end


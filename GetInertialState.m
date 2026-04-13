function [N_r,N_rdot] = GetInertialState(t,sat)
% This function takes the inputs of time, radial position, orbital angle
% rate, first 2 313 euler angles (Omega-i), theta0, and outputs the
% inertial position and velocity vectors

% Get DCM
ON = HN_DCM(t,sat);

if sat == "LMO"
    h = 400; % [km]
    RMars = 3396.19; % [km]
    r = RMars + h;
    thetadot = 0.000884796; % [rad/s]
elseif sat == "GMO"
    r = 20424.2; % [km]
    thetadot = 0.0000709003; % [rad/s]
else
    error('Error: Sat must be LMO or GMO')
end
    
N_r = r.*ON(1,:)';
N_rdot = r*thetadot.*ON(2,:)';

end


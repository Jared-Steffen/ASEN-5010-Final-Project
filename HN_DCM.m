function [HN] = HN_DCM(t,sat)
%   HN_DCM | This function is used to determine the euler 3-1-3 rotation
%   matrix from N to H frames

%   Inputs = 3 x 1 vector of Euler angles
%   Output = Euler 3-1-3 Rotation Matrix
    
    if sat == "LMO"
        Omega = deg2rad(20); % [deg] -> [rad]
        i = deg2rad(30); % [deg] -> [rad]
        theta0 = deg2rad(60); % [deg] -> [rad]
        thetadot = 0.000884796; % [rad/s]
        theta = theta0 + thetadot*t;
    elseif sat == "GMO"
        Omega = 0; % [deg]/[rad]
        i = 0; % [deg]/[rad]
        theta0 = deg2rad(250); % [deg] -> [rad]
        thetadot = 0.0000709003; % [rad/s]
        theta = theta0 + thetadot*t;
    else
        error('Error: Sat must be LMO or GMO')
    end
    
    % [HN] 
    HN = [cos(theta)*cos(Omega) - sin(theta)*cos(i)*sin(Omega), cos(theta)*sin(Omega) + sin(theta)*cos(i)*cos(Omega), sin(theta)*sin(i);
          -sin(theta)*cos(Omega) - cos(theta)*cos(i)*sin(Omega), -sin(theta)*sin(Omega) + cos(theta)*cos(i)*cos(Omega), cos(theta)*sin(i);
          sin(i)*sin(Omega), -sin(i)*cos(Omega), cos(i)];
    
end


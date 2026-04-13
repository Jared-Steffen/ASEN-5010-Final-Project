function [attitude] = GetEulerAngles(t,theta_dot,theta_0,Omega,i)
%   GetEulerAngles | This function gives 3-1-3 Eular angles for this
%   scenario

%   Inputs = time, theta_dot, theta_0, RAAN, inclination
%   Output = Euler 3-1-3 attitude

    % Get theta
    theta = theta0 + theta_dot*t;
    attitude = [Omega,i,theta];

end


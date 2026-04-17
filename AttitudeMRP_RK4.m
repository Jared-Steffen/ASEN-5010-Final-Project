function [t,X,u,pointing_mode,mrpRN,BwRN,mrpBR,BwBR] = AttitudeMRP_RK4(odefun,tspan,X0,h,constants)

% Get times, set number of steps
t0 = tspan(1);
tf = tspan(2);
N = (tf-t0)/h;
t = t0 + (0:N)*h;

% Setup
n = length(X0);
X = zeros(n,length(t));
X(:,1) = X0;

u = zeros(3,length(t));
mrpRN = zeros(3,length(t));
BwRN = zeros(3,length(t));
mrpBR = zeros(3,length(t));
BwBR = zeros(3,length(t));
pointing_mode = strings(1,length(t));

% Gains
P = constants.P;
K = constants.K;

% u = zeros(3,length(t));

mrpBN = X0(1:3);
BwBN = X0(4:6);

% RK4 Algorithm
for k = 1:length(t)-1
    hk = t(k+1) - t(k);
    tk = t(k);
    Xk = X(:,k);

    % Quantities at current time/state
    pointing_mode(k) = DeterminePointingMode(tk);

    mrpBN = Xk(1:3);
    BwBN = Xk(4:6);
    [mrpBR(:,k),BwBR(:,k),mrpRN(:,k),BwRN(:,k)] = attitude_error(tk,mrpBN,BwBN,pointing_mode(k));

    % Control held constant over this step
    u(:,k) = -K*mrpBR(:,k) - P*BwBR(:,k);


    % RK4
    k1 = odefun(tk, Xk,  u(:,k), constants);
    k2 = odefun(tk+hk/2, Xk+k1*hk/2, u(:,k), constants);
    k3 = odefun(tk+hk/2, Xk+k2*hk/2, u(:,k), constants);
    k4 = odefun(tk+hk, Xk+k3*hk, u(:,k), constants);

    Xkp1 = Xk + (hk/6)*(k1 + 2*k2 + 2*k3 + k4);

    % MRP Switching
    if norm(Xkp1(1:3)) >= 1
        X(1:3,k+1) = -Xkp1(1:3)./norm(Xkp1(1:3))^2;
    else
        X(1:3,k+1) = Xkp1(1:3);
    end
    X(4:6,k+1) = Xkp1(4:6);
end

% Fill final reference/mode/control at t(end) for plotting consistency
pointing_mode(end) = DeterminePointingMode(t(end));
[mrpBR(:,end),BwBR(:,end),mrpRN(:,end),BwRN(:,end)] = attitude_error(t(end),X(1:3,end),X(4:6,end),pointing_mode(end));
u(:,end) = -K*mrpBR(:,end) - P*BwBR(:,end);

end


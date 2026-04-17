function Xdot = AttitudeODE(t,X,u,constants)

% Extract MRPs
MRP = X(1:3);
sigma = norm(MRP);
sigma1 = MRP(1);
sigma2 = MRP(2);
sigma3 = MRP(3);

% Extract angular velocities
BwBN = X(4:6);
w1 = BwBN(1);
w2 = BwBN(2);
w3 = BwBN(3);

% Extract constants info
I = constants.I;
I11 = I(1,1);
I22 = I(2,2);
I33 = I(3,3);

MRP_dot = 1/4 * [ ...
    1 - sigma^2 + 2*sigma1^2, 2*(sigma1*sigma2 - sigma3), 2*(sigma1*sigma3 + sigma2); ...
    2*(sigma2*sigma1 + sigma3), 1 - sigma^2 + 2*sigma2^2, 2*(sigma2*sigma3 - sigma1); ...
    2*(sigma3*sigma1 - sigma2), 2*(sigma3*sigma2 + sigma1), 1 - sigma^2 + 2*sigma3^2 ...
]*BwBN;

% Angular velocity rates
BwBNdot = [(-(I33-I22)*w2*w3+u(1))/I11;
        (-(I11-I33)*w3*w1+u(2))/I22;
        (-(I22-I11)*w1*w2+u(3))/I33];

Xdot = [MRP_dot;BwBNdot];

end


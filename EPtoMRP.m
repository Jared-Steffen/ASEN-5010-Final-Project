function [mrps] = EPtoMRP(EPs)
% This function convert EPs to MRPs

B0 = EPs(1);
B1 = EPs(2);
B2 = EPs(3);
B3 = EPs(4);

mrps_test = [B1 B2 B3]'./(1+B0);

if norm(mrps_test) >= 1
    mrps = -[B1 B2 B3]'./(1-B0);
else
    mrps = mrps_test;

end


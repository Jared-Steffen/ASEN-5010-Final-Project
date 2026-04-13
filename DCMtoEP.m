function [EPset] = DCMtoEP(DCM)

B0sq = 0.25*(1+trace(DCM));
B1sq = 0.25*(1+2*DCM(1,1)-trace(DCM));
B2sq = 0.25*(1+2*DCM(2,2)-trace(DCM));
B3sq = 0.25*(1+2*DCM(3,3)-trace(DCM));

Bsq = [B0sq B1sq B2sq B3sq];

if max(Bsq) == B0sq
    B0 = sqrt(B0sq);
    B1 = (DCM(2,3)-DCM(3,2))/(4*B0);
    B2 = (DCM(3,1)-DCM(1,3))/(4*B0);
    B3 = (DCM(1,2)-DCM(2,1))/(4*B0);
elseif max(Bsq) == B1sq
    B1 =  sqrt(B1sq);
    B0 = (DCM(2,3)-DCM(3,2))/(4*B1);
    B2 = (DCM(1,2)+DCM(2,1))/(4*B1);
    B3 = (DCM(3,1)+DCM(1,3))/(4*B1);
elseif max(Bsq) == B2sq
    B2 = sqrt(B2sq);
    B0 = (DCM(3,1)-DCM(1,3))/(4*B2);
    B1 = (DCM(1,2)+DCM(2,1))/(4*B2);
    B3 = (DCM(2,3)+DCM(3,2))/(4*B2);
else
    B3 = sqrt(B3sq);
    B0 = (DCM(1,2)-DCM(2,1))/(4*B3);
    B1 = (DCM(3,1)+DCM(1,3))/(4*B3);
    B2 = (DCM(2,3)+DCM(3,2))/(4*B3);
end

EPset = [B0 B1 B2 B3];

end


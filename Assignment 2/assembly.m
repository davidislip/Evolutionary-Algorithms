function [ K M ] = assembly(X,Y,coords, connec, connec_dof, EA, EI, RHO )
%Assembly function to compute the stiffness and mass matrices
%   Detailed explanation goes here
ndof = 3;
K = zeros(ndof*size(coords,1));
M = zeros(ndof*size(coords,1));
for i = 1:size(connec);
    ig  = sort(reshape(connec_dof(connec(i,:),:),numel(connec_dof(connec(i,:),:)),[]));
    X1 = X(connec(i,1));
    X2 = X(connec(i,2));
    Y1 = Y(connec(i,1));
    Y2 = Y(connec(i,2));
    K(ig,ig) = K(ig,ig)+ ElementStiffMat(EA, EI, X1, Y1, X2, Y2);
    M(ig,ig) = M(ig,ig)+ ElementMassMat(RHO, X1, Y1, X2, Y2);
end

end


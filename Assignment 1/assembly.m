function [ K ] = assembly(coords, connec, connec_dof,L,A,E,l,m)
%This function computes the assembled stiffness matrix for the truss
%structure defined by the coordinates, the node connectivities and the
%degrees of freedom associated with each node. 

%initialize the stiffness matrix for the whole structure 
Kg = zeros(16*size(connec,1),1);
Ig = zeros(16*size(connec,1),1);
Jg = zeros(16*size(connec,1),1);
nq = 2*size(coords,1);
ii = [1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4];
jj = [1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4];
kk = 1:16;
%for each element increment the appropriate dofs of the assembled stiffness
%matrix by the elements stiffness matrix in global coordinates 
for i = 1:size(connec);
    %take the degrees of freedom and the 
    ig  = sort(reshape(connec_dof(connec(i,:),:),numel(connec_dof(connec(i,:),:)),[]));
    Ig(kk) = ig(ii);
    Jg(kk) = ig(jj);
    Ki = elementmatrix(connec(i,:), L(i),A(i),E(i),l(i),m(i));
    Kg(kk) = Ki{1}(:);
    kk = kk + 16;
end
K=sparse ( Ig , Jg , Kg, nq , nq );
end


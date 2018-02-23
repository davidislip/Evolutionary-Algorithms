function [ K ] = original_assembly(coords, connec, connec_dof,L,A,E,l,m)
%This function computes the assembled stiffness matrix for the truss
%structure defined by the coordinates, the node connectivities and the
%degrees of freedom associated with each node. 

%initialize the stiffness matrix for the whole structure 
K = zeros(2*size(coords,1));

%for each element increment the appropriate dofs of the assembled stiffness
%matrix by the elements stiffness matrix in global coordinates 
for i = 1:size(connec);
    %take the degrees of freedom and the 
    ig  = sort(reshape(connec_dof(connec(i,:),:),numel(connec_dof(connec(i,:),:)),[]));
    Ki = elementmatrix(connec(i,:), L(i),A(i),E(i),l(i),m(i));
    K(ig,ig) = K(ig,ig)+ Ki{1};
end

end


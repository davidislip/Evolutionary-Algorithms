function [K_global] = elementmatrix(connec, L,A,E,l,m)
%The elementmatrix function computes the stiffness matrix for each 
%element as defined by the connectivities(connec). Furthermore,it computes 
%the each elements length and direction cosines

n_elem = size(connec,1);%number of elements

%definition of axial stiffness for each element
k = A.*E./L;
%initialize cell arrays to store each elements stiffness matrix (local and
%global respectively
K_local{n_elem} = [];
K_global{n_elem} = [];
for i = 1:n_elem 
    %set up the transformation matrix for the current element and then set
    %the appropriate elements of the stiffness matrices
    T = l(i)*eye(4);
    T(1,2) = m(i);
    T(2,1) = -m(i);
    T(3,4) = m(i);
    T(4,3) = -m(i);
    K_local{i} = zeros(4);
    K_local{i}(1,1) = k(i);
    K_local{i}(1,3) = -k(i);
    K_local{i}(3,1) = -k(i);
    K_local{i}(3,3) = k(i);
    %applying the transformation matrix
    K_global{i} = T'*K_local{i}*T;
end


end


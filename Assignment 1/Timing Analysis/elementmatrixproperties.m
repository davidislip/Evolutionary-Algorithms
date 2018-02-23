function [L, l, m] = elementmatrixproperties(connec, coords)
%The elementmatrix function computes the stiffness matrix for each 
%element as defined by the connectivities(connec). Furthermore,it computes 
%the each elements length and direction cosines

n_elem = size(connec,1);%number of elements

%initialize length and direction cosines for each element
L = zeros(n_elem ,1);
l = zeros(n_elem ,1);
m = zeros(n_elem ,1);

%for each element compute the direction cosines
for i = 1:n_elem
    L(i) = sum(diff(coords(connec(i,:),:)).^2)^0.5;
    lm = diff(coords(connec(i,:),:))/L(i);
    l(i) = lm(1);
    m(i) = lm(2);
end

end


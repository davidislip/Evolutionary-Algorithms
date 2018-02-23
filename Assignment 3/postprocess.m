function [strain stress tension ] = postprocess( connec, connec_dof, U, l, m, E, L, A)
%This function computes the strain, stress and tension from the solved 
%discplacement vector by using the definition of strain and then applying
%hookes law and then finally applying the definition of stress 

n_elem = size(connec,1);


strain = zeros(n_elem,1);
for i = 1:n_elem
    ind = sort(reshape(connec_dof(connec(i,:),:),4,[]));
    li = l(i);
    mi = m(i);
    strain(i) = [-li -mi li mi]*U(ind)/L(i);
end

stress = E.*strain;

tension = stress.*A;

end


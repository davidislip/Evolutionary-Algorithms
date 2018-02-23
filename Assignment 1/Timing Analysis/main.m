%% Timing Analysis for a truss of n elements 
n = 200;
sparse_time = zeros(n,1);
time = zeros(n,1);
for j = 2:n+1
    [X,Y] = meshgrid(0:j,[0 1]);
    coords = [X(:),Y(:)];
    connec_dof = reshape(1:2*size(coords,1),2,[])';
    connec = [];
    for i = 1:size(coords,1)-1
        if i == size(coords,1) - 1;
        connec = [connec; [i i+1]];
        elseif coords(i,2) == 0;
        connec = [connec; [i i+1]; [i i+2];[i i+3]] ;
        elseif coords(i,2) ~ 0;
        connec = [connec; [i i+1]; [i i+2]];
        end
    end
E = 10*ones(size(connec,1),1);
A = E;
[L, l, m] = elementmatrixproperties(connec, coords);

f = @()assembly(coords, connec, connec_dof,L,A,E,l,m);
g = @()original_assembly(coords, connec, connec_dof,L,A,E,l,m);
sparse_time(j-1) = timeit(f);
time(j-1) = timeit(g);
end
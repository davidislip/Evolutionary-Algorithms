function [ u ] = modalfrfanalysis( EA, EI, rhoA, ohm, u_meshrefined)
%This function uses a bubnov galerkin scheme to compute the frequency
%response of a harmonic forcing function at (1,0) at node (3,0). Again C =
%10M. It also calculates 3 errro norms associated with the bubnov - galerkin
%approimation to the direct frequency response. It finally, computes the
%number of eigen vectors required according to the rule of thumb outlined
%in class
run Mesh4.m
coords = [X;Y]';
connec = NOD;
connec_dof = reshape(1:3*size(coords,1),3,[])';
[K, M]= assembly(X,Y,coords, connec, connec_dof, EA, EI, rhoA);
K = K(dof_active, dof_active);
M = M(dof_active, dof_active);
[phi,lambda] = eig(K,M);
C = 10*M; %given in problem data, Rayleigh damping

Xp = 1;
Yp = 0;
dir = 2; %direction of point load
node = X == Xp & Y == Yp; %find the location of the load
dofp = connec_dof(node,dir); %dof to apply the point load
%Setting the force vector:
f = zeros([3*size(coords,1),1]);
f = f(dof_active);
f(dofp) = 1;

Xr = 3;
Yr = 0;
noder = find(X == Xr & Y == Yr);
dofr = connec_dof(noder,dir);
reduced_index = dof_active == noder;

u = zeros([size(phi,1), ohm+1]);
for m = 1:size(phi,1)
    for freq = 0:ohm
        A = lambda(1:m,1:m) - ((2*pi*freq)^2)*eye(m) + 1i*2*pi*freq*10*eye(m);
        %Au = f
        q = A\phi(:,1:m)'*f;
        u0 = (phi(:,1:m))*q;
        u(m,freq+1) = u0(reduced_index);
    end     
end
%%

figure
hold on
plot(abs(u([1 5 10 100],:)'),'LineWidth',3)
plot(abs(u_meshrefined(:,4)),'LineWidth',3)
set(gca,'yscale','log')
title('Approximate transverse frequency response at (x,y) = (3,0)m','interpreter','latex')
legend('m = 1','m = 5 ','m = 10','m = 100', 'Direct Solution')
xlabel('Frequency (Hz)','interpreter','latex')
ylabel('Displacement Response','interpreter','latex')
text(1,0,'Modal Analysis Approach $$ u_0 \simeq \sum_i^m q_i(\Ohm)\phi_i $$','Interpreter','latex')
hold off
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Error analysis for the m eigenvalues
actual_u = u_meshrefined(:,4);
err = abs(u) - ones(size(u))*diag(abs(actual_u));
percentage_error = 100*err./(ones(size(err))*diag(abs(actual_u)));
figure
hold on
title('Absolute percentage errors of modal analysis approximation compared to direct solution','interpreter','latex')
xlabel('m - number of eigenvectors included in approximation','interpreter','latex')
ylabel('Absolute percentage error','interpreter','latex')
plot(max(abs(percentage_error')),'*')
plot(mean(abs(percentage_error')),'*')
plot(median(abs(percentage_error')),'*')
legend('maximum percentage error','mean percentage error','median percentage error')
set(gca,'yscale','log')
%%
%Rule of thumb 
min_eig = (1.5*2*pi*ohm)^2;
lambda(lambda >= min_eig);
c = find(diag(lambda) >= min_eig == 1);
fprintf(['According to the rule of thumb outlined in the notes, at least ' num2str(c(1)) ' eigenvalues should be included'])
end


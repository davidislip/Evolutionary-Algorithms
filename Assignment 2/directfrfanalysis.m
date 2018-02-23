function [ u ] = directfrfanalysis(EA, EI, rhoA, N_files, ohm)
%This function computes the frequency response of a forcing function at
%point Xp,Yp, with rayleigh famping C = 10M at the point (3,0). It does
%this for each mesh and then plots the response. 
figure
hold on
u = zeros([ohm+1,N_files]);
for i = 1:N_files
    run(['Mesh' num2str(i) '.m'])
    coords = [X;Y]';
    connec = NOD;
    connec_dof = reshape(1:3*size(coords,1),3,[])';
    [K, M]= assembly(X,Y,coords, connec, connec_dof, EA, EI, rhoA);
    K = K(dof_active, dof_active);
    M = M(dof_active, dof_active);
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

    for freq = 0:ohm
        A = K - ((2*pi*freq)^2)*M + 1i*2*pi*freq*C;
        %Au = f
        u0 = A\f;
        u(freq+1,i) = u0(reduced_index);
    end
    
end
plot(abs(u),'LineWidth',3)
set(gca,'yscale','log')
title('Transverse frequency response at (x,y) = (3,0)m','interpreter','latex')
xlabel('Frequency (Hz)' ,'interpreter','latex')
ylabel('Displacement Response' ,'interpreter','latex')
legend('iteration 1','iteration 2','iteration 3','iteration 4')
text(0,0,'$$ (K - \Ohm^2M + \Ohm j C)u_0 = f_0$$','Interpreter','latex')
hold off
end


%Statistical Test for the c paramater
%The approach taken is to repeatedly apply simulated annealing for various 
%parameters values of c and look at the histograms of the objctive function
%values for each parameter. 

if statistical_test == 1
    %Determine the value of c by looking at the histograms
    data = zeros(length(c), M);
    for i = 1: length(c)
        for j = 1:M
            [minf, argmin, x] = SA(x0, xu, xl, epsilon, maxiter, Tstart, c(i),@bump );
            data(i,j) = minf(length(minf));
        end
        
    end
    figure
    hold on
    hist(data')
    title('Histogram of post optimization objective function values','interpreter','latex')
    legend(cellstr(num2str(c', 'N=%-d')))
    xlabel('Objective function value' ,'interpreter','latex')
    ylabel('frequency' ,'interpreter','latex')
    hold off
end
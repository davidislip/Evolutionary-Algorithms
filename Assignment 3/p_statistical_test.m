%Statistical test  comparing the minimum objective function values obtained
%for the direct penalty and the quadratic penalty with various parameters

if statistical_test == 1
    decisionvectors = zeros(length(P)+1, M, length(x_best));
    data = zeros(length(P)+1, M, maxiter);
    for j = 1:M
        quad = 0;
        [minf, argmin, x,d] = SA(A0, Au, Al, epsilon, maxiter, Tstart, c,@trussweight );
        [finalweight, isvalid] = trussweight(argmin');
        data(1,j,:) = minf;
        decisionvectors(1,j,:) = argmin;
        if isvalid == 0
            data(1,j,:) = NaN(maxiter,1);
        end
        
        quad = 1;
        rho = P(1);
        [minf, argmin, x,d] = SA(A0, Au, Al, epsilon, maxiter, Tstart, c,@trussweight );
        [finalweight, isvalid] = trussweight(argmin');
        data(2,j,:) = minf;
        decisionvectors(2,j,:) = argmin;
        if isvalid == 0
            data(2,j,:) = NaN(maxiter,1);
        end
        
        rho = P(2);
        [minf, argmin, x,d] = SA(A0, Au, Al, epsilon, maxiter, Tstart, c,@trussweight );
        [finalweight, isvalid] = trussweight(argmin');
        data(3,j,:) = minf;
        decisionvectors(3,j,:) = argmin;
        if isvalid == 0
            data(3,j,:) = NaN(maxiter,1);
        end
        
        rho = P(3);
        [minf, argmin, x,d] = SA(A0, Au, Al, epsilon, maxiter, Tstart, c,@trussweight );
        [finalweight, isvalid] = trussweight(argmin');
        data(4,j,:) = minf;
        decisionvectors(4,j,:) = argmin;
        if isvalid == 0
            data(4,j,:) = NaN(maxiter,1);
        end
        
        rho = P(4);
        [minf, argmin, x,d] = SA(A0, Au, Al, epsilon, maxiter, Tstart, c,@trussweight );
        [finalweight, isvalid] = trussweight(argmin');
        data(5,j,:) = minf;
        decisionvectors(5,j,:) = argmin;
        if isvalid == 0
            data(5,j,:) = NaN(maxiter,1);
        end
    end
end
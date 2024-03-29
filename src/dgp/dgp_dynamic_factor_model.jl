"""
This function generates a simulated sample from the dynamic linear factor model.
"""
function dgp_dynamic(_beta=Nothing,
                     _error_var=Nothing,
                     _theta=Nothing,
                     _T = 100, 
                     _m = Nothing, 
                     _k = Nothing;
                     beta = _beta, error_var = _error_var, theta = _theta, T = _T, m = _m, k = _k)

    if beta == Nothing
        beta = [1 0 0;
                0.45 1 0;
                0 0.34 1;
                0.99 0 0;
                0.99 0 0;
                0 0.95 0;
                0 0.95 0;
                0.56 0 0.90;
                0 0 0.90]
        m = size(beta,1)
        k = size(beta,2)
    end
    if error_var == Nothing
        error_var = Diagonal([0.02; 0.19; 0.36; 0.02; 0.02; 0.19; 0.19; 0.36; 0.36])
    end
    if theta == Nothing
        theta = [0.5; 0; -0.2]
    end
    factor = zeros(T, k)
    for j = 2:T
        factor[j,:] = theta .* factor[j-1,:] + randn(k)
    end
    X = factor * beta' + randn(T, m) * Matrix(cholesky(error_var).U)
    return X, factor
end

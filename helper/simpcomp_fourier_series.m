function [coefficients]=simpcomp_fourier_series(f,p,n,M,custom)
% INPUT f function
%       p period
%       n order of the Fourier series
%       M the number of subspaces on which integrate with the simpson
%       formula
% OUTPUT coefficients of the truncated Fourier series
%        first  the coefficient  of the constant function
%        second the coefficients of k   cosine   functions
%        third  the coefficients of k   sine     functions

% Coefficient of the constant function


if custom == 1
    coefficients = zeros(1,2*n+1);
    coefficients(1)=(1/p)*simpcomp(0,p,M,f);
        % Coefficients of the cosine functions
    for j=1:n
        % j is the ``order'' of the cosine function
        f_cos=@(x)f(x).*cos(j*(2*pi/p)*x);
        coefficients(1+j)=(2/p)*simpcomp(0,p,M,f_cos);
    end
    
    % Coefficients of the sine functions
    for j=1:n
        % j is the ``order'' of the cosine function
        f_sin=@(x)f(x).*sin(j*(2*pi/p)*x);
        coefficients(n+1+j)=(2/p)*simpcomp(0,p,M,f_sin);
    end
    
return

end
M = max(100,M);
coefficients = zeros(1,2*n+1);
coefficients(1)=(1/p)*simpcomp(0,p,M,f);
% Coefficients of the cosine functions
for j=1:n
    % j is the ``order'' of the cosine function
    f_cos=@(x)f(x).*cos(j*(2*pi/p)*x);
    coefficients(1+j)=(2/p)*simpcomp(0,p,j*M,f_cos);
end

% Coefficients of the sine functions
for j=1:n
    % j is the ``order'' of the cosine function
    f_sin=@(x)f(x).*sin(j*(2*pi/p)*x);
    coefficients(n+1+j)=(2/p)*simpcomp(0,p,j*M,f_sin);
end
return

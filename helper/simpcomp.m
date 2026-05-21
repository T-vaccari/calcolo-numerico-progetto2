function I = simpcomp( a, b, M, f )
%
%    I = simpcomp( a, b, M, f )
%
% Formula di Simpson composita: 
% Inputs:
%    a,b: estremi di integrazione,
%    M: numero di sottointervalli (m=1 formula di integrazione semplice)
%    f: funzione
% Output:
%    I: integrale calcolato

h = ( b - a ) / M; % ampiezza dei sottointervalli
xestr = [ a : h : b ];               % estremi dei sottointervalli
xmed = [ a + h / 2: h : b - h / 2 ]; % punti medi dei sottointervalli

yestr = f(xestr);
ymed = f(xmed);

% Mi serve la valutazione di F sui punti medi ed estremali

I = ( h / 6 ) * ( sum(yestr(1:end-1) ) + 4*sum( ymed ) + sum( yestr(2:end) ) );
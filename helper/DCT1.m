function C = DCT1(valori_funzione, numero_di_valori)
%DCT1 Calcola la trasformata discreta del coseno 1D.
%
%   C = DCT1(valori_funzione, numero_di_valori)
%
%   Calcola i coefficienti DCT 1D del vettore dei valori campionati
%   della funzione. La trasformata viene calcolata come prodotto
%   matrice-vettore:
%
%       C = D * valori_funzione
%
%   dove D è la matrice DCT ortonormale costruita da compute_D.
%
%   INPUT:
%       valori_funzione    vettore contenente i valori campionati della
%                          funzione nei nodi/midpoint considerati.
%
%       numero_di_valori   numero di campioni della funzione. Deve
%                          coincidere con length(valori_funzione).
%
%   OUTPUT:
%       C                  vettore dei coefficienti DCT. Ogni coefficiente
%                          C(k) misura il contributo della corrispondente
%                          frequenza-coseno nel vettore dei dati.
%
%   NOTA:
%       Se D è ortonormale, l'inversa della DCT si ottiene con:
%
%           valori_funzione = D' * C
%
%       perché per una matrice ortogonale vale:
%
%           D^(-1) = D'

arguments
    valori_funzione double {mustBeVector}
    numero_di_valori (1,1) double {mustBeInteger, mustBePositive}
end

% Porto i valori in forma colonna, così il prodotto D * valori_funzione
% è ben definito.
valori_funzione = valori_funzione(:);

% Controllo di coerenza tra numero dichiarato di valori e dimensione reale
% del vettore in input.
if length(valori_funzione) ~= numero_di_valori
    error('DCT1:DimensionMismatch', ...
          'numero_di_valori deve coincidere con length(valori_funzione).');
end

% Costruisco la matrice DCT ortonormale di dimensione N x N.
D = compute_D(numero_di_valori);

% Calcolo i coefficienti DCT come cambio di base:
% dai valori nei punti alle coordinate nella base dei coseni.
C = D * valori_funzione;

end
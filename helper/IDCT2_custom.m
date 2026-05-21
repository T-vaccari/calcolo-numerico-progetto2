function [funzione] = IDCT2_custom(coefficienti_funzione, righe, colonne)
%IDCT2_CUSTOM Calcola la trasformata inversa discreta del coseno 2D.
%
%   funzione = IDCT2_custom(coefficienti_funzione, righe, colonne)
%
%   Ricostruisce la matrice dei valori originali a partire dalla matrice
%   dei coefficienti DCT2.
%
%   INPUT:
%       coefficienti_funzione : matrice righe x colonne contenente i
%                               coefficienti DCT2 della funzione/immagine.
%
%       righe                 : numero di righe della matrice originale.
%
%       colonne               : numero di colonne della matrice originale.
%
%   OUTPUT:
%       funzione              : matrice ricostruita nello spazio dei valori.
%
%   IDEA MATEMATICA:
%       Se la DCT2 diretta è:
%
%           C = D_col * F * D_rig'
%
%       allora, poiché le matrici DCT sono ortonormali:
%
%           D_col^(-1) = D_col'
%           D_rig^(-1) = D_rig'
%
%       l'inversa è:
%
%           F = D_col' * C * D_rig
%
%       Nel codice:
%           - prima si annulla il passaggio lungo le righe;
%           - poi si annulla il passaggio lungo le colonne.

arguments (Input)
    coefficienti_funzione
    righe
    colonne
end

arguments (Output)
    funzione
end

% Matrice inversa per la direzione verticale: agisce sulle colonne
D_per_colonne = compute_D(righe)';

% Matrice inversa della trasposta usata lungo le righe
D_per_righe = compute_D(colonne)';

% Primo passaggio: IDCT lungo le righe
Y = coefficienti_funzione * D_per_righe';

% Secondo passaggio: IDCT lungo le colonne
funzione = D_per_colonne * Y;

end
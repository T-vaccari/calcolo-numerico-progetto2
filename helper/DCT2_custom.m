function [C] = DCT2_custom(valori_funzione, righe, colonne)
%DCT2 Calcola la trasformata discreta del coseno 2D.
%
%   C = DCT2(valori_funzione, righe, colonne)
%
%   Calcola la DCT bidimensionale di una matrice di valori campionati,
%   applicando la DCT 1D prima lungo le colonne e poi lungo le righe.
%
%   INPUT:
%       valori_funzione : matrice di dimensione righe x colonne.
%                         Rappresenta i valori campionati della funzione
%                         2D, oppure i valori di grigio di un'immagine.
%
%       righe           : numero di righe della matrice valori_funzione.
%
%       colonne         : numero di colonne della matrice valori_funzione.
%
%   OUTPUT:
%       C               : matrice dei coefficienti DCT 2D.
%                         L'elemento C(k,l) rappresenta il contributo
%                         della frequenza verticale k e della frequenza
%                         orizzontale l.
%
%   IDEA MATEMATICA:
%       Se F è la matrice dei dati, la DCT2 viene calcolata come:
%
%           C = D_righe * F * D_colonne'
%
%       dove:
%           D_righe    è la matrice DCT associata alla direzione verticale;
%           D_colonne  è la matrice DCT associata alla direzione orizzontale.
%
%       Il primo prodotto:
%
%           Y = D_righe * F
%
%       applica la DCT 1D a ogni colonna di F.
%
%       Il secondo prodotto:
%
%           C = Y * D_colonne'
%
%       applica la DCT 1D a ogni riga della matrice intermedia Y.
%
%   NOTA:
%       Se compute_D costruisce una matrice DCT ortonormale, allora
%       l'inversa della DCT2 è:
%
%           F = D_righe' * C * D_colonne

arguments (Input)
    valori_funzione
    righe
    colonne
end

arguments (Output)
    C
end

% Matrice DCT per la direzione verticale: agisce sulle colonne
D_per_colonne = compute_D(righe);    

% Matrice DCT per la direzione orizzontale: agisce sulle righe
D_per_righe = compute_D(colonne);    

% Primo passaggio: DCT lungo le colonne
Y = D_per_colonne * valori_funzione;

% Secondo passaggio: DCT lungo le righe della matrice trasformata
C = Y * D_per_righe';

end
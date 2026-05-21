clear;clc;close all;
addpath("helper");

% Scrivere una funzione Matlab che esegua i seguenti task:
% • permettere all'utente di selezionare:
% – un'immagine .jpg in toni di grigio presente nel filesystem
% – un intero F che sar`a l'ampiezza dei macro-blocchi in cui si eﬀettuer`a la DCT2
% (F deve essere compatibile con la dimensione dell'immagine);
% – un intero dcompreso tra 0 e (2F−2) che sar`a la soglia di taglio delle frequenze
% (vedi sotto).
% • suddividere l'immagine in blocchi quadrati f di pixel di dimensioni F×F partendo
% in alto a sinistra, scartando gli avanzi;
% • per ogni blocco f eseguire le seguenti operazioni:
% – applicare la DCT2 : c = DCT2(f);
% – eliminare le frequenze ckℓ con k+ℓ≥d(sto assumendo che le frequenze partano
% da 0: se d= 0 le elimino tutte, se d= (2F−2) elimino solo la pi`u alta, cio`e
% quella con k= F−1, ℓ= F−1). In sostanza si eliminano i coeﬃcienti in
% frequenza a destra della diagonale individuata da d, come esemplificato qui
% sotto per F = 10 e d= 7 (i coeﬃcienti da eliminare sono indicati in rosso):


%% Task 1
%
% Applicare il precedente algoritmo all'immagine uma.jpg con F = 19 e d = 6.
% Caricare l'immagine compressa ottenuta con il troncamento dell frequenze prece-
% dentemente descritto in formato .jpg o .png.
F = 19;
d = 6;
path = "immagini/uma.jpg";
immageCompression(path,F,d);

%% Task 2
%
% Applicare il precedente algoritmo all'immagine deer.jpg con F = 82 e d = 14 .
% Caricare l'immagine compressa ottenuta in formato .jpg o .png.
F = 82;
d = 14;
path = "immagini/deer.jpg";
immageCompression(path,F,d);
%% Task 3
% Applicare il precedente algoritmo all'immagine checker.jpg con F = 50 e d = 2.
% Caricare l'immagine compressa ottenuta in formato .jpg o .png.
F = 50;
d = 2;
path = "immagini/checkerboard.jpg";
immageCompression(path,F,d);

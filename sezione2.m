clc;clear;close all;
addpath("helper");
%% Introduzione al problema e dati

% Si considerino f,g : [0,1] → R tali che f(x) = sign(x−1/2 ) e g(x) = x(1−x) e^(2x)
% Considerare un campionamento di N = 100 punti sull'intervallo [0,1] (ossia le funzioni
% sono approssimate come costanti a tratti su 100 sottointervalli di uguale ampiezza).

% Definisco le funzioni
funzione1 = @(x) sign(x - 0.5);
funzione2 = @(x) x .* (1-x) .* (exp(2 .* x));



% plot(midPoints,valoriFunzione1,midPoints,valoriFunzione2);

%% Punto 1

% Utilizzando le funzioni matlab viste a laboratorio, calcolare la DCT dei vettori fe g
% tali che le componenti i-esime sono fi = f(2i−1/2N ) e gi = g(2i−1/2N ) per ogni 1 ≤i≤N.
% Riportare i coeﬃcienti c1 e ξ1 dei vettori c= Df e ξ= Dg dove D `e la matrice
% corrispondente alla DCT monodimensionale.

% Quello che sto facendo è prendere dei sampling, assumere che la funzione
% sia periodica facendo riflessione e ottenendo simmetria pari, noto che è
% ora è pari, espando in soli coseni, e quindi mi bastano gli N punti che
% ho già, presi come midpoint degli N intervalli

% Creo gli intervalli equispaziati su [0,1], qua ho gli estremi
x = linspace(0,1,101);

% Calcolo i punti medi in cui valutare le funzioni
midPoints = zeros(1, size(x, 2) - 1); 
valoriFunzione1 = zeros(1, size(x, 2) - 1); 
valoriFunzione2 = zeros(1, size(x, 2) - 1); 
for i= 1:size(x,2)-1
    midPoints(i) = (x(i) + x(i+1)) / 2; % Calcolo del punto medio
    valoriFunzione1(i) = funzione1(midPoints(i)); % Valutazione della prima funzione
    valoriFunzione2(i) = funzione2(midPoints(i)); % Valutazione della seconda funzione
end

% Ora devo calcolare i coefficienti rispetto alla base discreta di
% frequenze nei coseni

N = size(midPoints, 2); % Number of sampling points
D = compute_D(N);

% Calcolo della DCT delle funzioni campionate
c = D * valoriFunzione1'; % Coefficienti DCT per funzione1
xi = D * valoriFunzione2'; % Coefficienti DCT per funzione2

% plotto c1 e ξ1
c1 = c(1) % Primo coefficiente DCT per funzione1
xi1 = xi(1) % Primo coefficiente DCT per funzione2

%% Punto 2
% Si pongano a zero le ultime 60 componenti del vettore ξ, ovvero ξj = 0 per ogni j
% tale che 41 ≤j ≤100. In questo modo si ottiene una DCT troncata (equivalente ad
% una compressione dell'informazione originaria). SI applichi la IDCT (trasformata
% inversa) per ottenere g= D−1ξ. Calcolare e riportare il massimo della diﬀerenza
% tra ge gossia max1≤i≤100 |gi−gi|. 

% Ricordo che essendo D matrice ortonormale l'inversa è la trasposta

xi(41:100) = 0; % Set the last 60 components of xi to zero
funzione2_ricostruita = D' * xi; % Apply the inverse DCT to obtain g
maxDiff = max(abs(funzione2_ricostruita - valoriFunzione2'),[],"all") % Calculate the maximum difference

%% Punto 3
% Implementare la DCT2 come spiegata a lezione (applicazione della DCT1 prima per
% colonne e poi per righe) e confrontare i tempi di esecuzione con la DCT2 built-in di
% Matlab nella versione fast (FFT). In particolare, procurarsi array quadrati N ×N con
% N crescente e rappresentare su un grafico in scala semilogaritmica (solo le ordinate)
% al variare di N il tempo impiegato ad eseguire la DCT2 con l'algoritmo house-made
% e con l'algoritmo dct2 di Matlab. Riportare il grafico ottenuto in formato .png.

% Check sulla DCT 1d
% format short e
% f = [
% 231;
% 32;
% 233;
% 161;
% 24;
% 71;
% 140;
% 245;
% ];

%Devo provare 

format short e

% Matrice di test
F = [
    231  32 233 161  24  71 140 245;
    247  40 248 245 124 204  36 107;
    234 202 245 167   9 217 239 173;
    193 190 100 167  43 180   8  70;
     11  24 210 177  81 243   8 112;
     97 195 203  47 125 114 165 181;
    193  70 174 167  41  30 127 245;
     87 149  57 192  65 129 178 228
];

% Risultato atteso dalla traccia
C_atteso = [
    1.11e+03   4.40e+01   7.59e+01  -1.38e+02   3.50e+00   1.22e+02   1.95e+02  -1.01e+02;
    7.71e+01   1.14e+02  -2.18e+01   4.13e+01   8.77e+00   9.90e+01   1.38e+02   1.09e+01;
    4.48e+01  -6.27e+01   1.11e+02  -7.63e+01   1.24e+02   9.55e+01  -3.98e+01   5.85e+01;
   -6.99e+01  -4.02e+01  -2.34e+01  -7.67e+01   2.66e+01  -3.68e+01   6.61e+01   1.25e+02;
   -1.09e+02  -4.33e+01  -5.55e+01   8.17e+00   3.02e+01  -2.86e+01   2.44e+00  -9.41e+01;
   -5.38e+00   5.66e+01   1.73e+02  -3.54e+01   3.23e+01   3.34e+01  -5.81e+01   1.90e+01;
    7.88e+01  -6.45e+01   1.18e+02  -1.50e+01  -1.37e+02  -3.06e+01  -1.05e+02   3.98e+01;
    1.97e+01  -7.81e+01   9.72e-01  -7.23e+01  -2.15e+01   8.13e+01   6.37e+01   5.90e+00
];

righe = size(F, 1);
colonne = size(F, 2);

% Chiamo funzione
C = DCT2_custom(F, righe, colonne);

% disp('DCT2 calcolata:')
% disp(C)
% 
% disp('DCT2 attesa:')
% disp(C_atteso)

% Errore massimo elemento per elemento
% err_max = max(abs(C(:) - C_atteso(:)));
% 
% fprintf('Errore massimo = %.3e\n', err_max);
% 
% tol =  1e1;;
% 
% if err_max < tol
%     fprintf('Test superato.\n');
% else
%     fprintf('Test NON superato.\n');
% end




% Devo valutare le performance delle due funzioni, quindi creo vettori con
% NxN con N crescente, valuto le performnace e faccio record delle
% performance

N_values = [16 32 50 64 100 128 200 256 300 400 512 600 700 800 900 1024 1500 2048];
% Inizializzo i vettori per registrare i tempi di esecuzione
timeCustom = zeros(size(N_values));
timeBuiltIn = zeros(size(N_values));


for i = 1:size(N_values,2)
    arr = randn(N_values(i),N_values(i));

    tic
    C = DCT2_custom(arr,N_values(i),N_values(i));
    timeCustom(i) = toc;

    tic
    C = dct2(arr);
    timeBuiltIn(i) = toc;
    
end

semilogy(N_values,timeBuiltIn,'g-*',N_values,timeCustom,'r-x','LineWidth',1.5);
legend('dct2 MATLAB built-in','DCT2 custom','Location','northwest');
xlabel('N');
ylabel('Tempo di esecuzione [s]');
title('Confronto tempi DCT2 custom vs dct2 MATLAB');
grid on;



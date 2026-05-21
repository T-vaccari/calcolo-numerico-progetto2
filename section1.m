clear;clc;close all;
addpath("helper");
%% Introduzione al problema e dati
% Mi vengono fornite tre funzioni periodiche di periodo P(di natura non
% sono periodiche ma vengono rese tali).
funzione1 = @(x) x;
funzione2 = @(x) x .* (1 - x);
funzione3 = @(x) x .* (1 - x) .* exp(10 .* x);


% Considero funzioneN_app con n = 1, 2, 3 come le funzioni ottenute
% approssimando tramite espansione in serie di fourier con M = 15, quindi
% fino a frequenza 15. Ho una base di 2*M + 1 termini, ovvero 31
p = 1;  % Periodo
n = 15; %Frequenza massima

 
%% Punto 1

% Devo approssimare la funzione 1 usando metodo di quadratura di simpson.
% Calcolare l'approssimazione f1. Per il calcolo dei coeﬃcienti 
% dell'espansione utiliz-
% zare la formula di quadratura di Simpson composita con un 
% numero opportuno di
% sottointervalli. Calcolare e riportare l'errore: maxx∈[0,1] |f1(x)−f1(x)|.

% Implemento la funzione simcomp_fourier_series.m che calcola i coefficienti della
% serie di fourier troncata su periodo dato usando pero la formula di
% quadratura di simpson. Ricordo che oltre alla formula di quadratura per
% miglioare approssimazione posso scegliere anche di lavorare con formule
% composite, ovvero di approssimare l'integrale come sommatoria di
% quadratura su sottointervalli. Ricordo che usando approssimazione di
% simpson composita ottengo un errore di ordine 4 rispetto a H che sarebbe
% la larghezza del sottointervallo su cui avviene la quadratura.

% Dal momento che per calcolare numericamente l'integrale uso simpson come
% metodo di quadratura, e so che ha esattezza polinomiale 3, ovvero posso
% approssimare esattamente fino a polinomi di grado 3.
% Devo scegliere un M che mi permetta di integrare bene anche armoniche
% alte fino a frequenza 15. 

% Calcolo i coefficienti dell'espansione di fourier di f1
M = 15;
coeff_fourier_1 = simpcomp_fourier_series(funzione1,p,n,M,0);


% A questo punto posso valutare f su un intervallo usando l'espressione
% vera ed usando i coefficienti dell'espansione di fourier
x = linspace(0,p,1000);
Y_reale_1 = funzione1(x);

% Devo calcolare pointwise il valore dell'approssimazione

Y_approx_1 = coeff_fourier_1(1);

%Considero il contributo dei termini coseno e seno
for k = 1:n
    ak = coeff_fourier_1(1 + k);
    bk = coeff_fourier_1(1 + n + k);

    Y_approx_1 = Y_approx_1 + ak * cos((2*pi*k/p) * x) + bk * sin((2*pi*k/p) * x);
end


%Calcolo l'errore sull'intervallo
% definito come il max della differenza

errore_funzione_1 = max(abs(Y_reale_1-Y_approx_1))

%% Punto 2
% Recupero il vettore dei coefficienti del coseno dell'espansione troncata
% Nel primo slot ho A0, quindi prendo da A1 fino ad A15
coeff_coseno_1 = coeff_fourier_1(2:n+1);
% Calcolo la norma di tale vettore dei coefficienti. 
% La funzione di partenza è y = x periodicizzata sull'intervallo [0,1] cosa
% posso dire di questa funzione? Non è ne pari ne dispari,. Ha davvero
% poca componente spettrale sul coseno

norm_coeff_cos_1 = norm(coeff_coseno_1)

%% Punto 3

% Calcolare l'approssimazione f2. Per il calcolo dei coeﬃcienti dell'espansione utiliz-
% zare la formula di quadratura di Simpson composita con un numero opportuno di
% sottointervalli. Calcolare e riportare l'errore: maxx∈[0,1] |f2(x)−f2(x)|.

M = 30;
coeff_fourier_2 = simpcomp_fourier_series(funzione2,p,n,M,0);

x = linspace(0,p,1000);
Y_reale_2 = funzione2(x);

Y_approx_2 = coeff_fourier_2(1);

for k = 1:n
    ak = coeff_fourier_2(1 + k);
    bk = coeff_fourier_2(1 + n + k);

    Y_approx_2 = Y_approx_2 + ak * cos((2*pi*k/p) * x) + bk * sin((2*pi*k/p) * x);
end

errore_funzione2 = max(abs(Y_reale_2-Y_approx_2))

%% Punto 4

% Riportare la norma del vettore b= {bk}1≤k≤15, dove bk `e il coeﬃciente dell'espan-
% sione troncata f2 relativo alla funzione di base sk(x) = sin(2kπx). Commentare i
% risultati ottenuti. [voto: 0.2/30]

% Recupero il vettore dei coefficienti del seno dell'espansione troncata
coeff_seno_2 = coeff_fourier_2(n+2:end);

% Calcolo la norma del vettore dei coefficienti del seno
norm_coeff_seno_2 = norm(coeff_seno_2)

%% Punto 5

% Calcolare l'approssimazione f3. Per il calcolo dei coeﬃcienti utilizzare la formula
% di quadratura di Simpson composita prima con 10 sottointervalli e poi con 100
% sottointervalli. Disegnare sullo stesso grafico la funzione f3 e le approssimazioni
% cos`ı ottenute. Caricare l'immagine ottenuta in formato .png.



x = linspace(0,p,1000);
Y_reale_3 = funzione3(x);

M = 10;
coeff_fourier_3_M10 = simpcomp_fourier_series(funzione3,p,n,M,1);

Y_approx_3_M10 = coeff_fourier_3_M10(1);

for k = 1:n
    ak = coeff_fourier_3_M10(1 + k);
    bk = coeff_fourier_3_M10(1 + n + k);

    Y_approx_3_M10 = Y_approx_3_M10 + ak * cos((2*pi*k/p) * x) + bk * sin((2*pi*k/p) * x);
end


M = 100;
coeff_fourier_3_M100 = simpcomp_fourier_series(funzione3,p,n,M,1);

Y_approx_3_M100 = coeff_fourier_3_M100(1);

for k = 1:n
    ak = coeff_fourier_3_M100(1 + k);
    bk = coeff_fourier_3_M100(1 + n + k);

    Y_approx_3_M100 = Y_approx_3_M100 + ak * cos((2*pi*k/p) * x) + bk * sin((2*pi*k/p) * x);
end

% Plotto le due approssimazioni
plot(x,Y_reale_3,'g-',x,Y_approx_3_M10,'b--',x,Y_approx_3_M100,'r-.','LineWidth', 1.8);
% Aggiungo le etichette e il titolo al grafico
xlabel('x');
ylabel('Funzione e Approssimazioni');
title('Diverse approssimazioni di f3 con Simpson Composito');
legend('f3', 'Approssimazione M=10', 'Approssimazione M=100');
grid on;

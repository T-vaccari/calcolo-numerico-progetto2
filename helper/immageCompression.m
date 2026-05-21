function [] = immageCompression(pathToImmage, F, d)
%IMMAGECOMPRESSION Legge Immagine, la comprime su blocchi FxF di un fattore
%   D e la ricostruisce, mostrandola poi affiancata all'originale
%   pathTomImmage fa riferimento al percorso relativo, dell'immagine a
%   partire dalla cartella in cui si trova questa funzione, in modo tale da
%   poterla importare nel codice.
%   

arguments (Input)
    pathToImmage
    F
    d
    
end

% Il primo step è aprire immagini in jpeg in matlab
img = imread(pathToImmage);
immagine = double(img);



% Devo verificare che F sia compatibile con la dimensione dell'immagine,
% ovvero deve essere minore o uguale alle dimensioni dell'immagine

if F > size(immagine,1) || F > size(immagine,2)
    error('F must be less than or equal to the dimensions of the image.');
end

if d <0 || d > (2*F-2)
    error('d must be between 0 and %d.', 2*F-2);
end

% Ora devo scegliere quanti quadrati ci stanno in lunghezza e larghezza
[numRows, numCols, ~] = size(immagine);
numBlocksRow = floor(numRows / F);
numBlocksCol = floor(numCols / F);

%Preparo blocco per immagine compressa
compressed = zeros(F*numBlocksRow,numBlocksCol*F);
original_cropped = img(1:F*numBlocksRow, 1:F*numBlocksCol);
for i= 1 : numBlocksRow
     for j  = 1 :numBlocksCol
         %Prendo il blocco da passare in coordinate di frequenza
         block = immagine((i-1)*F+1:i*F,(j-1)*F+1:j*F);
         %Effettuo il calcolo dei coefficienti
         compressed_block = DCT2_custom(block,F,F);
         %Effettuo la compressione con il fattore D, ovvero tutti gli
         %elementi a sotto la diagonale d, ovvero se d = 7, prendo la
         %diagonale che passa per 7 e non considero tutti gli elementi
         %sotto tale diagonale, posso usare matrice tril 
         
        for k = 1:F
            for l = 1:F
                if k + l >= d + 2
                    compressed_block(k,l) = 0;
                end
            end
        end
        % Applico trasformata inversa ai coefficienti C, ovvero devo
        % ricostruire il blocco originale

         reconstructed_block = IDCT2_custom(compressed_block, F , F);
        
         %Arrotondo ad intero più vicino

         reconstructed_block = round(reconstructed_block);

         %Devo clampare a 0 i negativ
         % Devo cappare a 255

         reconstructed_block = clip(reconstructed_block, 0, 255);
         %Riposiziono il blocco
         compressed((i-1)*F+1:i*F,(j-1)*F+1:j*F) = reconstructed_block;

     end
end

% Visualizza l'immagine compressa
figure;

subplot(1,2,1);
imshow(original_cropped);
title('Immagine originale');

subplot(1,2,2);
imshow(uint8(compressed));
title("Immagine ricostruita dalla versione compressa (F = " + F + ", d = " + d + ")");

% Il guadagno sta nel poi salvare in memoria la versione compressa

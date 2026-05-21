# Progetto 2 - Calcolo Numerico in MATLAB

Repository del secondo progetto MATLAB su serie di Fourier, DCT monodimensionale e bidimensionale, e compressione di immagini tramite troncamento dei coefficienti DCT.

## Contenuto

- `section1.m`: approssimazione tramite serie di Fourier troncate e Simpson composito.
- `sezione2.m`: DCT 1D, ricostruzione tramite IDCT e confronto prestazionale tra DCT2 custom e `dct2` MATLAB.
- `section3.m`: compressione di immagini a blocchi tramite DCT2 custom.
- `helper/`: funzioni di supporto per quadratura, serie di Fourier, DCT e compressione.
- `risultati/`: grafici e immagini compresse ottenute.

Le immagini di input e il testo originale della consegna sono conservati soltanto in locale e non fanno parte del repository pubblico.

## Per runnare

Aprire MATLAB nella root della repository ed eseguire le sezioni separatamente:

```matlab
section1
sezione2
section3
```

La sezione 2 usa `dct2`, quindi richiede installato Image Processing Toolbox per il confronto con la funzione built-in MATLAB.

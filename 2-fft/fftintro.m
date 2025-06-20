% Workspace zurücksetzen
clear all;
close all;
clc;

% Diskrete Fourier Transformation DFT (diskete Datenpunkte, keine stetige
% Funktion als Input)
% => Zerlegung einer komplexen Funktion in die Überlagerung verschiedener
% periodischer Funktionen unterschiedlicher Frequenzen
% => Welche Frequenzen sind enthalten und wie dominant sind sie jeweils?
% => DFT wird bei hoher Sample-Zahl N langsam, deshalb schnellere FFT

% Erzeugung eines Zeitsignals
fs = 40; % Abtastfrequenz (sampling frequency) in Hz
T = 1 / fs; % Periodendauer 
N = 40; % Anzahl an Messpunkten
t = (0:N-1) * T; % Zeitvektor
Xn = sin(2*pi*3*t); % 3-Hz-Signal
plot(t, Xn, '.-', 'MarkerSize', 20);
title('Zeitsignal');
xlabel('t');
ylabel('Xn(t)');

% Erstellung der FFT
Y = fft(Xn);
% Stammdiagramm des Ergebnisses
figure;
stem(abs(Y));
title('Absolutwert der FFT von Xn');
% Stammdiagramm des Ergebnisses ohne symmetrische Nyquist-Frequenz
figure;
stem(abs(Y(1:(N/2)+1)));
title('Absolutwert der FFT von Xn ohne Nyquist');
% Stammdiagramm des Ergebnisses nach Frequenz
figure;
k = 0:N/2; % Laufindex: startet bei 0 --> Länge von k: N/2+1
freq = k*fs/N; % Zyklen pro Länge des Signals
stem(freq, abs(Y(1:(N/2)+1)));
title('Absolutwert der FFT von Xn nach Frequenz');
xlabel('Frequenz (Hz');
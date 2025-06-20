% Workspace zurücksetzen
clear all;
close all;
clc;

% Rohdaten einlesen
x = [492.5 365.0 245.0 182.5 167.5 205.0 287.5 395 500.0 582.5 620.0 607.5 ...
    562.5 505.0 455.0 430.0 437.5 477.5 555.0 635.0 717.5 775.0 787.5 735.0 ...
    642.5 515.0 390.0 282.5 210.0 182.5 197.5 267.5]; % Absolute Geschwindigkeit
t = 1:0.5:16.5; % Synthetischer Zeitstempel
N = length(x); % Anzahl an Samples
Fs = mean(diff(t)); % Durschnittlicher zeitlicher Samplingabstand
f = (0:N-1) * Fs/N; % Vektor aller Frequenzen; Einteilung der Abzisse

% Rohdaten plotten
figure(1);
plot(t, x, '*--');
grid('on');
title('Rohdaten');
xlabel('Zeit (s)');
ylabel('Distanz (mm');

% Fast-Fourier-Transformation
X = fft(x); % --> komplexe Zahlen
X_norm = 1/N * X; % Normiert auf die Anzahl der Datenpunkte

% Plot des Amplituden- und Phasenspektrums
figure(2);
subplot(1, 2, 1);
title('Amplitude nach Frequenz der FFT')
stem(f, abs(X_norm), '*', 'LineWidth', 2);
xlabel('Frequenz (Hz)');
ylabel('Amplitude');
grid('on');
subplot(1, 2, 2);
title('Phasenwinkel nach Frequenz der FFT')
% Bis zur Nyquist-Frequnz erhalten wir sinnvolle Werte, darüber hinaus
% erhalten wir die negativen Frequenzen (gespiegelt mit neg. Vorzeichen)
stem(f, angle(X_norm), '*', 'LineWidth', 2);
xlabel('Frequenz (Hz)');
ylabel('Phasenwinkel');
grid('on');

% Tabelle der Werte generieren
table1 = table(X_norm', f', abs(X_norm)', angle(X_norm)');
table1.Properties.VariableNames = {'FFT-Koeff.', 'Frequenz', 'Amplitude', 'Phase'};
disp(table1);

% Rekonstruktion des Zeitspektrums mit k dominanten Frequenzen mittels
% inverser Fourier-Transformation
X_recon = X;
k = 4; % Behält die ersten k und letzten k Frequenzen
for i = (k+2):(N-k) % behält den 1. Wert (AVG) und die gewählten k
    X_recon(i) =0;
end
x_recon = ifft(X_recon);

% Vergleich mit Rohdaten
figure(3);
plot(t,x,'r-x','LineWidth',2);
hold('on');
grid('on');
plot(t, x_recon, 'b--', 'LineWidth',2);
title('Vergleich rekonstruierte Daten vs. Rohdaten');
xlabel('Zeit (s)');
ylabel('Distanz (mm');
l2 = append(num2str(k), ' FFT dominante Terme');
legend('Rohdaten', l2);

% Einseitige FFT (ohne negative Frequenzen)
k = 0:N/2; % Da wir mit k = 0 starten, beträgt die Länge von k N/2+1
freq = k*Fs/N;
figure(4);
stem(freq, abs(X_norm(1:(N/2)+1)), '*', 'LineWidth', 2);
xlabel('Frequenz (Hz)');
ylabel('Amplitude');
title('Einseitige FFT');
grid("on");
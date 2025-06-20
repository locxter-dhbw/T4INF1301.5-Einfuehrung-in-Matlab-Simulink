% Workspace zurücksetzen
clear all;
close all;
clc;

% Erklärvideos:
% https://www.youtube.com/watch?v=QmgJmh2I3Fw
% https://www.youtube.com/watch?v=pfjiwxhqd1M

%% Rohdaten einlesen

x = [492.5 365.0 245.0 182.5 167.5 205.0 287.5 395 500.0 582.5 620.0 607.5 ...
    562.5 505.0 455.0 430.0 437.5 477.5 555.0 635.0 717.5 775.0 787.5 735.0 ...
    642.5 515.0 390.0 282.5 210.0 182.5 197.5 267.5]; % Absolute Geschwindigkeit
t = 1:0.5:16.5; % Synthetischer Zeitstempel
N = length(x); % Anzahl an Samples
Fs = mean(diff(t)); % Durschnittlicher zeitlicher Samplingabstand
f = (0:N-1) * Fs/N; % Vektor aller Frequenzen; Einteilung der Abzisse

%% Rohdaten plotten

figure(1);
plot(t, x, '*--');
grid('on');
title('Rohdaten');
xlabel('Zeit (s)');
ylabel('Distanz (mm');

%% Fast-Fourier-Transformation durchführen

% FFT und absolute Normierung die auf Anzahl der Datenpunkte
X = 1/N * abs(fft(x));

% Erstellung der einseitige FFT
if mod(N, 2) == 0 % Prüfen, ob N gradzahlig ist
    X = X(1:N/2+1);
    N2 = N/2+1;
else
    X = X(1:N2);
    N2 = ceil(N/2);
end

% Verdopplung der Werte außer 0 Hz und Nyquist
X(2:end-1) = 2 * X(2:end-1);

%% Plot des Amplitudenspektrums

figure(1);
stem(f(2:N2), X(2:end), 'LineWidth', 2); % 0 Hz, d.h. Mittelwert hier unwichtig
xlabel('Frequenz (Hz)');
ylabel('Amplitude');
title('Amplitudenspektrum');
grid('on');

%% Berechnung des Leistungsspektrums

Power = (1/N^2)*abs(fft(x)).^2;

if mod(N, 2) == 0 % Prüfen, ob N gradzahlig ist
    Power = Power(1:N/2+1);
    N2 = N/2+1;
else
    Power = Power(1:N2);
    N2 = ceil(N/2);
end

% Verdopplung der Werte außer 0 Hz und Nyquist
Power(2:end-1) = 2 * Power(2:end-1);

%% Plot des Leistungsspektrums

figure(2);
stem(f(2:N2), Power(2:end), 'LineWidth', 2); % 0 Hz, d.h. Mittelwert hier unwichtig
xlabel('Frequenz (Hz)');
ylabel('Leistung');
title('Leistungsspektrum');
grid('on');

% Leistung in dB (logarithmisch)

figure(3);
stem(f(2:N2), pow2db(Power(2:end)), 'LineWidth', 2); % 0 Hz, d.h. Mittelwert hier unwichtig
xlabel('Frequenz (Hz)');
ylabel('Leistung (db)');
title('Leistungsspektrum in Dezibel');
grid('on');

%% Berechnung der spektralen Leistungsdichte

PSD = (1/(Fs*N))*abs(fft(x)).^2; 

if mod(N, 2) == 0 % Prüfen, ob N gradzahlig ist
    PSD = PSD(1:N/2+1);
    N2 = N/2+1;
else
    PSD = PSD(1:N2);
    N2 = ceil(N/2);
end

% Verdopplung der Werte außer 0 Hz und Nyquist
PSD(2:end-1) = 2 * PSD(2:end-1);

%% Plot des spektralen Leistungsdichte

figure(4);
stem(f(2:N2), pow2db(PSD(2:end)), 'LineWidth', 2); % 0 Hz, d.h. Mittelwert hier unwichtig
xlabel('Frequenz (Hz)');
ylabel('Leistung/Frequenz (db/Hz)');
title('Spektrale Leistungsdichte');
grid('on');
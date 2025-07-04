% Workspace zurücksetzen
clear all;
close all;
clc;

% Daten laden
format('long');
fsample = 2000;
table = readtable('LinkeGehirnHaelfte.csv');
y = table.Var1;
rows = height(y);

% Kennwerte berechnen
mean = mean(y);
median = median(y);
std = std(y);
var = var(y);
min = min(y);
max = max(y);
range = range(y);

% Boxplot erstellen (automatisch mit Median, Min, Max und Range)
figure(1);
hold("on");
title("EEG-Messung");
ylabel("Messwerte");
xlabel("Gehirnhälfte");
boxchart(y);
yline(mean, 'r');
yline(median, 'g');
yline(min, 'y');
yline(max, 'cyan');
legend(["Linke Gehirnhälfte", "Mittelwert", "Median", "Min", "Max"]);

% Histogramm erstellen
figure(2);
hold("on");
title("EEG-Messung");
ylabel("Häufigkeit");
xlabel("Messwerte");
histogram(y);
xline(mean, 'r');
xline(median, 'b');
xline(0, '--');
legend(["Linke Gehirnhälfte", "Mittelwert", "Median", "Nulllinie"]);

% Rohdaten plotten
x = linspace(0, rows/fsample, rows);
figure(3);
hold("on");
title("EEG-Messung");
ylabel("Messwerte");
xlabel("Zeit in s");
plot(x, y);
yline(mean, 'r');
yline(median, 'g');
legend(["Linke Gehirnhälfte", "Mittelwert", "Median"]);

% FFT

% Vektor aller Frequenzen; Einteilung der Abzisse
f = (0:rows-1) * fsample/rows;

% FFT und absolute Normierung die auf Anzahl der Datenpunkte
Y = 1/rows * abs(fft(y));

% Erstellung der einseitige FFT
if mod(rows, 2) == 0 % Prüfen, ob N gradzahlig ist
    Y = Y(1:rows/2+1);
    rows2 = rows/2+1;
else
    Y = Y(1:N2);
    rows2 = ceil(rows/2);
end

% Verdopplung der Werte außer 0 Hz und Nyquist
Y(2:end-1) = 2 * Y(2:end-1);

% Daten abschneiden
% f_cutoff = f(f > 0.2);

% Plot generieren
figure(4);
stem(f(2:rows2), Y(2:end), 'LineWidth', 2); % 0 Hz, d.h. Mittelwert hier unwichtig
xlabel('Frequenz (Hz)');
ylabel('Amplitude');
title('Amplitudenspektrum der EEG-Messung');
grid('on');
xlim([0.3 200]);

% Daten filtern

% Filtervariablen
f_noise = 50;                 % Störfrequenz (z.B. 50 Hz Netzbrummen)
bw = 2;                       % Bandbreite für Notch
order = 4;                    % Filterordnung
fn = fsample / 2;             % Nyquist-Frequenz

% Butterworth Bandstop-Filter (48–52 Hz)
[b1, a1] = butter(order, [(f_noise-bw)/fn, (f_noise+bw)/fn], 'stop');
y_butter = filtfilt(b1, a1, y);

% IIR Notch-Filter (49-51 Hz)
wo = f_noise / fn;
bw_norm = bw / fn;
[b2, a2] = iirnotch(wo, bw_norm);
y_notch = filtfilt(b2, a2, y);

% FFTs berechnen
Y_butter = 1/rows * abs(fft(y_butter));
Y_notch = 1/rows * abs(fft(y_notch));

% Einseitige Spektren erstellen
Y_butter = Y_butter(1:rows2); Y_butter(2:end-1) = 2 * Y_butter(2:end-1);
Y_notch = Y_notch(1:rows2); Y_notch(2:end-1) = 2 * Y_notch(2:end-1);

% FFT-Vergleich plotten
figure(5);
subplot(3,1,1);
stem(f(2:rows2), Y(2:end), 'LineWidth', 2);
xlabel('Frequenz (Hz)');
ylabel('Amplitude');
title('FFT Amplitdenspektrum Rohsignal');
grid('on');
xlim([0.3 200]);
subplot(3,1,2);
stem(f(2:rows2), Y_butter(2:end), 'r', 'LineWidth', 2);
xlabel('Frequenz (Hz)');
ylabel('Amplitude');
title('FFT Amplitdenspektrum Butterworth');
grid('on');
xlim([0.3 200]);
subplot(3,1,3);
stem(f(2:rows2), Y_notch(2:end), 'b', 'LineWidth', 2);
xlabel('Frequenz (Hz)');
ylabel('Amplitude');
title('FFT Amplitdenspektrum Notch');
grid('on');
xlim([0.3 200]);

% Daten plotten
figure(6);
subplot(3,1,1);
plot(x, y);
title('Rohsignal');
xlabel('Zeit (s)');
ylabel('Messwerte');
subplot(3,1,2);
plot(x, y_butter, 'r');
title('Butterworth');
xlabel('Zeit (s)');
ylabel('Messwerte');
subplot(3,1,3);
plot(x, y_notch, 'b');
title('IIR Notch');
xlabel('Zeit (s)');
ylabel('Messwerte');

% Trendentfernung

% Methode 1: Detrend (linearer Fit wird entfernt)
y_detrend1 = detrend(y_butter);  % Anwendung auf gefilterte Daten (Butterworth)

% Methode 2: Gleitender Mittelwert entfernen (Moving Average)
window_size = round(fsample * 0.5); % z.B. 0.5 Sek Fenster
y_mean = movmean(y_butter, window_size);
y_detrend2 = y_butter - y_mean;

% Vergleich der Ergebnisse im Zeitbereich
figure(7);
subplot(3,1,1);
plot(x, y_butter);
title('Butterworth-gefiltertes Signal mit Trend');
xlabel('Zeit (s)');
ylabel('Messwerte');
subplot(3,1,2);
plot(x, y_detrend1, 'g');
title('Trend entfernt – Methode 1: detrend()');
xlabel('Zeit (s)');
ylabel('Messwerte');
subplot(3,1,3);
plot(x, y_detrend2, 'm');
title('Trend entfernt – Methode 2: Gleitender Mittelwert');
xlabel('Zeit (s)');
ylabel('Messwerte');

% Zoom auf die ersten 3 Sekunden
duration_zoom = 3; % Sekunden
samples_zoom = fsample * duration_zoom;
x_zoom = x(1:samples_zoom);
y_zoom = y_detrend2(1:samples_zoom);
figure(8);
plot(x_zoom, y_zoom);
title('Trend entfernt – Erste 3 Sekunden');
xlabel('Zeit (s)');
ylabel('Amplitude');
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

% Plot generieren
figure(4);
stem(f(2:rows2), Y(2:end), 'LineWidth', 2); % 0 Hz, d.h. Mittelwert hier unwichtig
xlabel('Frequenz (Hz)');
ylabel('Amplitude');
title('Amplitudenspektrum der EEG-Messung');
grid('on');
xlim([0.3 100]);
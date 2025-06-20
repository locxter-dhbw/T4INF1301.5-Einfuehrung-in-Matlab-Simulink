% Workspace zurücksetzen
clear all;
close all;
clc;

% Daten laden
format('long');
f = 2000;
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
x = linspace(0, rows/f, rows);
figure(3);
hold("on");
title("EEG-Messung");
ylabel("Messwerte");
xlabel("Zeit in s");
plot(x, y);
yline(mean, 'r');
yline(median, 'g');
legend(["Linke Gehirnhälfte", "Mittelwert", "Median"]);

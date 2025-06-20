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

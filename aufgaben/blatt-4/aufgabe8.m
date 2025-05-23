% Workspace zurücksetzen
clear all;
close all;
clc;

% Gleichungssystem aufstellen und lösen
A = [2 3 1; 4 2 3; 1 1 2];
c = [30; 50; 20];
X = linsolve(A, c)
X_round = round(X)
actualC = A*X_round;

% Balkendiagramm der benötigten vs. gelieferten Energie
bars = [c actualC]
bar(bars);
title('Benötigte vs. gelieferte Energie');
legend('Benötigt', 'Geliefert');
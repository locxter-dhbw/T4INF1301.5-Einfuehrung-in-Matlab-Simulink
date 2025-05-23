% Workspace zurücksetzen
clear all;
close all;
clc;

% Gleichungssystem aufstellen
% I3*R3 - Uq + I2*R2 = 0
% => 0*I1 + R2*I2 + R3*I3 = Uq
% -I2*R2 + Uq - I1*R1 = 0
% => R1*I1 + R2*I2 + 0*I3 = Uq
% -I1 + I2 - I3 = 0
R1 = 5;
R2 = 10;
R3 = 20;
Uq = 70;
% Koeffizientenmatrix
A = [0 R2 R3; R1 R2 0; -1 1 -1];
% Konstantenvektor
b = [Uq; Uq; 0];

% 3 Kopien von A anlegen und jeweilige Spalte durch b ersetzen
A1 = A;
A2 = A;
A3 = A;
A1(:,1) = b;
A2(:,2) = b;
A3(:,3) = b;

% Gleichungssystem über Cramersche Regel (Verhältnis der Determinanten)
% lösen
I1 = det(A1)/det(A)
I2 = det(A2)/det(A)
I3 = det(A3)/det(A)
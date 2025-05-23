% Workspace zurücksetzen
clear all;
clc;

% Matrizenoperationen A * B (gleichbedeutend mit mtimes)
% Elementweise Operation mit A .* B (gleichbedeutend mit times)
% Addition/Subtraktion: minus, plus, uminus, uplus, +, -
% Multiplikation: times, mtimes, .*, *
% Potenzen: mpower, power, ^, .^
% Inverse: idivice, ldivide, .\, mldivide, \, mrdivide /, rdivide ./
A = [1 2; 3 4]
B = [4 3; 2 1]
C = A * B % Matrizenoperation (nach Falk-Schema => Zeile mal Spalte)
D = A .* B % Elementoperation
E = A^2 % Matrixoperation
F = A.^2 % Elementoperation

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ax = b => Gleichungssystem lösen
A = [0 1 1; 1 0 3; 4 1 2]
b = [7; 14; 8]
x = mldivide(A, b)
% Manuelle Lösung
A_inv = inv(A) % Bildung der inversen Matrix A^-1
x_alternative = A_inv * b
% Matlab checkt, on Inverse definiert ist
D = [1 0 0; 0 2 4; 0 3 6]
D_inv = inv(D)

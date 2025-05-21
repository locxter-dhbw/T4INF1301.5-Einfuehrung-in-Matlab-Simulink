% Workspace zurücksetzen
clear all;
clc;

% Matrizen

% Matrix (wird ausgegeben, da kein Semikolon am Ende)
A = [1 2 3; 4 5 6; 7 8 9];
% Nur die dritte Spalte
A(3, :);
% Nur die zweite Spalte
A(:, 2);
% Ein Element mit Matrixaddressierung
A(3, 2);
% Ein Element mit linearer Addressierung (Spaltenweisen von oben nach
% unten)
A(7);
% Prüfen welche Elemente die Bedingung erfüllen
A >= 5;
% Zufallsmatrix zwischen 0 und 1
B = rand(3);

% Zellen (Matrixen mit gemischten Datentypen)
Z = {1:5, 'Ich bin eine Zelle'; A, B};

% Strukturen (structs)
S.name = 'Struktur';
S.vec=1:5;
S.a=A;
S.b=B;
S;

% Tabellen
Name = {'Marc'; 'Vera'; 'Lukas'};
Alter = {21; 19; 20};
WieAlt = table(Name, Alter);
WieAlt;
WieAlt(2,:);

% Beispiel: Gedämpfte Schwingung
% Auslenkungsformel: y(t) = e^(-k*t) * sin(w*t+p)
% Kreisfrequenz: w = sqrt(w0^2 - k^2)
w0 = 1;
n = 0;
ks = [0.2 1 3];
t = 0:0.01:8*pi;
for k = ks
    n = n + 1;
    w = sqrt(w0^2 - k^2);
    if (w == 0)
        y = exp(-k .* t) .* t; % Elementweise Multiplikation
    else
        y = exp(-k .* t) .* sin(w * t) / w;
    end
    if n == 1
        subplot(2, 2, 1:2) % Schwache Dämpfung oben groß
    else
        subplot(2,2,n+1) % Andere Plots kleiner unten
    end
    plot(t, y)
    axis tight
    legend(['\kappa = ', num2str(k)])
end

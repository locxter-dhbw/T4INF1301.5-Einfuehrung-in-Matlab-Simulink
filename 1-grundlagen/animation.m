% Workspace zurücksetzen
clear all;
clc;

% Figur anlegen
figure;
% Erzeugt zwischen den Grenzen 200 äquidistante Werte
phi = linspace(0, 2 * pi, 200);
x = sin(2 * phi);

% Y mit Schleife durchlaufen
k = 0;
for phase = phi
    k = k + 1;
    y = sin(4 * phi + phase);
    plot(x, y);
    % Speichern der Einzelbilder
    F(k) = getframe;
end

title('Erstes Bewegtbild');
movie(F)
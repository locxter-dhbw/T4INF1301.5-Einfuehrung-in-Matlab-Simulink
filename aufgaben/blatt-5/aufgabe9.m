% Workspace zurücksetzen
clear all;
close all;
clc;

% Rahmenparameter setzen
accuracy = 1e-10;
maxIterations = 100;

% Funktion einlesen
syms x;
f_str = input('Bitte Funktion eingeben: ', 's');
f = str2sym(f_str);
disp('Die eingegebene Funktion lautet: ');
disp(f);
df = diff(f, x);
ddf = diff(f, x, 2);

% Startwert einlesen (alternativ auto für automatisch)
xStart = input('Bitte Startwert eingeben: ');

% Prüfen des Konvergenzkriteriums
fXStart = subs(f, x, xStart);
dfXStart = subs(df, x, xStart);
ddfXStart = subs(ddf, x, xStart);
if abs(dfXStart) < accuracy || (fXStart * ddfXStart) / (dfXStart^2) >= 1
    disp('Konvergenzkriterium nicht erfüllt! Programmabbruch...');
    quit;
end

% Berechnung der Nullstelle
xOld = xStart;
xNew = xStart;
dfX = dfXStart;
iteration = 0;
while (abs(xNew - xOld) > accuracy || iteration == 0) && abs(dfX) > accuracy && iteration < maxIterations
    xBuf = xNew;
    dfX = subs(df, x, xOld);
    xNew = xOld - (subs(f, x, xOld) / dfX);
    xOld = xBuf;
    iteration = iteration + 1;
end

% Ausgabe der Nullstelle
zeroXDouble = double(xNew);
zeroYDouble = double(subs(f, x, xNew));
disp(['Die Nullstelle lautet: x = ', num2str(zeroXDouble), ' mit einem Funktionswert von ' , num2str(zeroYDouble)]);

% Plot der Funktion mit Nullstelle
figure;
fplot(f,[(zeroXDouble - 5) (zeroXDouble + 5)])
hold('on');
plot(zeroXDouble,zeroYDouble,'r*');
title('Nullstelle der eingegebenen Funktion');
grid('on');

% Workspace zurücksetzen
clear all;
close all;
clc;

% Nutzereingaben einlesen
x = input('Bitte Zahl eingeben: ');
disp(['Du hast diese Zahl eingegeben: ', num2str(x)])
name = input('Wie heißt du?: ', 's');
disp(['Hallo ', name]);

% Symbolische Variable (Ableitung et cetera möglich
syms x;
f = 3*x^2 + 2*x - 5;
disp(f);
df = diff(f, x);
disp(df);
ddf = diff(f, x, 2);
disp(ddf);

% Funktionen einlesen
syms x;
f_str = input('Bitte Funktion eingeben: ', 's');
f = str2sym(f_str);
disp('Die eingegebene Funktion lautet');
disp(f);

% Einsetzen in Funktion
xWert = 2;
fWert = subs(f, x, xWert);
disp(fWert);
disp(double(fWert));

% Für eine tatsächliche Implementierung des Tangengenverfahrens von Newton,
% bitte Aufgabe 9 anschauen :)
% Workspace zurücksetzen
clear all;
clc;

% Sachen machen
data = readtable('training_daten_mit_wochentagen.csv');
rows = height(data);
dailyDist = linspace(0, 0, rows);
weeklyDist = linspace(0, 0, ceil(rows / 5));
totalDist = 0.0;
for row = 1:rows
    rowData = data(row,:);
    todaysDist = rowData.Zeit_h_ * rowData.Geschwindigkeit_km_h_;
    dailyDist(row) = todaysDist;
    weekNum = ceil(row / 5);
    weeklyDist(weekNum) = weeklyDist(weekNum) + todaysDist;
    totalDist = totalDist + todaysDist;
end
disp('Tagesdistanzen:');
disp(dailyDist);
disp('Wochendistanzen:');
disp(weeklyDist);
disp('Gesamtdistanz:');
disp(totalDist);

% Wochendistanzen plotten
figure;
weekNums = 1:8;
bar(weekNums, weeklyDist);
title('Wochendistanzen');
xlabel('Woche');
ylabel('km')
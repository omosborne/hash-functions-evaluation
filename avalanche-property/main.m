clear all;
close all;
clc;

% Assign similar keys for testing the avalanche property of hashes.
keysOffset1 = [1000, 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009];
keysOffset2 = [1000, 1002, 1004, 1006, 1008, 1010, 1012, 1014, 1016, 1018];
keysOffset3 = [1000, 1003, 1006, 1009, 1012, 1015, 1018, 1021, 1024, 1027];

% Perform hashes and collect Mean Absolute Distance (MAD)
[midMADOffset1, mulMADOffset1, fibMADOffset1] = performHashProcess(keysOffset1);
[midMADOffset2, mulMADOffset2, fibMADOffset2] = performHashProcess(keysOffset2);
[midMADOffset3, mulMADOffset3, fibMADOffset3] = performHashProcess(keysOffset3);

% ===== Avalanche Evaluation Graph =====
figure;
bars = [midMADOffset1 mulMADOffset1 fibMADOffset1;
        midMADOffset2 mulMADOffset2 fibMADOffset2;
        midMADOffset3 mulMADOffset3 fibMADOffset3];
X = categorical({'Offset by 1','Offset by 2','Offset by 3'});
X = reordercats(X,{'Offset by 1','Offset by 2','Offset by 3'});
b = bar(X, bars);
xlabel('Hashed Key Offsets');
ylabel('Mean Absolute Distance');
title('Mean distances between hashed table keys');
axis square;
legend('Midsquare','Multiplicative','Fibonacci','Location','northwest');
text(b(1).XEndPoints,b(1).YEndPoints,string(b(1).YData),'HorizontalAlignment','center','VerticalAlignment','bottom');
text(b(2).XEndPoints,b(2).YEndPoints,string(b(2).YData),'HorizontalAlignment','center','VerticalAlignment','bottom');
text(b(3).XEndPoints,b(3).YEndPoints,string(b(3).YData),'HorizontalAlignment','center','VerticalAlignment','bottom');

print('-dpng', 'avalancheGraph.png');
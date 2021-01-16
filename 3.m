clear; close all; clc;

% 180 çizgili küre çiz
[x,y,z] = sphere(180);
% Yarıçap ayarla
radius = 6373000;
x = x * radius;
y = y * radius;
z = z * radius;
% Konum ayarla
offset = 6373000;
surf(x+offset,y+offset,z+offset) 
% Etiket yazdır
xlabel('X', 'FontSize', 20);
ylabel('Y', 'FontSize', 20);
zlabel('Z', 'FontSize', 20);
axis equal;

% hold on
% [X,Y,Z] = sphere;
% r = 100;
% surf(X,Y,Z)
% axis equal
% X2 = X * r;
% Y2 = Y * r;
% Z2 = Z * r;
% surf(X2,Y2,Z2)


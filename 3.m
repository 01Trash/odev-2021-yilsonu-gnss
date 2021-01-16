clear; close all; clc;

% 180 boylam-enlem
[x,y,z] = sphere(180);
% Yarıçap ayarla
radius = 6373000;
x = x * radius;
y = y * radius;
z = z * radius;
% Dengeleme için
offset = 6373000;
surf(x+offset,y+offset,z+offset)
% Etiket yazdır
xlabel('X', 'FontSize', 20);
ylabel('Y', 'FontSize', 20);
zlabel('Z', 'FontSize', 20);
axis equal;

% Uydu için
% [x,y,z] = sphere(180);
% % Yarıçap ayarla
% radius = 100;
% x = x * radius;
% y = y * radius;
% z = z * radius;
% 
% offset1 = 637300034535;
% offset2 = 637300034535;
% offset3 = 6373000345345;
% surf(x+offset1,y+offset2,z+offset3)
% axis equal;




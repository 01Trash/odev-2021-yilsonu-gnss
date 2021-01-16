clear; close all; clc;

% Make unit sphere
[x,y,z] = sphere(180);
% Scale to desire radius.
radius = 6373000;
x = x * radius;
y = y * radius;
z = z * radius;
% Translate sphere to new location.
offset = 6373000;
% Plot as surface.
surf(x+offset,y+offset,z+offset) 
% Label axes.
xlabel('X', 'FontSize', 20);
ylabel('Y', 'FontSize', 20);
zlabel('Z', 'FontSize', 20);
axis equal;


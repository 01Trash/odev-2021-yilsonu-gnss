clear; close all; clc;

%%% IGS BROADCAST EPHEMERIS FILE verileri
t_GPS = 589824; % tGPS
%%%SV_PRN = 18; % SV PRN
t_0_c = 16; % t0c
a_0 = 0.757537782192 * 10 ^ (-5); % a0
a_1 = 0.397903932026 * 10 ^ (-11); % a1
a_2 =  0.000000000000 * 10 ^ (0); % a2
C_r_s = -0.812187500000 * 10 ^ (2); % Crs
Delta_n = 0.415231582451 * 10 ^ (-8); % Δn
M_0 = -0.257060750565 * 10 ^ (1); % M0
C_u_c = -0.406429171562 * 10 ^ (-5); % Cuc
e = 0.149637315190 * 10 ^ (-1); % e
C_u_s = 0.124666839838 * 10 ^ (-4); % Cus
sqrt_a = 0.515361848831 * 10 ^ (4); % sqrt(a)
t_0_e = 0.432000000000 * 10 ^ (6); % t0e
C_i_c = 0.191852450371 * 10 ^ (-6); % Cic
Ohm_0 = -0.151149171398 * 10 ^ (0); % Ω0
C_i_s = 0.167638063431 * 10 ^ (-7); % Cis
i_0 = 0.952600262573 * 10 ^ (0); % i0
C_r_c = 0.131312500000 * 10 ^ (3); % Crc
W = 0.136565314002 * 10 ^ (1); % ω
Ohm = -0.751781303876 * 10 ^ (-8); % Ω
i_t_k = 0.352871842857 * 10 ^ (-9); % i


% Yerçekimi sabiti m^3/s^2 (WGS84)
GM_e = 3986004.418 * 10 ^ 8;

% Yerin açısal dönme hızı rad/s (WGS84)
W_e = 7.2921151467 * 10 ^ (-5);

% Yör. büyük yarıekseni
a = sqrt_a ^ 2;

% Ortalama yör. hızı
n_0 = sqrt(GM_e / a ^ 3);

% Düzeltilmiş yör. hızı
n = n_0 + Delta_n;

% t0e'ye göre zaman
t_k = t_GPS - t_0_e;
%fprintf("tk: %.13f\n", t_k);

% Ortalama anomali
M_k = M_0 + n * t_k;
%fprintf("Mk: %.13f\n", M_k);

% İterasyon ile kepler denklemi
E_k = M_k;
E_k_n = 2;
E_k_n1 = 1;
while E_k_n - E_k_n1 >= 0.000000001
    E_k_n = E_k;
    E_k_n1 = M_k + exp(1) * sin(E_k);
    E_k = E_k_n1;
    %fprintf("Kepler: %.13f\n", E_k);
end
%fprintf("Kepler: %.13f\n", E_k);

% Gerçek anomali
V_k = atan((sqrt(1 - exp(2)) * sin(E_k) / (cos(E_k) - exp(1))));

% Enlem argümanı
U_k = W + V_k;

% Enlem argümanı düzeltmesi
Sigma_u_k = C_u_c * cos(2 * U_k) + C_u_s * sin(2 * U_k);

% Yarıçap düzeltmesi
Sigma_r_k = C_r_c * cos(2 * U_k) + C_r_s * sin(2 * U_k);

% Eğim düzeltmesi
Sigma_i_k = C_i_c * cos(2 * U_k) + C_i_s * sin(2 * U_k);

% Düzeltilmiş enlem argümanı
Fi_k = U_k + Sigma_u_k;

% Düzeltilmiş yarıçap
r_k = a * (1 - exp(1) * cos(E_k)) + Sigma_r_k;

% Düzeltilmiş yör. eğimi
i_k = i_0 + i_t_k + Sigma_i_k;

% Düzeltilmiş çıkış düğümü boylamı
Ohm_k = Ohm_0 + (Ohm - W_e) * t_k - W_e * t_0_e;

% x yörünge koordinatı
x_ussu_k = r_k * cos(Fi_k);

% y yörünge koordinatı
y_ussu_k = r_k * sin(Fi_k);

%%% Yer merkezli yer sabit (ECEF) koordinatlarının hesabı
%fprintf("Yer merkezli yer sabit (ECEF) x, y, z koordinatları \n");
% x yer merkezli koordinatı
x_k = x_ussu_k * cos(Ohm_k) - y_ussu_k * sin(Ohm_k) * cos(i_k);
%fprintf("x: %.4f m\n", x_k);
% y yer merkezli koordinatı
y_k = x_ussu_k * sin(Ohm_k) + y_ussu_k * cos(Ohm_k) * cos(i_k);
%fprintf("y: %.4f m\n", y_k);
% z yer merkezli koordinatı
z_k = y_ussu_k * sin(i_k);
%fprintf("z: %.4f m\n", z_k);


% t anında uydunun saat hatasının hesabı
S_s = a_0 + a_1 * (t_GPS - t_0_c) + a_2 * (t_GPS - t_0_c)^2;
%fprintf("\nSaat hatası: %.13f s\n", S_s);


%%% IGS BROADCAST EPHEMERIS FILE verileri
t_GPS = 589824 + S_s; % tGPS
%%%SV_PRN = 18; % SV PRN
t_0_c = 16; % t0c
a_0 = 0.757537782192 * 10 ^ (-5); % a0
a_1 = 0.397903932026 * 10 ^ (-11); % a1
a_2 =  0.000000000000 * 10 ^ (0); % a2
C_r_s = -0.812187500000 * 10 ^ (2); % Crs
Delta_n = 0.415231582451 * 10 ^ (-8); % Δn
M_0 = -0.257060750565 * 10 ^ (1); % M0
C_u_c = -0.406429171562 * 10 ^ (-5); % Cuc
e = 0.149637315190 * 10 ^ (-1); % e
C_u_s = 0.124666839838 * 10 ^ (-4); % Cus
sqrt_a = 0.515361848831 * 10 ^ (4); % sqrt(a)
t_0_e = 0.432000000000 * 10 ^ (6); % t0e
C_i_c = 0.191852450371 * 10 ^ (-6); % Cic
Ohm_0 = -0.151149171398 * 10 ^ (0); % Ω0
C_i_s = 0.167638063431 * 10 ^ (-7); % Cis
i_0 = 0.952600262573 * 10 ^ (0); % i0
C_r_c = 0.131312500000 * 10 ^ (3); % Crc
W = 0.136565314002 * 10 ^ (1); % ω
Ohm = -0.751781303876 * 10 ^ (-8); % Ω
i_t_k = 0.352871842857 * 10 ^ (-9); % i


% Yerçekimi sabiti m^3/s^2 (WGS84)
GM_e = 3986004.418 * 10 ^ 8;

% Yerin açısal dönme hızı rad/s (WGS84)
W_e = 7.2921151467 * 10 ^ (-5);

% Yör. büyük yarıekseni
a = sqrt_a ^ 2;

% Ortalama yör. hızı
n_0 = sqrt(GM_e / a ^ 3);

% Düzeltilmiş yör. hızı
n = n_0 + Delta_n;

% t0e'ye göre zaman
t_k = t_GPS - t_0_e;
%fprintf("tk: %.13f\n", t_k);

% Ortalama anomali
M_k = M_0 + n * t_k;
%fprintf("Mk: %.13f\n", M_k);

% İterasyon ile kepler denklemi
E_k = M_k;
E_k_n = 2;
E_k_n1 = 1;
while E_k_n - E_k_n1 >= 0.000000001
    E_k_n = E_k;
    E_k_n1 = M_k + exp(1) * sin(E_k);
    E_k = E_k_n1;
    %fprintf("Kepler: %.13f\n", E_k);
end
%fprintf("Kepler: %.13f\n", E_k);

% Gerçek anomali
V_k = atan((sqrt(1 - exp(2)) * sin(E_k) / (cos(E_k) - exp(1))));

% Enlem argümanı
U_k = W + V_k;

% Enlem argümanı düzeltmesi
Sigma_u_k = C_u_c * cos(2 * U_k) + C_u_s * sin(2 * U_k);

% Yarıçap düzeltmesi
Sigma_r_k = C_r_c * cos(2 * U_k) + C_r_s * sin(2 * U_k);

% Eğim düzeltmesi
Sigma_i_k = C_i_c * cos(2 * U_k) + C_i_s * sin(2 * U_k);

% Düzeltilmiş enlem argümanı
Fi_k = U_k + Sigma_u_k;

% Düzeltilmiş yarıçap
r_k = a * (1 - exp(1) * cos(E_k)) + Sigma_r_k;

% Düzeltilmiş yör. eğimi
i_k = i_0 + i_t_k + Sigma_i_k;

% Düzeltilmiş çıkış düğümü boylamı
Ohm_k = Ohm_0 + (Ohm - W_e) * t_k - W_e * t_0_e;

% x yörünge koordinatı
x_ussu_k = r_k * cos(Fi_k);

% y yörünge koordinatı
y_ussu_k = r_k * sin(Fi_k);

%%% Yer merkezli yer sabit (ECEF) düzeltilmiş koordinatlarının hesabı
%fprintf("\nYer merkezli yer sabit (ECEF) düzeltilmiş x, y, z koordinatları \n");
% x yer merkezli koordinatı
x_k_2 = x_ussu_k * cos(Ohm_k) - y_ussu_k * sin(Ohm_k) * cos(i_k);
%fprintf("x: %.4f m\n", x_k_2);
% y yer merkezli koordinatı
y_k_2 = x_ussu_k * sin(Ohm_k) + y_ussu_k * cos(Ohm_k) * cos(i_k);
%fprintf("y: %.4f m\n", y_k_2);
% z yer merkezli koordinatı
z_k_2 = y_ussu_k * sin(i_k);
%fprintf("z: %.4f m\n", z_k_2);


% Dünya çizimi
% 180 boylam-enlem
[x,y,z] = sphere(180);
% Yarıçap ayarla
radius = 6373000;
x = x * radius;
y = y * radius;
z = z * radius;
surf(x,y,z)
axis equal;

hold on
% Uydu çizimi
[x,y,z] = sphere;
% Yarıçap ayarla
radius = 1000000;
x = x * radius;
y = y * radius;
z = z * radius;
% Dengeleme için
x2 = x + real(x_k_2);
y2 = y + real(y_k_2);
z2 = z + real(z_k_2);
surf(x2,y2,z2)
% Etiket yazdır
xlabel('X', 'FontSize', 20);
ylabel('Y', 'FontSize', 20);
zlabel('Z', 'FontSize', 20);
title("Uydu görsel açıdan görünmesi için abartılarak çizilmiştir.")


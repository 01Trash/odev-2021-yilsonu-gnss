clear; close all; clc;

% My data
t_GPS = 1; % tGPS

%%% IGS BROADCAST EPHEMERIS FILE verileri
SV_PRN = 18; % SV PRN
t_0_c = 100; % t0c => 10 6 15 0 0 0.0
a_0 = -0.130765140057* 10 ^ (-3); % a0
a_1 = -0.397903932026 * 10 ^ (-11); % a1
a_2 =  0.000000000000 * 10 ^ (0); % a2
C_r_s = -0.128968750000 * 10 ^ (3); % Crs
Delta_n = 0.430625080120 * 10 ^ (-8); % Δn
M_0 = 0.277797041753* 10 ^ (1); % M0
C_u_c = -0.676885247230 * 10 ^ (-5); % Cuc 
e = 0.479935575277 * 10 ^ (-2); % e
C_u_s = 0.862218439579 * 10 ^ (-5); % Cus 
sqrt_a = 0.515480328751 * 10 ^ (4); % sqrt(a)
t_0_e = 0.172800000000 * 10 ^ (6); % t0e
C_i_c = -0.614672899246 * 10 ^ (-7); % Cic
Ohm_0 = -0.310529947884 * 10 ^ (1); % Ω0
C_i_s = -0.838190317154 * 10 ^ (-7); % Cis
i_0 = 0.965349772110 * 10 ^ (0); % i0
C_r_c = 0.216531250000 * 10 ^ (3); % Crc
W = 0.872701637012 * 10 ^ (0); % ω
Ohm = -0.784425531615 * 10 ^ (-8); % Ω
i = -0.118219210019 * 10 ^ (-9); % i


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

%%% Ortalama anomali
M_k = M_0 + n * t_k;

%% Döngü İterasyon var!!! 
%% Kepler denklemi
%M_k = E_k - exp(1) * sin(E_k); 

% Gerçek anomali
V_k = atan((sqrt(1 - exp(2)) * sin(E_k) / (cosE_k - exp(1)))); 

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

% x yermerkezli koordinatı
x_k = x_ussu_k * cos(Ohm_k) - y_ussu_k * sin(Ohm_k) * cos(i_k);

% y yermerkezli koordinatı
y_k = x_ussu_k * sin(Ohm_k) + y_ussu_k * cos(Ohm_k) * cos(i_k); 

% z yermerkezli koordinatı
z_k = y_ussu_k * sin(i_k); 

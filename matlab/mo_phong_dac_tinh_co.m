%% MÔ PHỎNG ĐẶC TÍNH CƠ ĐỘNG CƠ DC
% Phân tích chi tiết đặc tính cơ n = f(M) và n = f(I)
% Tác giả: Hệ thống điều khiển máy xúc Huina 1592
% Ngày: 10/2025

clc; clear all; close all;

%% ========== THÔNG SỐ ==========

fprintf('========== ĐẶC TÍNH CƠ ĐỘNG CƠ 540/550 ==========\n\n');

% Thông số động cơ
U_rated = 7.4;          % Điện áp định mức [V]
I_rated = 4;            % Dòng định mức [A]
n_no_load = 12000;      % Tốc độ không tải [rpm]
n_rated = 8000;         % Tốc độ định mức [rpm]
R_a = 0.8;              % Điện trở [Ohm]
K_e = 0.00557;          % Hằng số EMF [V/(rad/s)]
K_m = 0.0066;           % Hằng số mô men [N.m/A]

omega_rated = n_rated * 2*pi/60;
M_rated = K_m * I_rated;

fprintf('Thông số động cơ:\n');
fprintf('  U = %.1f V\n', U_rated);
fprintf('  I_rated = %.0f A\n', I_rated);
fprintf('  n_no_load = %.0f rpm\n', n_no_load);
fprintf('  n_rated = %.0f rpm\n', n_rated);
fprintf('  M_rated = %.2f mN.m\n', M_rated*1000);
fprintf('  R_a = %.2f Ω\n', R_a);
fprintf('  K_e = %.5f V/(rad/s)\n', K_e);
fprintf('  K_m = %.5f N.m/A\n', K_m);
fprintf('\n');

%% ========== TÍNH TOÁN ĐẶC TÍNH TỰ NHIÊN ==========

% Tốc độ không tải (lý thuyết)
n_0_theory = U_rated / (K_e * 2*pi/60);

% Độ dốc đặc tính
delta_n = (R_a * 60) / (K_e^2 * 2*pi);

fprintf('Tính toán đặc tính:\n');
fprintf('  n_0 (lý thuyết): %.0f rpm\n', n_0_theory);
fprintf('  Độ dốc Δn: %.0f rpm/(N.m)\n', delta_n);
fprintf('\n');

% Dải mô men 0 → quá tải 120%
M_range = linspace(0, M_rated*1.2, 100);

% Đặc tính tự nhiên với các điện áp
U_levels = [3.7, 5.0, 7.4, 9.0, 11.1];
colors = {'b', 'g', 'r', 'm', 'k'};

figure('Name', 'Đặc tính cơ', 'Position', [50, 50, 1400, 900]);

%% ========== Subplot 1: n = f(M) với các điện áp ==========
subplot(2, 3, 1);
hold on;
for i = 1:length(U_levels)
    U = U_levels(i);
    n_0 = U / (K_e * 2*pi/60);
    n = n_0 - delta_n * M_range;
    
    plot(M_range*1000, n, colors{i}, 'LineWidth', 2);
end
grid on;
xlabel('Mô men M (mN.m)');
ylabel('Tốc độ n (rpm)');
title('Đặc tính cơ n = f(M)');
legend('3.7V (1S)', '5V', '7.4V (2S)', '9V', '11.1V (3S)', 'Location', 'Northeast');
xlim([0 M_rated*1.2*1000]);
ylim([0 n_0_theory*1.5]);

% Đánh dấu điểm định mức
plot(M_rated*1000, n_rated, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
text(M_rated*1000+2, n_rated+200, 'Định mức', 'FontSize', 9);

%% ========== Subplot 2: M = f(I) ==========
subplot(2, 3, 2);
I_range = linspace(0, I_rated*1.5, 100);
M_theory = K_m * I_range;

plot(I_range, M_theory*1000, 'r-', 'LineWidth', 2);
hold on;
plot([0 I_rated*1.5], [M_rated*1000 M_rated*1000], 'k--');
plot([I_rated I_rated], [0 M_rated*1.5*1000], 'k--');
plot(I_rated, M_rated*1000, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
grid on;
xlabel('Dòng điện I_a (A)');
ylabel('Mô men M (mN.m)');
title('Quan hệ M = K_m × I_a');
legend('M = f(I)', 'M_{rated}', 'I_{rated}', 'Location', 'Northwest');

%% ========== Subplot 3: n = f(I) ==========
subplot(2, 3, 3);
hold on;
for i = 1:length(U_levels)
    U = U_levels(i);
    n = (U - I_range * R_a) / (K_e * 2*pi/60);
    n(n<0) = 0;  % Không cho âm
    
    plot(I_range, n, colors{i}, 'LineWidth', 2);
end
grid on;
xlabel('Dòng điện I_a (A)');
ylabel('Tốc độ n (rpm)');
title('Đặc tính n = f(I_a)');
legend('3.7V', '5V', '7.4V', '9V', '11.1V', 'Location', 'Northeast');

%% ========== Subplot 4: Công suất P = f(M) ==========
subplot(2, 3, 4);
hold on;
for i = 1:length(U_levels)
    U = U_levels(i);
    n_vals = (U - (M_range/K_m) * R_a) / (K_e * 2*pi/60);
    n_vals(n_vals<0) = 0;
    omega_vals = n_vals * 2*pi/60;
    P_out = M_range .* omega_vals;
    
    plot(M_range*1000, P_out, colors{i}, 'LineWidth', 2);
end
grid on;
xlabel('Mô men M (mN.m)');
ylabel('Công suất P (W)');
title('Công suất cơ P = M × ω');
legend('3.7V', '5V', '7.4V', '9V', '11.1V', 'Location', 'Northwest');

%% ========== Subplot 5: Hiệu suất η = f(M) ==========
subplot(2, 3, 5);
M_calc = linspace(0.001, M_rated*1.2, 100);  % Tránh chia 0
I_calc = M_calc / K_m;
omega_calc = (U_rated - I_calc * R_a) / K_e;
omega_calc(omega_calc<0) = 0;

P_out = M_calc .* omega_calc;
P_in = U_rated * I_calc;
eta = P_out ./ P_in * 100;
eta(eta<0) = 0;
eta(eta>100) = 100;

plot(M_calc*1000, eta, 'k-', 'LineWidth', 2);
hold on;
plot([M_rated*1000 M_rated*1000], [0 100], 'r--');
grid on;
xlabel('Mô men M (mN.m)');
ylabel('Hiệu suất η (%)');
title('Hiệu suất η = P_{out}/P_{in}');
ylim([0 100]);

% Tìm hiệu suất max
[eta_max, idx_max] = max(eta);
plot(M_calc(idx_max)*1000, eta_max, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
text(M_calc(idx_max)*1000+1, eta_max-5, sprintf('η_{max}=%.1f%%', eta_max), 'FontSize', 9);

%% ========== Subplot 6: So sánh lý thuyết vs thực tế ==========
subplot(2, 3, 6);

% Lý thuyết (không ma sát)
n_theory = n_0_theory - delta_n * M_range;

% Thực tế (có ma sát, tổn thất)
eta_avg = 0.75;  % Hiệu suất trung bình
I_real = M_range / (K_m * eta_avg);
n_real = (U_rated - I_real * R_a) / (K_e * 2*pi/60);
n_real(n_real<0) = 0;

plot(M_range*1000, n_theory, 'b-', 'LineWidth', 2);
hold on;
plot(M_range*1000, n_real, 'r--', 'LineWidth', 2);
grid on;
xlabel('Mô men M (mN.m)');
ylabel('Tốc độ n (rpm)');
title('Lý thuyết vs Thực tế');
legend('Lý thuyết (ideal)', 'Thực tế (η=75%)', 'Location', 'Northeast');

%% ========== PHÂN TÍCH ==========

fprintf('========== PHÂN TÍCH ĐẶC TÍNH ==========\n\n');

fprintf('ĐIỂM ĐẶC BIỆT:\n');
fprintf('  Tốc độ không tải: %.0f rpm\n', n_0_theory);
fprintf('  Tốc độ định mức: %.0f rpm (%.1f%% n_0)\n', n_rated, n_rated/n_0_theory*100);
fprintf('  Mô men định mức: %.2f mN.m\n', M_rated*1000);
fprintf('  Mô men khởi động max: %.2f mN.m (@ I=8A)\n', K_m*8*1000);
fprintf('\n');

fprintf('ĐỘ SỤT TỐC:\n');
n_0_to_rated = (n_0_theory - n_rated) / n_0_theory * 100;
fprintf('  Từ không tải → định mức: %.1f%%\n', n_0_to_rated);
fprintf('  Độ dốc: %.0f rpm/(N.m)\n', delta_n);
fprintf('\n');

fprintf('CÔNG SUẤT:\n');
P_rated_calc = M_rated * omega_rated;
fprintf('  P @ định mức: %.1f W\n', P_rated_calc);
fprintf('  P max (ước tính): %.1f W (@ 50%% n_0)\n', max(P_out));
fprintf('\n');

fprintf('HIỆU SUẤT:\n');
fprintf('  η max: %.1f%% (@ M=%.1f mN.m)\n', eta_max, M_calc(idx_max)*1000);
fprintf('  η @ định mức: %.1f%%\n', eta(find(M_calc>=M_rated, 1)));
fprintf('\n');

fprintf('KHUYẾN NGHỊ VẬN HÀNH:\n');
fprintf('  Vùng làm việc tốt: M = %.1f - %.1f mN.m\n', ...
    M_rated*0.3*1000, M_rated*0.8*1000);
fprintf('  Vùng hiệu suất cao: M = %.1f - %.1f mN.m (η > 70%%)\n', ...
    M_calc(find(eta>70, 1))*1000, M_calc(find(eta>70, 1, 'last'))*1000);
fprintf('  Tránh quá tải: M < %.1f mN.m\n', M_rated*1.2*1000);
fprintf('\n');

%% ========== BẢO VỆ VÀ GIỚI HẠN ==========

fprintf('GIỚI HẠN AN TOÀN:\n');
fprintf('  Dòng max liên tục: %.0f A\n', I_rated);
fprintf('  Dòng max tức thời: %.0f A (10s)\n', I_rated*2);
fprintf('  Mô men max: %.1f mN.m\n', M_rated*1.2*1000);
fprintf('  Tốc độ max: %.0f rpm\n', n_0_theory);
fprintf('  Nhiệt độ max: 80°C\n');
fprintf('\n');

fprintf('========================================\n');

%% ========== LƯU KẾT QUẢ ==========

saveas(gcf, 'dac_tinh_co_dong_co.png');
fprintf('\nĐã lưu: dac_tinh_co_dong_co.png\n');

% Lưu dữ liệu
data.M_range = M_range;
data.U_levels = U_levels;
data.n_0_theory = n_0_theory;
data.delta_n = delta_n;
data.eta_max = eta_max;
data.M_at_eta_max = M_calc(idx_max);
save('data_dac_tinh_co.mat', 'data');
fprintf('Đã lưu: data_dac_tinh_co.mat\n');


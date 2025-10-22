%% MÔ PHỎNG HIỆU SUẤT ĐỘNG CƠ VÀ HỆ THỐNG
% Phân tích hiệu suất toàn hệ thống: Động cơ + ESC + PWM
% Tác giả: Hệ thống điều khiển máy xúc Huina 1592
% Ngày: 10/2025

clc; clear all; close all;

%% ========== THÔNG SỐ ==========

fprintf('========== PHÂN TÍCH HIỆU SUẤT ==========\n\n');

% Động cơ
R_a = 0.8;              % Điện trở [Ohm]
K_e = 0.00557;          % Hằng số EMF [V/(rad/s)]
K_m = 0.0066;           % Hằng số mô men [N.m/A]
U_supply = 7.4;         % Điện áp nguồn [V]

% ESC/MOSFET
R_ds_on = 0.02;         % Điện trở dẫn MOSFET [Ohm]
V_diode = 0.7;          % Áp rơi diode body [V]
t_sw = 100e-9;          % Thời gian đóng/mở [s] = 100ns
f_PWM = 20000;          % Tần số PWM [Hz]

% Tải
M_load_range = linspace(0.001, 0.04, 50);  % 1-40 mN.m

fprintf('Thông số hệ thống:\n');
fprintf('  Nguồn: %.1f V\n', U_supply);
fprintf('  R_a (motor): %.2f Ω\n', R_a);
fprintf('  R_ds (MOSFET): %.3f Ω\n', R_ds_on);
fprintf('  f_PWM: %.0f kHz\n', f_PWM/1000);
fprintf('\n');

%% ========== TÍNH TOÁN HIỆU SUẤT ==========

figure('Name', 'Phân tích hiệu suất', 'Position', [50, 50, 1400, 900]);

%% Subplot 1: Hiệu suất động cơ

subplot(2, 3, 1);
hold on;

% Hiệu suất động cơ với các điện áp
U_levels = [3.7, 5.0, 7.4, 9.0];
colors = {'b', 'g', 'r', 'k'};

for idx = 1:length(U_levels)
    U = U_levels(idx);
    I_a = M_load_range / K_m;
    omega = (U - I_a * R_a) / K_e;
    omega(omega<0) = 0;
    
    P_out = M_load_range .* omega;
    P_in = U * I_a;
    eta_motor = P_out ./ P_in * 100;
    eta_motor(eta_motor<0) = 0;
    eta_motor(eta_motor>100) = 100;
    
    plot(M_load_range*1000, eta_motor, colors{idx}, 'LineWidth', 2);
end

grid on;
xlabel('Mô men tải (mN.m)');
ylabel('Hiệu suất (%)');
title('Hiệu suất động cơ');
legend('3.7V', '5.0V', '7.4V', '9.0V', 'Location', 'Best');
ylim([0 100]);

%% Subplot 2: Tổn thất động cơ

subplot(2, 3, 2);
I_a = M_load_range / K_m;
omega = (U_supply - I_a * R_a) / K_e;
omega(omega<0) = 0;

P_copper = I_a.^2 * R_a;  % Tổn thất đồng
P_friction = 0.5;         % Tổn thất cơ (giả định 0.5W)
P_iron = 0.2;             % Tổn thất sắt (0.2W)
P_total_loss = P_copper + P_friction + P_iron;

plot(M_load_range*1000, P_copper, 'r-', 'LineWidth', 2);
hold on;
plot(M_load_range*1000, ones(size(M_load_range))*P_friction, 'g--', 'LineWidth', 2);
plot(M_load_range*1000, ones(size(M_load_range))*P_iron, 'b--', 'LineWidth', 2);
plot(M_load_range*1000, P_total_loss, 'k-', 'LineWidth', 2);
grid on;
xlabel('Mô men tải (mN.m)');
ylabel('Tổn thất (W)');
title('Phân tích tổn thất động cơ');
legend('P_{Cu} = I²R', 'P_{ma sát}', 'P_{sắt}', 'P_{tổng}', 'Location', 'Northwest');

%% Subplot 3: Hiệu suất ESC (PWM)

subplot(2, 3, 3);
Duty_range = 0.2:0.05:1.0;
I_avg = 3;  % Dòng trung bình

P_cond = zeros(size(Duty_range));
P_sw = zeros(size(Duty_range));
eta_ESC = zeros(size(Duty_range));

for i = 1:length(Duty_range)
    D = Duty_range(i);
    
    % Tổn thất dẫn (4 MOSFET)
    P_cond(i) = 4 * I_avg^2 * R_ds_on * D;
    
    % Tổn thất đóng/mở
    P_sw(i) = 4 * 0.5 * U_supply * I_avg * t_sw * f_PWM;
    
    % Hiệu suất
    P_motor = D * U_supply * I_avg;
    P_loss_total = P_cond(i) + P_sw(i);
    eta_ESC(i) = P_motor / (P_motor + P_loss_total) * 100;
end

plot(Duty_range*100, eta_ESC, 'b-', 'LineWidth', 2);
hold on;
plot([0 100], [95 95], 'r--');
grid on;
xlabel('Duty Cycle (%)');
ylabel('Hiệu suất ESC (%)');
title('Hiệu suất ESC vs Duty Cycle');
ylim([90 100]);

%% Subplot 4: Tổn thất ESC

subplot(2, 3, 4);
plot(Duty_range*100, P_cond, 'r-', 'LineWidth', 2);
hold on;
plot(Duty_range*100, P_sw, 'b-', 'LineWidth', 2);
plot(Duty_range*100, P_cond+P_sw, 'k-', 'LineWidth', 2);
grid on;
xlabel('Duty Cycle (%)');
ylabel('Tổn thất (W)');
title('Tổn thất ESC');
legend('P_{dẫn}', 'P_{đóng/mở}', 'P_{tổng}', 'Location', 'Northwest');

%% Subplot 5: Hiệu suất toàn hệ thống

subplot(2, 3, 5);
hold on;

for idx = 1:length(U_levels)
    U = U_levels(idx);
    I_a_sys = M_load_range / K_m;
    omega_sys = (U - I_a_sys * R_a) / K_e;
    omega_sys(omega_sys<0) = 0;
    
    % Công suất ra
    P_out_sys = M_load_range .* omega_sys;
    
    % Tổn thất động cơ
    P_loss_motor = I_a_sys.^2 * R_a + P_friction + P_iron;
    
    % Tổn thất ESC (giả định D=0.8)
    P_loss_ESC = 4 * mean(I_a_sys)^2 * R_ds_on * 0.8 + ...
                  4 * 0.5 * U * mean(I_a_sys) * t_sw * f_PWM;
    
    % Công suất vào
    P_in_sys = P_out_sys + P_loss_motor + P_loss_ESC;
    
    % Hiệu suất toàn hệ thống
    eta_sys = P_out_sys ./ P_in_sys * 100;
    eta_sys(eta_sys<0) = 0;
    eta_sys(eta_sys>100) = 100;
    
    plot(M_load_range*1000, eta_sys, colors{idx}, 'LineWidth', 2);
end

grid on;
xlabel('Mô men tải (mN.m)');
ylabel('Hiệu suất toàn phần (%)');
title('Hiệu suất toàn hệ thống (Motor + ESC)');
legend('3.7V', '5.0V', '7.4V', '9.0V', 'Location', 'Best');
ylim([0 100]);

%% Subplot 6: Phân bố tổn thất

subplot(2, 3, 6);

% Tại điểm định mức
M_rated = 0.0265;  % N.m
I_rated = M_rated / K_m;
omega_rated = (U_supply - I_rated * R_a) / K_e;

P_out_rated = M_rated * omega_rated;
P_Cu_rated = I_rated^2 * R_a;
P_ESC_rated = 4 * I_rated^2 * R_ds_on * 0.8 + ...
              4 * 0.5 * U_supply * I_rated * t_sw * f_PWM;

losses = [P_Cu_rated, P_friction, P_iron, P_ESC_rated];
labels = {'Tổn thất Cu', 'Ma sát', 'Sắt từ', 'ESC'};
colors_pie = {'r', 'g', 'b', 'y'};

pie(losses, labels);
colormap(colors_pie);
title('Phân bố tổn thất @ định mức');

%% ========== PHÂN TÍCH ==========

fprintf('========== PHÂN TÍCH CHI TIẾT ==========\n\n');

fprintf('TẠI ĐIỂM ĐỊNH MỨC (M=%.1f mN.m):\n', M_rated*1000);
fprintf('  Công suất ra: %.2f W\n', P_out_rated);
fprintf('  Tổn thất Cu: %.2f W (%.1f%%)\n', P_Cu_rated, P_Cu_rated/P_out_rated*100);
fprintf('  Tổn thất cơ: %.2f W (%.1f%%)\n', P_friction, P_friction/P_out_rated*100);
fprintf('  Tổn thất sắt: %.2f W (%.1f%%)\n', P_iron, P_iron/P_out_rated*100);
fprintf('  Tổn thất ESC: %.2f W (%.1f%%)\n', P_ESC_rated, P_ESC_rated/P_out_rated*100);

P_total_loss_rated = P_Cu_rated + P_friction + P_iron + P_ESC_rated;
eta_total_rated = P_out_rated / (P_out_rated + P_total_loss_rated) * 100;

fprintf('  Tổn thất tổng: %.2f W\n', P_total_loss_rated);
fprintf('  Hiệu suất tổng: %.1f%%\n', eta_total_rated);
fprintf('\n');

fprintf('HIỆU SUẤT CÁC THÀNH PHẦN:\n');
eta_motor_only = P_out_rated / (P_out_rated + P_Cu_rated + P_friction + P_iron) * 100;
eta_ESC_only = (P_out_rated + P_Cu_rated + P_friction + P_iron) / ...
               (P_out_rated + P_total_loss_rated) * 100;
fprintf('  η động cơ: %.1f%%\n', eta_motor_only);
fprintf('  η ESC: %.1f%%\n', eta_ESC_only);
fprintf('  η tổng: %.1f%% (= η_motor × η_ESC)\n', eta_total_rated);
fprintf('\n');

fprintf('SO SÁNH VỚI CÁC PHƯƠNG PHÁP KHÁC:\n');
fprintf('  PWM (hiện tại): %.1f%%\n', eta_total_rated);
fprintf('  Điều chỉnh điện trở: ~40-50%%\n');
fprintf('  Điều chỉnh biến áp: ~60-70%%\n');
fprintf('  → PWM tốt nhất!\n');
fprintf('\n');

fprintf('TỐI ƯU HÓA:\n');
fprintf('  - Giảm R_a: Dùng dây đồng lớn hơn\n');
fprintf('  - Giảm R_ds: Dùng MOSFET tốt hơn (< 10mΩ)\n');
fprintf('  - Tăng f_PWM: Giảm dòng gợn sóng\n');
fprintf('  - Giảm ma sát: Bôi trơn tốt, bearing chất lượng\n');
fprintf('\n');

fprintf('========================================\n');

%% ========== LƯU KẾT QUẢ ==========

saveas(gcf, 'phan_tich_hieu_suat.png');
fprintf('\nĐã lưu: phan_tich_hieu_suat.png\n');

data.M_load_range = M_load_range;
data.eta_total_rated = eta_total_rated;
data.P_out_rated = P_out_rated;
data.losses = struct('Cu', P_Cu_rated, 'friction', P_friction, ...
                      'iron', P_iron, 'ESC', P_ESC_rated);
save('data_hieu_suat.mat', 'data');
fprintf('Đã lưu: data_hieu_suat.mat\n');


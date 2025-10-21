%% MÔ PHỎNG KHÂU MÁY PHÁT
% Mô phỏng máy phát nâng hạ gầu EKG-5A
% Tác giả: Hệ thống điều khiển máy xúc EKG-5A
% Ngày: 10/2025

clc; clear all; close all;

%% ========== THÔNG SỐ MÁY PHÁT ==========

% Thông số định mức
P_rated = 75000;        % Công suất định mức [W]
U_rated = 220;          % Điện áp định mức [V]
I_rated = 350;          % Dòng điện định mức [A]
n_rated = 1500;         % Tốc độ định mức [rpm]
omega_rated = n_rated * 2 * pi / 60;  % Tốc độ góc [rad/s]

% Thông số mạch điện
R_a = 0.05;             % Điện trở phần ứng [Ohm]
L_a = 0.005;            % Độ tự cảm phần ứng [H]
R_f = 50;               % Điện trở kích từ [Ohm]
L_f = 25;               % Độ tự cảm kích từ [H]

% Hằng số thời gian
T_f = L_f / R_f;        % Hằng số thời gian kích từ [s]
T_a = L_a / R_a;        % Hằng số thời gian phần ứng [s]

% Hằng số máy phát
C_e = 8;                % Hằng số EMF [V.min/Wb.vòng]
K_phi = 0.0198;         % Từ thông định mức [Wb]
K_e = C_e * K_phi * 2 * pi / 60;  % Hằng số EMF [V/(rad/s)]

% Thông số các cuộn kích từ
N_2 = 1000;             % Số vòng YCM-2 (điều khiển)
R_2 = 220;              % Điện trở YCM-2 [Ohm]
N_1 = 100;              % Số vòng YCM-1 (phản hồi)
alpha_1 = 0.1;          % Hệ số phân dòng YCM-1
N_6 = 600;              % Số vòng YCM-6 (độc lập)
U_6 = 110;              % Điện áp YCM-6 [V]
R_6 = 110;              % Điện trở YCM-6 [Ohm]

%% ========== TÍNH TOÁN CÁC THAM SỐ ==========

% Sức từ động YCM-6 (cố định)
I_6 = U_6 / R_6;
F_6 = N_6 * I_6;

% Hệ số chuyển đổi MMF sang từ thông
K_mmf_to_phi = K_phi / (N_2 * (U_rated / R_2) + F_6);  % [Wb/At]

fprintf('========== THÔNG SỐ MÁY PHÁT ==========\n');
fprintf('Công suất: %.0f kW\n', P_rated/1000);
fprintf('Điện áp định mức: %.0f V\n', U_rated);
fprintf('Dòng định mức: %.0f A\n', I_rated);
fprintf('Tốc độ: %.0f rpm (%.2f rad/s)\n', n_rated, omega_rated);
fprintf('Điện trở phần ứng R_a: %.3f Ohm\n', R_a);
fprintf('Điện trở kích từ R_f: %.0f Ohm\n', R_f);
fprintf('Hằng số thời gian kích từ T_f: %.3f s\n', T_f);
fprintf('Hằng số thời gian phần ứng T_a: %.3f s\n', T_a);
fprintf('Hằng số EMF K_e: %.3f V/(rad/s)\n', K_e);
fprintf('Sức từ động YCM-6 (F_6): %.0f At\n', F_6);
fprintf('=======================================\n\n');

%% ========== THIẾT LẬP MÔ PHỎNG ==========

t_sim = 3.0;            % Thời gian mô phỏng [s]
dt = 0.001;             % Bước thời gian [s]
t = 0:dt:t_sim;         % Vector thời gian

% Tốc độ máy phát (giả sử ổn định)
omega = omega_rated * ones(size(t));

% Tín hiệu điều khiển U_2 (điện áp vào YCM-2)
U_2 = zeros(size(t));
U_2(t >= 0.0 & t < 0.5) = 0;
U_2(t >= 0.5 & t < 1.5) = 110;   % 50%
U_2(t >= 1.5 & t < 2.5) = 220;   % 100%
U_2(t >= 2.5) = 150;             % Giảm xuống

% Dòng tải (thay đổi theo thời gian)
I_load = zeros(size(t));
I_load(t >= 0.0 & t < 1.0) = 0;
I_load(t >= 1.0 & t < 2.0) = 175;    % 50% tải
I_load(t >= 2.0) = 350;              % 100% tải

%% ========== MÔ PHỎNG ==========

% Khởi tạo biến
I_f = zeros(size(t));       % Dòng kích từ
Phi = zeros(size(t));       % Từ thông
E_a = zeros(size(t));       % Sức điện động
U_out = zeros(size(t));     % Điện áp đầu ra
F_2 = zeros(size(t));       % MMF YCM-2
F_1 = zeros(size(t));       % MMF YCM-1
F_total = zeros(size(t));   % MMF tổng

% Điều kiện đầu
I_f_temp = 0;
Phi_temp = 0;

fprintf('Đang mô phỏng...\n');

for i = 1:length(t)
    % Tính MMF các cuộn
    I_2 = U_2(i) / R_2;
    F_2(i) = N_2 * I_2;
    
    I_1 = alpha_1 * I_load(i);
    F_1(i) = N_1 * I_1;
    
    % MMF tổng
    F_total(i) = F_2(i) - F_1(i) + F_6;
    
    % Phương trình vi phân dòng kích từ (đơn giản hóa)
    % dI_f/dt = (F_total - R_f*I_f) / L_f
    % Hoặc dùng từ thông trực tiếp
    
    % Từ thông mục tiêu từ MMF
    Phi_target = K_mmf_to_phi * F_total(i);
    
    % Áp dụng bão hòa từ
    Phi_sat_level = K_phi * 1.3;  % Mức bão hòa 130%
    Phi_target = Phi_sat_level * tanh(Phi_target / Phi_sat_level);
    
    % Phương trình vi phân từ thông (T_f)
    dPhi_dt = (Phi_target - Phi_temp) / T_f;
    Phi_temp = Phi_temp + dPhi_dt * dt;
    Phi(i) = Phi_temp;
    
    % Sức điện động
    E_a(i) = K_e * omega(i) * (Phi(i) / K_phi);
    
    % Điện áp đầu ra (trừ điện áp rơi trên R_a)
    U_out(i) = E_a(i) - I_load(i) * R_a;
    
    % Giới hạn điện áp không âm
    if U_out(i) < 0
        U_out(i) = 0;
    end
end

fprintf('Hoàn thành mô phỏng!\n\n');

%% ========== VẼ ĐỒ THỊ ==========

figure('Name', 'Mô phỏng máy phát', 'Position', [100, 100, 1400, 1000]);

% Subplot 1: Tín hiệu điều khiển U_2
subplot(3, 4, 1);
plot(t, U_2, 'b-', 'LineWidth', 2);
grid on;
xlabel('Thời gian (s)');
ylabel('Điện áp (V)');
title('Tín hiệu điều khiển U_2 (YCM-2)');
ylim([0 250]);

% Subplot 2: Dòng tải
subplot(3, 4, 2);
plot(t, I_load, 'r-', 'LineWidth', 2);
grid on;
xlabel('Thời gian (s)');
ylabel('Dòng điện (A)');
title('Dòng tải I_{load}');
ylim([0 400]);

% Subplot 3: MMF các cuộn
subplot(3, 4, 3);
plot(t, F_2, 'b-', 'LineWidth', 1.5);
hold on;
plot(t, F_1, 'r-', 'LineWidth', 1.5);
plot(t, F_6*ones(size(t)), 'g--', 'LineWidth', 1.5);
grid on;
xlabel('Thời gian (s)');
ylabel('MMF (At)');
title('Sức từ động các cuộn');
legend('F_2 (YCM-2)', 'F_1 (YCM-1)', 'F_6 (YCM-6)', 'Location', 'Best');

% Subplot 4: MMF tổng
subplot(3, 4, 4);
plot(t, F_total, 'k-', 'LineWidth', 2);
grid on;
xlabel('Thời gian (s)');
ylabel('MMF (At)');
title('Sức từ động tổng F_{total}');

% Subplot 5: Từ thông
subplot(3, 4, 5);
plot(t, Phi*1000, 'g-', 'LineWidth', 2);
hold on;
plot([0 t_sim], [K_phi*1000 K_phi*1000], 'r--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (s)');
ylabel('Từ thông (mWb)');
title('Từ thông Φ');
legend('Φ', 'Φ_{định mức}', 'Location', 'Southeast');

% Subplot 6: Sức điện động E_a
subplot(3, 4, 6);
plot(t, E_a, 'm-', 'LineWidth', 2);
hold on;
plot([0 t_sim], [U_rated U_rated], 'k--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (s)');
ylabel('Điện áp (V)');
title('Sức điện động E_a');
legend('E_a', 'U_{định mức}', 'Location', 'Southeast');

% Subplot 7: Điện áp đầu ra
subplot(3, 4, 7);
plot(t, U_out, 'r-', 'LineWidth', 2);
hold on;
plot([0 t_sim], [U_rated U_rated], 'k--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (s)');
ylabel('Điện áp (V)');
title('Điện áp đầu ra U_{out}');
legend('U_{out}', 'U_{định mức}', 'Location', 'Best');

% Subplot 8: Điện áp rơi
subplot(3, 4, 8);
U_drop = I_load * R_a;
plot(t, U_drop, 'b-', 'LineWidth', 2);
grid on;
xlabel('Thời gian (s)');
ylabel('Điện áp (V)');
title('Điện áp rơi ΔU = I_{load} × R_a');

% Subplot 9: Đặc tính ngoài (U vs I)
subplot(3, 4, 9);
idx_1_5s = find(t >= 1.5 & t < 2.5);
scatter(I_load(idx_1_5s), U_out(idx_1_5s), 10, 'b', 'filled');
hold on;
idx_2_5s = find(t >= 2.5);
scatter(I_load(idx_2_5s), U_out(idx_2_5s), 10, 'r', 'filled');
grid on;
xlabel('Dòng tải (A)');
ylabel('Điện áp (V)');
title('Đặc tính ngoài U = f(I)');
legend('U_2 = 220V', 'U_2 = 150V', 'Location', 'Southwest');

% Subplot 10: Đặc tính điều chỉnh (U vs U_2)
subplot(3, 4, 10);
idx_no_load = find(I_load == 0);
scatter(U_2(idx_no_load), U_out(idx_no_load), 10, 'g', 'filled');
hold on;
idx_half_load = find(I_load == 175);
scatter(U_2(idx_half_load), U_out(idx_half_load), 10, 'b', 'filled');
idx_full_load = find(I_load == 350);
scatter(U_2(idx_full_load), U_out(idx_full_load), 10, 'r', 'filled');
grid on;
xlabel('U_2 điều khiển (V)');
ylabel('U_{out} (V)');
title('Đặc tính điều chỉnh');
legend('Không tải', 'Tải 50%', 'Tải 100%', 'Location', 'Southeast');

% Subplot 11: Công suất
subplot(3, 4, 11);
P_out = U_out .* I_load / 1000;  % kW
plot(t, P_out, 'r-', 'LineWidth', 2);
hold on;
plot([0 t_sim], [P_rated/1000 P_rated/1000], 'k--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (s)');
ylabel('Công suất (kW)');
title('Công suất đầu ra P_{out}');
legend('P_{out}', 'P_{định mức}', 'Location', 'Northwest');

% Subplot 12: Bảng thông tin
subplot(3, 4, 12);
axis off;

% Tính toán một số chỉ số
idx_1s = find(t >= 1.0, 1);
idx_2s = find(t >= 2.0, 1);
U_regulation = (U_out(idx_1s) - U_out(idx_2s)) / U_rated * 100;

str_info = {
    'THÔNG SỐ VẬN HÀNH:'
    ' '
    sprintf('Tốc độ: %.0f rpm', n_rated)
    sprintf('T_f: %.2f s', T_f)
    ' '
    'TẠI t = 1.5s (50%% tải):'
    sprintf('  U_2: %.0f V', U_2(idx_1s))
    sprintf('  I_load: %.0f A', I_load(idx_1s))
    sprintf('  U_out: %.1f V', U_out(idx_1s))
    sprintf('  P_out: %.1f kW', P_out(idx_1s))
    ' '
    'TẠI t = 2.5s (100%% tải):'
    sprintf('  U_2: %.0f V', U_2(idx_2s))
    sprintf('  I_load: %.0f A', I_load(idx_2s))
    sprintf('  U_out: %.1f V', U_out(idx_2s))
    sprintf('  P_out: %.1f kW', P_out(idx_2s))
    ' '
    'ĐẶC TÍNH:'
    sprintf('  Độ điều áp: %.1f%%', U_regulation)
    sprintf('  F_6 (cố định): %.0f At', F_6)
};
text(0.05, 0.95, str_info, 'VerticalAlignment', 'top', 'FontSize', 9, 'FontName', 'Courier');

%% ========== PHÂN TÍCH KẾT QUẢ ==========

fprintf('========== KẾT QUẢ MÔ PHỎNG ==========\n\n');

fprintf('ĐIỂM LÀM VIỆC QUAN TRỌNG:\n');
fprintf('\n1. t = 1.0s (U_2 = 110V, I_load = 175A):\n');
idx = find(t >= 1.0, 1);
fprintf('   F_total = %.0f At\n', F_total(idx));
fprintf('   Phi = %.2f mWb\n', Phi(idx)*1000);
fprintf('   E_a = %.1f V\n', E_a(idx));
fprintf('   U_out = %.1f V\n', U_out(idx));
fprintf('   P_out = %.1f kW\n', P_out(idx));

fprintf('\n2. t = 2.0s (U_2 = 220V, I_load = 350A):\n');
idx = find(t >= 2.0, 1);
fprintf('   F_total = %.0f At\n', F_total(idx));
fprintf('   Phi = %.2f mWb\n', Phi(idx)*1000);
fprintf('   E_a = %.1f V\n', E_a(idx));
fprintf('   U_out = %.1f V\n', U_out(idx));
fprintf('   P_out = %.1f kW\n', P_out(idx));

fprintf('\n3. t = 2.8s (U_2 = 150V, I_load = 350A):\n');
idx = find(t >= 2.8, 1);
fprintf('   F_total = %.0f At\n', F_total(idx));
fprintf('   Phi = %.2f mWb\n', Phi(idx)*1000);
fprintf('   E_a = %.1f V\n', E_a(idx));
fprintf('   U_out = %.1f V\n', U_out(idx));
fprintf('   P_out = %.1f kW\n', P_out(idx));

fprintf('\nĐỘ ĐIỀU ÁP:\n');
idx_no_load = find(t >= 1.5 & t < 1.6 & I_load == 0, 1);
idx_full_load = find(t >= 2.5 & t < 2.6 & I_load == 350, 1);
if ~isempty(idx_no_load) && ~isempty(idx_full_load)
    delta_U = (U_out(idx_no_load) - U_out(idx_full_load)) / U_rated * 100;
    fprintf('   ΔU%% = %.1f%% (không tải → tải đầy)\n', delta_U);
end

fprintf('\n======================================\n');

%% ========== LƯU KẾT QUẢ ==========

saveas(gcf, 'mo_phong_khau_may_phat.png');
fprintf('\nĐã lưu đồ thị vào file: mo_phong_khau_may_phat.png\n');

save('data_khau_may_phat.mat', 't', 'U_2', 'I_load', 'F_2', 'F_1', 'F_6', 'F_total', ...
     'Phi', 'E_a', 'U_out', 'P_out', 'omega');
fprintf('Đã lưu dữ liệu vào file: data_khau_may_phat.mat\n');

fprintf('\n========== HOÀN THÀNH MÔ PHỎNG ==========\n');


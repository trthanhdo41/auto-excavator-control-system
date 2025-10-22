%% MÔ PHỎNG KHÂU ĐỘNG CƠ
% Mô phỏng động cơ DC nâng hạ gầu Huina 1592
% Tác giả: Hệ thống điều khiển máy xúc Huina 1592
% Ngày: 10/2025

clc; clear all; close all;

%% ========== THÔNG SỐ ĐỘNG CƠ ==========
% Động cơ: 540/550 Brushed DC Motor (Huina 1592)

% Thông số định mức (RC Model - scaled down)
P_rated = 30;           % Công suất [W] (not 75kW!)
U_rated = 7.4;          % Điện áp [V] (7.4V Li-ion 2S)
I_rated = 4;            % Dòng điện [A]
n_no_load = 12000;      % Tốc độ không tải [rpm]
n_rated = 8000;         % Tốc độ có tải [rpm]
omega_rated = n_rated * 2 * pi / 60;  % Tốc độ góc [rad/s]
M_rated = P_rated / omega_rated;      % Mô men [N.m] ~ 0.035 N.m

% Thông số điện (RC Motor)
R_a = 0.8;              % Điện trở phần ứng [Ohm]
L_a = 0.0002;           % Độ tự cảm phần ứng [H] = 0.2 mH
R_f = 20;               % Điện trở kích từ (nếu có) [Ohm]

% Thông số cơ (RC Scale)
J_motor = 0.00005;      % Mô men đà động cơ [kg.m²] (rất nhỏ)
J_load = 0.0002;        % Mô men đà tải (gầu + vật xúc) [kg.m²]
J_total = J_motor + J_load;  % Mô men đà tổng [kg.m²]
B = 0.0001;             % Hệ số ma sát nhớt [N.m.s/rad] (nhỏ)

% Hằng số động cơ
E_a_rated = U_rated - I_rated * R_a;
K_e_prime = E_a_rated / omega_rated;  % Hằng số EMF [V/(rad/s)]
K_m_prime = M_rated / I_rated;        % Hằng số mô men [N.m/A]

% Hằng số thời gian
T_a = L_a / R_a;        % Hằng số thời gian điện [s]
T_m = (J_total * R_a) / (K_e_prime * K_m_prime);  % Hằng số thời gian cơ [s]

fprintf('========== THÔNG SỐ ĐỘNG CƠ ==========\n');
fprintf('Công suất: %.0f kW\n', P_rated/1000);
fprintf('Điện áp định mức: %.0f V\n', U_rated);
fprintf('Dòng định mức: %.0f A\n', I_rated);
fprintf('Tốc độ định mức: %.0f rpm (%.2f rad/s)\n', n_rated, omega_rated);
fprintf('Mô men định mức: %.1f N.m\n', M_rated);
fprintf('\nThông số điện:\n');
fprintf('  R_a: %.3f Ohm\n', R_a);
fprintf('  L_a: %.3f H\n', L_a);
fprintf('  T_a: %.3f s = %.1f ms\n', T_a, T_a*1000);
fprintf('\nThông số cơ:\n');
fprintf('  J_total: %.1f kg.m²\n', J_total);
fprintf('  B: %.2f N.m.s/rad\n', B);
fprintf('  T_m: %.3f s = %.1f ms\n', T_m, T_m*1000);
fprintf('\nHằng số động cơ:\n');
fprintf('  K_e: %.3f V/(rad/s)\n', K_e_prime);
fprintf('  K_m: %.3f N.m/A\n', K_m_prime);
fprintf('=======================================\n\n');

%% ========== THIẾT LẬP MÔ PHỎNG ==========

t_sim = 5.0;            % Thời gian mô phỏng [s]
dt = 0.0001;            % Bước thời gian [s]
t = 0:dt:t_sim;         % Vector thời gian

% Điện áp đầu vào (từ ESC - Electronic Speed Controller)
U_in = zeros(size(t));
U_in(t >= 0.0 & t < 0.5) = 0;
U_in(t >= 0.5 & t < 2.0) = 3.7;      % 50% điện áp (1S)
U_in(t >= 2.0 & t < 3.5) = 7.4;      % 100% điện áp (2S)
U_in(t >= 3.5) = 5.0;                % Giảm xuống

% Mô men tải (thay đổi)
M_load = zeros(size(t));
M_load(t >= 0.0 & t < 1.5) = 0;      % Không tải
M_load(t >= 1.5 & t < 3.0) = M_rated * 0.5;   % 50% tải
M_load(t >= 3.0) = M_rated;          % 100% tải

%% ========== MÔ PHỎNG ==========

% Khởi tạo biến
I_a = zeros(size(t));       % Dòng điện phần ứng
omega = zeros(size(t));     % Tốc độ góc
n = zeros(size(t));         % Tốc độ (rpm)
M_em = zeros(size(t));      % Mô men điện từ
E_a = zeros(size(t));       % Sức phản điện động
P_in = zeros(size(t));      % Công suất điện vào
P_out = zeros(size(t));     % Công suất cơ ra

% Điều kiện đầu
I_a_temp = 0;
omega_temp = 0;

fprintf('Đang mô phỏng động cơ...\n');

for i = 1:length(t)
    % Sức phản điện động
    E_a(i) = K_e_prime * omega_temp;
    
    % Phương trình vi phân dòng điện
    % L_a * dI_a/dt = U_in - R_a*I_a - E_a
    dI_a_dt = (U_in(i) - R_a * I_a_temp - E_a(i)) / L_a;
    I_a_temp = I_a_temp + dI_a_dt * dt;
    
    % Giới hạn dòng (bảo vệ quá dòng)
    if I_a_temp > 2 * I_rated
        I_a_temp = 2 * I_rated;
    end
    if I_a_temp < 0
        I_a_temp = 0;
    end
    I_a(i) = I_a_temp;
    
    % Mô men điện từ
    M_em(i) = K_m_prime * I_a(i);
    
    % Phương trình vi phân tốc độ
    % J * dω/dt = M_em - M_load - B*ω
    d_omega_dt = (M_em(i) - M_load(i) - B * omega_temp) / J_total;
    omega_temp = omega_temp + d_omega_dt * dt;
    
    % Giới hạn tốc độ (không âm)
    if omega_temp < 0
        omega_temp = 0;
    end
    omega(i) = omega_temp;
    n(i) = omega(i) * 60 / (2 * pi);
    
    % Công suất
    P_in(i) = U_in(i) * I_a(i);
    P_out(i) = M_em(i) * omega(i);
end

fprintf('Hoàn thành mô phỏng!\n\n');

% Tính hiệu suất
eta = zeros(size(t));
idx_valid = P_in > 100;  % Chỉ tính khi P_in đủ lớn
eta(idx_valid) = P_out(idx_valid) ./ P_in(idx_valid) * 100;

%% ========== VẼ ĐỒ THỊ ==========

figure('Name', 'Mô phỏng động cơ', 'Position', [100, 100, 1400, 1000]);

% Subplot 1: Điện áp đầu vào
subplot(3, 4, 1);
plot(t, U_in, 'b-', 'LineWidth', 2);
grid on;
xlabel('Thời gian (s)');
ylabel('Điện áp (V)');
title('Điện áp đầu vào U_{in}');
ylim([0 250]);

% Subplot 2: Dòng điện phần ứng
subplot(3, 4, 2);
plot(t, I_a, 'r-', 'LineWidth', 2);
hold on;
plot([0 t_sim], [I_rated I_rated], 'k--', 'LineWidth', 1);
plot([0 t_sim], [2*I_rated 2*I_rated], 'r--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (s)');
ylabel('Dòng điện (A)');
title('Dòng điện phần ứng I_a');
legend('I_a', 'I_{định mức}', 'Giới hạn 2×I_{đm}', 'Location', 'Best');

% Subplot 3: Tốc độ (rpm)
subplot(3, 4, 3);
plot(t, n, 'g-', 'LineWidth', 2);
hold on;
plot([0 t_sim], [n_rated n_rated], 'k--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (s)');
ylabel('Tốc độ (rpm)');
title('Tốc độ động cơ n');
legend('n', 'n_{định mức}', 'Location', 'Best');

% Subplot 4: Tốc độ góc (rad/s)
subplot(3, 4, 4);
plot(t, omega, 'm-', 'LineWidth', 2);
hold on;
plot([0 t_sim], [omega_rated omega_rated], 'k--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (s)');
ylabel('Tốc độ góc (rad/s)');
title('Tốc độ góc ω');
legend('ω', 'ω_{định mức}', 'Location', 'Best');

% Subplot 5: Mô men điện từ
subplot(3, 4, 5);
plot(t, M_em, 'b-', 'LineWidth', 2);
hold on;
plot([0 t_sim], [M_rated M_rated], 'k--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (s)');
ylabel('Mô men (N.m)');
title('Mô men điện từ M_{em}');
legend('M_{em}', 'M_{định mức}', 'Location', 'Best');

% Subplot 6: Mô men tải
subplot(3, 4, 6);
plot(t, M_load, 'r-', 'LineWidth', 2);
hold on;
plot([0 t_sim], [M_rated M_rated], 'k--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (s)');
ylabel('Mô men (N.m)');
title('Mô men tải M_{load}');
legend('M_{load}', 'M_{định mức}', 'Location', 'Northwest');

% Subplot 7: Sức phản điện động
subplot(3, 4, 7);
plot(t, E_a, 'c-', 'LineWidth', 2);
hold on;
plot([0 t_sim], [E_a_rated E_a_rated], 'k--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (s)');
ylabel('Điện áp (V)');
title('Sức phản điện động E_a');
legend('E_a', 'E_a định mức', 'Location', 'Best');

% Subplot 8: Công suất
subplot(3, 4, 8);
plot(t, P_in/1000, 'b-', 'LineWidth', 1.5);
hold on;
plot(t, P_out/1000, 'r-', 'LineWidth', 1.5);
plot([0 t_sim], [P_rated/1000 P_rated/1000], 'k--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (s)');
ylabel('Công suất (kW)');
title('Công suất');
legend('P_{in} (điện)', 'P_{out} (cơ)', 'P_{định mức}', 'Location', 'Best');

% Subplot 9: Đặc tính cơ n = f(M)
subplot(3, 4, 9);
idx_110V = find(t >= 1.0 & t < 2.0);
scatter(M_em(idx_110V), n(idx_110V), 5, 'b', 'filled');
hold on;
idx_220V = find(t >= 2.5 & t < 3.5);
scatter(M_em(idx_220V), n(idx_220V), 5, 'r', 'filled');
idx_150V = find(t >= 4.0);
scatter(M_em(idx_150V), n(idx_150V), 5, 'g', 'filled');
grid on;
xlabel('Mô men (N.m)');
ylabel('Tốc độ (rpm)');
title('Đặc tính cơ n = f(M)');
legend('U = 110V', 'U = 220V', 'U = 150V', 'Location', 'Northeast');

% Subplot 10: Đặc tính n = f(I_a)
subplot(3, 4, 10);
scatter(I_a(idx_110V), n(idx_110V), 5, 'b', 'filled');
hold on;
scatter(I_a(idx_220V), n(idx_220V), 5, 'r', 'filled');
scatter(I_a(idx_150V), n(idx_150V), 5, 'g', 'filled');
grid on;
xlabel('Dòng điện (A)');
ylabel('Tốc độ (rpm)');
title('Đặc tính n = f(I_a)');
legend('U = 110V', 'U = 220V', 'U = 150V', 'Location', 'Northeast');

% Subplot 11: Hiệu suất
subplot(3, 4, 11);
plot(t, eta, 'k-', 'LineWidth', 2);
grid on;
xlabel('Thời gian (s)');
ylabel('Hiệu suất (%)');
title('Hiệu suất η = P_{out}/P_{in}');
ylim([0 105]);

% Subplot 12: Bảng thông tin
subplot(3, 4, 12);
axis off;

% Tính toán một số chỉ số quan trọng
idx_1s = find(t >= 1.0, 1);
idx_2_5s = find(t >= 2.5, 1);
idx_3_5s = find(t >= 3.5, 1);

% Thời gian khởi động (đạt 90% tốc độ)
idx_startup = find(n >= 0.9 * max(n(t >= 0.5 & t < 1.0)), 1);
t_startup = t(idx_startup) - 0.5;

str_info = {
    'THÔNG SỐ VẬN HÀNH:'
    ' '
    'Thời gian khởi động:'
    sprintf('  t_{90%%}: %.3f s', t_startup)
    ' '
    'TẠI t = 1.0s (U=110V, 50%% tải):'
    sprintf('  I_a: %.0f A', I_a(idx_1s))
    sprintf('  n: %.0f rpm', n(idx_1s))
    sprintf('  M_em: %.0f N.m', M_em(idx_1s))
    sprintf('  η: %.1f%%', eta(idx_1s))
    ' '
    'TẠI t = 2.5s (U=220V, tải đầy):'
    sprintf('  I_a: %.0f A', I_a(idx_2_5s))
    sprintf('  n: %.0f rpm', n(idx_2_5s))
    sprintf('  M_em: %.0f N.m', M_em(idx_2_5s))
    sprintf('  η: %.1f%%', eta(idx_2_5s))
    ' '
    'TẠI t = 4.0s (U=150V, tải đầy):'
    sprintf('  I_a: %.0f A', I_a(idx_3_5s))
    sprintf('  n: %.0f rpm', n(idx_3_5s))
    sprintf('  M_em: %.0f N.m', M_em(idx_3_5s))
    sprintf('  η: %.1f%%', eta(idx_3_5s))
};
text(0.05, 0.95, str_info, 'VerticalAlignment', 'top', 'FontSize', 9, 'FontName', 'Courier');

%% ========== PHÂN TÍCH ĐẶC TÍNH CƠ ==========

% Tính đặc tính cơ lý thuyết
M_theory = 0:10:M_rated*1.2;

% Tốc độ không tải và độ dốc
for u_val = [110, 220, 150]
    n0 = u_val / (K_e_prime * 2*pi/60);  % Tốc độ không tải
    delta_n = R_a / (K_e_prime * K_m_prime * 2*pi/60);  % Độ dốc
    n_theory = n0 - delta_n * M_theory;
    
    % (Chỉ hiển thị, không vẽ lại)
end

%% ========== PHÂN TÍCH KẾT QUẢ ==========

fprintf('========== KẾT QUẢ MÔ PHỎNG ==========\n\n');

fprintf('THỜI GIAN QUÁ ĐỘ:\n');
fprintf('  Thời gian khởi động (90%% tốc độ): %.3f s\n', t_startup);
fprintf('  Thời gian xác lập (99%%): %.3f s\n', 5*T_m);

fprintf('\nĐIỂM LÀM VIỆC t = 1.0s (U = 110V, M_load = 0):\n');
idx = idx_1s;
fprintf('  Dòng điện: %.1f A (%.0f%% I_đm)\n', I_a(idx), I_a(idx)/I_rated*100);
fprintf('  Tốc độ: %.0f rpm (%.0f%% n_đm)\n', n(idx), n(idx)/n_rated*100);
fprintf('  Mô men: %.0f N.m\n', M_em(idx));
fprintf('  Công suất: %.1f kW\n', P_out(idx)/1000);
fprintf('  Hiệu suất: %.1f%%\n', eta(idx));

fprintf('\nĐIỂM LÀM VIỆC t = 2.5s (U = 220V, M_load = M_rated):\n');
idx = idx_2_5s;
fprintf('  Dòng điện: %.1f A (%.0f%% I_đm)\n', I_a(idx), I_a(idx)/I_rated*100);
fprintf('  Tốc độ: %.0f rpm (%.0f%% n_đm)\n', n(idx), n(idx)/n_rated*100);
fprintf('  Mô men: %.0f N.m (%.0f%% M_đm)\n', M_em(idx), M_em(idx)/M_rated*100);
fprintf('  Công suất: %.1f kW\n', P_out(idx)/1000);
fprintf('  Hiệu suất: %.1f%%\n', eta(idx));

fprintf('\nĐỘ SỤT TỐC:\n');
idx_no_load_220 = find(t >= 2.0 & t < 2.1, 1);
idx_full_load_220 = find(t >= 4.5, 1);
delta_n_percent = (n(idx_no_load_220) - n(idx_full_load_220)) / n_rated * 100;
fprintf('  Từ không tải → tải đầy: %.1f%%\n', delta_n_percent);

fprintf('\nHIỆU SUẤT TỐI ĐA:\n');
fprintf('  η_max = %.1f%% (tại tải %.0f%%)\n', max(eta), ...
    M_em(eta == max(eta))/M_rated*100);

fprintf('\n======================================\n');

%% ========== LƯU KẾT QUẢ ==========

saveas(gcf, 'mo_phong_khau_dong_co.png');
fprintf('\nĐã lưu đồ thị vào file: mo_phong_khau_dong_co.png\n');

save('data_khau_dong_co.mat', 't', 'U_in', 'I_a', 'omega', 'n', 'M_em', 'M_load', ...
     'E_a', 'P_in', 'P_out', 'eta');
fprintf('Đã lưu dữ liệu vào file: data_khau_dong_co.mat\n');

fprintf('\n========== HOÀN THÀNH MÔ PHỎNG ==========\n');


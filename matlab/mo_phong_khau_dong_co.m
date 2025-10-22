%% MÔ PHỎNG ĐỘNG CƠ DC HUINA 1592
% Mô phỏng động cơ 540/550 Brushed DC Motor
% Tác giả: Hệ thống điều khiển máy xúc Huina 1592
% Ngày: 10/2025

clc; clear all; close all;

%% ========== THÔNG SỐ ĐỘNG CƠ ==========
% Động cơ: 540/550 Brushed DC Motor (Huina 1592)

fprintf('========== THÔNG SỐ ĐỘNG CƠ HUINA 1592 ==========\n');
fprintf('Loại động cơ: 540/550 Brushed DC Motor\n');
fprintf('Nguồn điện: 7.4V Li-ion 2S\n\n');

% Thông số định mức (RC Model)
P_rated = 30;           % Công suất [W]
U_rated = 7.4;          % Điện áp [V] (7.4V Li-ion 2S)
I_rated = 4;            % Dòng điện [A]
n_no_load = 12000;      % Tốc độ không tải [rpm]
n_rated = 8000;         % Tốc độ có tải [rpm]
omega_rated = n_rated * 2 * pi / 60;  % Tốc độ góc [rad/s]
M_rated = P_rated / omega_rated;      % Mô men [N.m]

% Thông số điện (RC Motor)
R_a = 0.8;              % Điện trở phần ứng [Ohm]
L_a = 0.0002;           % Độ tự cảm phần ứng [H] = 0.2 mH
R_f = 20;               % Điện trở kích từ (nếu có) [Ohm]

% Thông số cơ (RC Scale)
J_motor = 0.00005;      % Mô men đà động cơ [kg.m²]
J_load = 0.0002;        % Mô men đà tải (gầu + vật xúc) [kg.m²]
J_total = J_motor + J_load;  % Mô men đà tổng [kg.m²]
B = 0.0001;             % Hệ số ma sát nhớt [N.m.s/rad]

% Hằng số động cơ
E_a_rated = U_rated - I_rated * R_a;
K_e_prime = E_a_rated / omega_rated;  % Hằng số EMF [V/(rad/s)]
K_m_prime = M_rated / I_rated;        % Hằng số mô men [N.m/A]

% Hằng số thời gian
T_a = L_a / R_a;        % Hằng số thời gian điện [s]
T_m = (J_total * R_a) / (K_e_prime * K_m_prime);  % Hằng số thời gian cơ [s]

fprintf('THÔNG SỐ ĐIỆN:\n');
fprintf('  Điện áp định mức: %.1f V\n', U_rated);
fprintf('  Dòng định mức: %.0f A\n', I_rated);
fprintf('  Công suất: %.0f W\n', P_rated);
fprintf('  R_a: %.2f Ω\n', R_a);
fprintf('  L_a: %.2f mH\n', L_a*1000);
fprintf('  T_a: %.2f ms\n', T_a*1000);
fprintf('\nTHÔNG SỐ CƠ:\n');
fprintf('  Tốc độ không tải: %.0f rpm\n', n_no_load);
fprintf('  Tốc độ định mức: %.0f rpm (%.1f rad/s)\n', n_rated, omega_rated);
fprintf('  Mô men định mức: %.4f N.m\n', M_rated);
fprintf('  J_total: %.6f kg.m²\n', J_total);
fprintf('  T_m: %.1f ms\n', T_m*1000);
fprintf('\nHẰNG SỐ ĐỘNG CƠ:\n');
fprintf('  K_e: %.5f V/(rad/s)\n', K_e_prime);
fprintf('  K_m: %.5f N.m/A\n', K_m_prime);
fprintf('===============================================\n\n');

%% ========== THIẾT LẬP MÔ PHỎNG ==========

t_sim = 3.0;            % Thời gian mô phỏng [s]
dt = 0.0001;            % Bước thời gian [s]
t = 0:dt:t_sim;         % Vector thời gian

% Điện áp đầu vào (PWM từ ESC)
U_in = zeros(size(t));
U_in(t >= 0.0 & t < 0.3) = 0;
U_in(t >= 0.3 & t < 1.2) = 3.7;      % 50% (1S)
U_in(t >= 1.2 & t < 2.2) = 7.4;      % 100% (2S)
U_in(t >= 2.2) = 5.0;                % Giảm xuống

% Mô men tải (gầu + vật xúc)
M_load = zeros(size(t));
M_load(t >= 0.0 & t < 0.8) = 0;                  % Không tải
M_load(t >= 0.8 & t < 1.8) = M_rated * 0.5;      % 50% tải
M_load(t >= 1.8) = M_rated;                      % 100% tải

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
    I_max = 2 * I_rated;  % 8A
    if I_a_temp > I_max
        I_a_temp = I_max;
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
idx_valid = P_in > 1;  % Chỉ tính khi P_in đủ lớn
eta(idx_valid) = P_out(idx_valid) ./ P_in(idx_valid) * 100;

%% ========== VẼ ĐỒ THỊ ==========

figure('Name', 'Mô phỏng động cơ Huina 1592', 'Position', [50, 50, 1400, 900]);

% Subplot 1: Điện áp đầu vào
subplot(3, 4, 1);
plot(t, U_in, 'b-', 'LineWidth', 2);
grid on;
xlabel('Thời gian (s)');
ylabel('Điện áp (V)');
title('Điện áp PWM');
ylim([0 8]);

% Subplot 2: Dòng điện
subplot(3, 4, 2);
plot(t, I_a, 'r-', 'LineWidth', 2);
hold on;
plot([0 t_sim], [I_rated I_rated], 'k--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (s)');
ylabel('Dòng điện (A)');
title('Dòng điện I_a');
legend('I_a', 'I_{định mức}', 'Location', 'Best');

% Subplot 3: Tốc độ (rpm)
subplot(3, 4, 3);
plot(t, n, 'g-', 'LineWidth', 2);
hold on;
plot([0 t_sim], [n_rated n_rated], 'k--', 'LineWidth', 1);
plot([0 t_sim], [n_no_load n_no_load], 'b--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (s)');
ylabel('Tốc độ (rpm)');
title('Tốc độ động cơ');
legend('n', 'n_{rated}', 'n_{no-load}', 'Location', 'Best');

% Subplot 4: Tốc độ góc
subplot(3, 4, 4);
plot(t, omega, 'm-', 'LineWidth', 2);
hold on;
plot([0 t_sim], [omega_rated omega_rated], 'k--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (s)');
ylabel('Tốc độ (rad/s)');
title('Tốc độ góc ω');

% Subplot 5: Mô men điện từ
subplot(3, 4, 5);
plot(t, M_em*1000, 'b-', 'LineWidth', 2);
hold on;
plot([0 t_sim], [M_rated*1000 M_rated*1000], 'k--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (s)');
ylabel('Mô men (mN.m)');
title('Mô men điện từ');

% Subplot 6: Mô men tải
subplot(3, 4, 6);
plot(t, M_load*1000, 'r-', 'LineWidth', 2);
hold on;
plot([0 t_sim], [M_rated*1000 M_rated*1000], 'k--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (s)');
ylabel('Mô men (mN.m)');
title('Mô men tải');

% Subplot 7: Sức phản điện động
subplot(3, 4, 7);
plot(t, E_a, 'c-', 'LineWidth', 2);
hold on;
plot([0 t_sim], [E_a_rated E_a_rated], 'k--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (s)');
ylabel('Điện áp (V)');
title('Sức phản điện động E_a');

% Subplot 8: Công suất
subplot(3, 4, 8);
plot(t, P_in, 'b-', 'LineWidth', 1.5);
hold on;
plot(t, P_out, 'r-', 'LineWidth', 1.5);
plot([0 t_sim], [P_rated P_rated], 'k--', 'LineWidth', 1);
grid on;
xlabel('Thời gian (s)');
ylabel('Công suất (W)');
title('Công suất');
legend('P_{in}', 'P_{out}', 'P_{rated}', 'Location', 'Best');

% Subplot 9: Đặc tính cơ n = f(M)
subplot(3, 4, 9);
idx_3_7V = find(t >= 0.5 & t < 1.2);
scatter(M_em(idx_3_7V)*1000, n(idx_3_7V), 5, 'b', 'filled');
hold on;
idx_7_4V = find(t >= 1.5 & t < 2.2);
scatter(M_em(idx_7_4V)*1000, n(idx_7_4V), 5, 'r', 'filled');
idx_5V = find(t >= 2.5);
scatter(M_em(idx_5V)*1000, n(idx_5V), 5, 'g', 'filled');
grid on;
xlabel('Mô men (mN.m)');
ylabel('Tốc độ (rpm)');
title('Đặc tính cơ n = f(M)');
legend('3.7V', '7.4V', '5V', 'Location', 'Northeast');

% Subplot 10: Đặc tính n = f(I)
subplot(3, 4, 10);
scatter(I_a(idx_3_7V), n(idx_3_7V), 5, 'b', 'filled');
hold on;
scatter(I_a(idx_7_4V), n(idx_7_4V), 5, 'r', 'filled');
scatter(I_a(idx_5V), n(idx_5V), 5, 'g', 'filled');
grid on;
xlabel('Dòng điện (A)');
ylabel('Tốc độ (rpm)');
title('Đặc tính n = f(I_a)');
legend('3.7V', '7.4V', '5V', 'Location', 'Northeast');

% Subplot 11: Hiệu suất
subplot(3, 4, 11);
plot(t, eta, 'k-', 'LineWidth', 2);
grid on;
xlabel('Thời gian (s)');
ylabel('Hiệu suất (%)');
title('Hiệu suất η');
ylim([0 100]);

% Subplot 12: Thông tin
subplot(3, 4, 12);
axis off;

idx_1s = find(t >= 1.0, 1);
idx_2s = find(t >= 2.0, 1);

str_info = {
    'THÔNG TIN MÔ PHỎNG'
    '─────────────────────'
    sprintf('Loại: 540/550 DC Motor')
    sprintf('Nguồn: 7.4V Li-ion')
    ' '
    'TẠI t = 1.0s (3.7V):'
    sprintf('  n: %.0f rpm', n(idx_1s))
    sprintf('  I: %.2f A', I_a(idx_1s))
    sprintf('  M: %.1f mN.m', M_em(idx_1s)*1000)
    sprintf('  η: %.1f%%', eta(idx_1s))
    ' '
    'TẠI t = 2.0s (7.4V):'
    sprintf('  n: %.0f rpm', n(idx_2s))
    sprintf('  I: %.2f A', I_a(idx_2s))
    sprintf('  M: %.1f mN.m', M_em(idx_2s)*1000)
    sprintf('  η: %.1f%%', eta(idx_2s))
};
text(0.05, 0.95, str_info, 'VerticalAlignment', 'top', 'FontSize', 9);

%% ========== KẾT QUẢ ==========

fprintf('========== KẾT QUẢ MÔ PHỎNG ==========\n\n');

fprintf('ĐIỂM LÀM VIỆC @ 7.4V:\n');
fprintf('  Tốc độ: %.0f rpm\n', n(idx_2s));
fprintf('  Dòng điện: %.2f A\n', I_a(idx_2s));
fprintf('  Mô men: %.2f mN.m\n', M_em(idx_2s)*1000);
fprintf('  Công suất: %.1f W\n', P_out(idx_2s));
fprintf('  Hiệu suất: %.1f%%\n', eta(idx_2s));

fprintf('\nTHỜI GIAN ĐÁP ỨNG:\n');
idx_90 = find(n >= 0.9 * max(n(idx_7_4V)), 1);
fprintf('  Đạt 90%% tốc độ: %.3f s\n', t(idx_90) - 1.2);

fprintf('\n======================================\n');

%% ========== LƯU KẾT QUẢ ==========

saveas(gcf, 'mo_phong_dong_co_huina_1592.png');
fprintf('\nĐã lưu: mo_phong_dong_co_huina_1592.png\n');

save('data_dong_co_huina.mat', 't', 'U_in', 'I_a', 'omega', 'n', ...
     'M_em', 'M_load', 'E_a', 'P_in', 'P_out', 'eta');
fprintf('Đã lưu: data_dong_co_huina.mat\n');

fprintf('\n========== HOÀN THÀNH ==========\n');

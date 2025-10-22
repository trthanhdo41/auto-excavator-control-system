%% MÔ PHỎNG ĐIỀU KHIỂN PWM CHO ĐỘNG CƠ DC
% Mô phỏng ESC điều khiển động cơ 540/550 bằng PWM
% Tác giả: Hệ thống điều khiển máy xúc Huina 1592
% Ngày: 10/2025

clc; clear all; close all;

%% ========== THÔNG SỐ ==========

fprintf('========== MÔ PHỎNG ĐIỀU KHIỂN PWM ==========\n\n');

% Động cơ
R_a = 0.8;              % Điện trở [Ohm]
L_a = 0.0002;           % Độ tự cảm [H]
K_e = 0.00557;          % Hằng số EMF [V/(rad/s)]
K_m = 0.0066;           % Hằng số mô men [N.m/A]
J = 0.00025;            % Mô men đà [kg.m²]
B = 0.0001;             % Ma sát [N.m.s/rad]

% PWM
V_supply = 7.4;         % Điện áp nguồn [V]
f_PWM = 20000;          % Tần số PWM [Hz] = 20kHz
T_PWM = 1 / f_PWM;      % Chu kỳ PWM [s]

fprintf('Điện áp nguồn: %.1f V\n', V_supply);
fprintf('Tần số PWM: %.0f kHz\n', f_PWM/1000);
fprintf('Chu kỳ PWM: %.1f μs\n', T_PWM*1e6);
fprintf('\n');

%% ========== MÔ PHỎNG 1: ĐÁP ỨNG VỚI DUTY CYCLE KHÁC NHAU ==========

t_sim = 2.0;
dt = 0.00001;
t = 0:dt:t_sim;

% Duty cycle thay đổi
D = zeros(size(t));
D(t >= 0.0 & t < 0.5) = 0;
D(t >= 0.5 & t < 1.0) = 0.5;    % 50%
D(t >= 1.0 & t < 1.5) = 0.75;   % 75%
D(t >= 1.5) = 1.0;              % 100%

% Điện áp trung bình
U_avg = D * V_supply;

% Mô phỏng
I_a = zeros(size(t));
omega = zeros(size(t));
n = zeros(size(t));
M = zeros(size(t));

I_temp = 0;
omega_temp = 0;
M_load = 0.015;  % Mô men tải cố định

for i = 1:length(t)
    E_a = K_e * omega_temp;
    
    dI_dt = (U_avg(i) - R_a * I_temp - E_a) / L_a;
    I_temp = I_temp + dI_dt * dt;
    if I_temp < 0, I_temp = 0; end
    I_a(i) = I_temp;
    
    M_em = K_m * I_temp;
    M(i) = M_em;
    
    d_omega_dt = (M_em - M_load - B * omega_temp) / J;
    omega_temp = omega_temp + d_omega_dt * dt;
    if omega_temp < 0, omega_temp = 0; end
    omega(i) = omega_temp;
    n(i) = omega_temp * 60 / (2*pi);
end

%% ========== VẼ ĐỒ THỊ 1 ==========

figure('Name', 'Điều khiển PWM', 'Position', [50, 50, 1400, 900]);

subplot(3, 3, 1);
plot(t, D*100, 'b-', 'LineWidth', 2);
grid on;
xlabel('Thời gian (s)');
ylabel('Duty Cycle (%)');
title('Duty Cycle PWM');
ylim([0 105]);

subplot(3, 3, 2);
plot(t, U_avg, 'r-', 'LineWidth', 2);
grid on;
xlabel('Thời gian (s)');
ylabel('Điện áp (V)');
title('Điện áp trung bình');
ylim([0 8]);

subplot(3, 3, 3);
plot(t, I_a, 'g-', 'LineWidth', 2);
grid on;
xlabel('Thời gian (s)');
ylabel('Dòng điện (A)');
title('Dòng điện động cơ');

subplot(3, 3, 4);
plot(t, n, 'm-', 'LineWidth', 2);
grid on;
xlabel('Thời gian (s)');
ylabel('Tốc độ (rpm)');
title('Tốc độ động cơ');

subplot(3, 3, 5);
plot(t, M*1000, 'c-', 'LineWidth', 2);
hold on;
plot([0 t_sim], [M_load*1000 M_load*1000], 'k--');
grid on;
xlabel('Thời gian (s)');
ylabel('Mô men (mN.m)');
title('Mô men điện từ');
legend('M_{em}', 'M_{load}');

subplot(3, 3, 6);
plot(D(t>=0.5)*100, n(t>=0.5), 'b.', 'MarkerSize', 2);
grid on;
xlabel('Duty Cycle (%)');
ylabel('Tốc độ (rpm)');
title('n = f(Duty)');

%% ========== MÔ PHỎNG 2: TÍN HIỆU PWM CHI TIẾT ==========

% Mô phỏng 1 chu kỳ PWM
t_pwm = 0:T_PWM/1000:T_PWM;
D_test = 0.6;  % 60% duty

V_pwm = zeros(size(t_pwm));
V_pwm(t_pwm < D_test * T_PWM) = V_supply;

subplot(3, 3, 7);
plot(t_pwm*1e6, V_pwm, 'b-', 'LineWidth', 2);
grid on;
xlabel('Thời gian (μs)');
ylabel('Điện áp (V)');
title(sprintf('Tín hiệu PWM @ D=%.0f%%', D_test*100));
ylim([0 8]);
xlim([0 T_PWM*1e6]);

% Thêm annotation
text(T_PWM*0.3*1e6, 4, sprintf('T_{on}=%.1fμs', D_test*T_PWM*1e6));
text(T_PWM*0.8*1e6, 4, sprintf('T_{off}=%.1fμs', (1-D_test)*T_PWM*1e6));

%% ========== PHÂN TÍCH DÒNG GIAN SÓNG ==========

% Dòng gợn sóng
Duty_range = 0.1:0.05:0.9;
omega_test = 600;  % rad/s
E_a_test = K_e * omega_test;

Delta_I = zeros(size(Duty_range));
for i = 1:length(Duty_range)
    D_val = Duty_range(i);
    Delta_I(i) = (V_supply - E_a_test) * D_val * (1-D_val) / (L_a * f_PWM);
end

subplot(3, 3, 8);
plot(Duty_range*100, Delta_I*1000, 'r-', 'LineWidth', 2);
grid on;
xlabel('Duty Cycle (%)');
ylabel('Dòng gợn sóng (mA)');
title('Dòng gợn sóng ΔI');

%% ========== HIỆU SUẤT ==========

Duty_eff = 0.2:0.05:1.0;
eta = zeros(size(Duty_eff));
I_cond_loss = 2;  % A ước tính
R_mosfet = 0.02;  % Ohm

for i = 1:length(Duty_eff)
    P_loss = I_cond_loss^2 * R_mosfet * 4;  % 4 MOSFET
    P_motor = Duty_eff(i) * V_supply * I_cond_loss;
    eta(i) = P_motor / (P_motor + P_loss) * 100;
end

subplot(3, 3, 9);
plot(Duty_eff*100, eta, 'k-', 'LineWidth', 2);
grid on;
xlabel('Duty Cycle (%)');
ylabel('Hiệu suất (%)');
title('Hiệu suất hệ thống');
ylim([90 100]);

%% ========== KẾT QUẢ ==========

fprintf('========== KẾT QUẢ ==========\n\n');

fprintf('TẠI DUTY = 50%%:\n');
idx = find(t >= 0.75, 1);
fprintf('  Điện áp TB: %.2f V\n', U_avg(idx));
fprintf('  Dòng điện: %.2f A\n', I_a(idx));
fprintf('  Tốc độ: %.0f rpm\n', n(idx));
fprintf('  Mô men: %.2f mN.m\n', M(idx)*1000);

fprintf('\nTẠI DUTY = 100%%:\n');
idx = find(t >= 1.75, 1);
fprintf('  Điện áp TB: %.2f V\n', U_avg(idx));
fprintf('  Dòng điện: %.2f A\n', I_a(idx));
fprintf('  Tốc độ: %.0f rpm\n', n(idx));
fprintf('  Mô men: %.2f mN.m\n', M(idx)*1000);

fprintf('\nDÒNG GỢN SÓNG TỐI ĐA:\n');
fprintf('  ΔI_max: %.1f mA (tại D=50%%)\n', max(Delta_I)*1000);

fprintf('\nHIỆU SUẤT:\n');
fprintf('  η @ D=100%%: %.1f%%\n', eta(end));

fprintf('\n============================\n');

saveas(gcf, 'mo_phong_pwm.png');
fprintf('\nĐã lưu: mo_phong_pwm.png\n');


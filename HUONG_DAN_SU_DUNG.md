# HƯỚNG DẪN SỬ DỤNG

## HỆ THỐNG ĐIỀU KHIỂN MÁY XÚC TỰ ĐỘNG HUINA 1592

---

## MỤC LỤC

1. [Yêu cầu hệ thống](#1-yêu-cầu-hệ-thống)
2. [Cấu trúc thư mục](#2-cấu-trúc-thư-mục)
3. [Hướng dẫn sử dụng](#3-hướng-dẫn-sử-dụng)
4. [Mô phỏng MATLAB](#4-mô-phỏng-matlab)
5. [Câu hỏi thường gặp](#5-câu-hỏi-thường-gặp)
6. [Khắc phục sự cố](#6-khắc-phục-sự-cố)

---

## 1. YÊU CẦU HỆ THỐNG

### Phần mềm cần thiết:

- **MATLAB R2019b trở lên** (khuyến nghị R2021a+)
- Không cần toolbox đặc biệt
- Hệ điều hành: Windows, macOS, Linux

### Kiến thức cần có:

- Cơ bản về MATLAB
- Hiểu biết về động cơ DC và điều khiển PWM
- Đọc hiểu sơ đồ mạch điện

---

## 2. CẤU TRÚC THƯ MỤC

```
hệ thống điều khiển máy xúc auto/
│
├── README.md                              # Giới thiệu tổng quan
├── HUONG_DAN_SU_DUNG.md                  # File này
├── GIOI_THIEU_HUINA_1592.md              # Thông tin Huina 1592
│
├── calculations/                          # Tính toán chi tiết
│   ├── chuong3_phan1.md                  # Thông số động cơ (R_a, K_e, K_m...)
│   └── chuong3_phan2.md                  # Điều khiển PWM và ESC
│
├── matlab/                                # Code MATLAB mô phỏng
│   ├── mo_phong_khau_dong_co.m           # Mô phỏng động cơ DC
│   ├── mo_phong_dieu_khien_pwm.m         # Điều khiển PWM
│   ├── mo_phong_dac_tinh_co.m            # Đặc tính cơ n=f(M)
│   ├── mo_phong_hang_so_thoi_gian.m      # Hằng số T_a và T_m
│   ├── mo_phong_hieu_suat.m              # Phân tích hiệu suất
│   └── chay_tat_ca.m                     # Chạy tất cả mô phỏng
│
└── docs/                                  # Tài liệu
    └── BAO_CAO_TONG_HOP.md               # Báo cáo tổng hợp
```

---

## 3. HƯỚNG DẪN SỬ DỤNG

### 3.1. Xem tính toán lý thuyết

#### Bước 1: Mở file tính toán
```
Vào thư mục: calculations/
Mở file: chuong3_phan1.md (thông số động cơ)
Mở file: chuong3_phan2.md (điều khiển PWM)
```

#### Bước 2: Đọc nội dung
- Mỗi phần có công thức chi tiết
- Ví dụ tính toán cụ thể từng bước
- Bảng tra cứu giá trị
- Giải thích ý nghĩa vật lý

### 3.2. Giới thiệu Huina 1592

```
Mở file: GIOI_THIEU_HUINA_1592.md

Nội dung:
- Thông số kỹ thuật
- So sánh với máy công nghiệp
- Khả năng nâng cấp
- Ứng dụng nghiên cứu
```

---

## 4. MÔ PHỎNG MATLAB

### 4.1. Chạy nhanh tất cả mô phỏng

**Cách đơn giản nhất:**

```matlab
% Mở MATLAB
cd 'matlab/'

% Chạy tất cả
chay_tat_ca

% Kết quả:
% - Tự động chạy 5 file mô phỏng
% - Hiển thị đồ thị
% - Lưu ảnh PNG
% - Lưu dữ liệu .mat
```

**Thời gian:** ~30-40 giây cho tất cả

---

### 4.2. Chạy từng mô phỏng chi tiết

#### A. Mô phỏng động cơ 540/550

**File:** `mo_phong_khau_dong_co.m`

**Nội dung:**
- Đáp ứng với điện áp thay đổi (3.7V, 7.4V)
- Đáp ứng với mô men tải thay đổi
- Đặc tính cơ n = f(M)
- Đặc tính n = f(I)
- Công suất và hiệu suất
- Quá trình khởi động

**Cách chạy:**
```matlab
cd 'matlab/'
mo_phong_khau_dong_co
```

**Kết quả mong đợi:**
- 12 subplot hiển thị đầy đủ
- Tốc độ định mức: ~8000 rpm @ 7.4V
- Dòng điện: 2-4A
- Hiệu suất: 70-80%
- File lưu: `mo_phong_dong_co_huina_1592.png`

**Thời gian chạy:** ~5-8 giây

---

#### B. Điều khiển PWM

**File:** `mo_phong_dieu_khien_pwm.m`

**Nội dung:**
- Đáp ứng với Duty Cycle khác nhau (0%, 50%, 75%, 100%)
- Tín hiệu PWM chi tiết (20kHz)
- Dòng gợn sóng ΔI
- Hiệu suất ESC
- Quan hệ Duty - Tốc độ

**Cách chạy:**
```matlab
mo_phong_dieu_khien_pwm
```

**Kết quả mong đợi:**
- 9 subplot
- Duty 50% → n ≈ 4000 rpm
- Duty 100% → n ≈ 8000 rpm
- Dòng gợn sóng < 100mA
- Hiệu suất ESC: 95-98%
- File lưu: `mo_phong_pwm.png`

**Thời gian chạy:** ~3-4 giây

---

#### C. Đặc tính cơ

**File:** `mo_phong_dac_tinh_co.m`

**Nội dung:**
- Đặc tính n = f(M) với nhiều điện áp (3.7V - 11.1V)
- Quan hệ M = f(I)
- Quan hệ n = f(I)
- Công suất P = f(M)
- Hiệu suất η = f(M)
- So sánh lý thuyết vs thực tế

**Cách chạy:**
```matlab
mo_phong_dac_tinh_co
```

**Kết quả mong đợi:**
- 6 subplot chi tiết
- Tốc độ không tải: ~12000 rpm
- Độ dốc đặc tính: ~450 rpm/(N.m)
- Hiệu suất max: ~80% @ M = 0.5×M_rated
- File lưu: `dac_tinh_co_dong_co.png`

**Thời gian chạy:** ~2-3 giây

---

#### D. Hằng số thời gian

**File:** `mo_phong_hang_so_thoi_gian.m`

**Nội dung:**
- Hằng số thời gian điện T_a (≈0.25ms)
- Hằng số thời gian cơ T_m (≈117ms)
- Đáp ứng bước dòng điện
- Đáp ứng bước tốc độ
- Ảnh hưởng của mô men đà J
- Thời gian tăng tốc

**Cách chạy:**
```matlab
mo_phong_hang_so_thoi_gian
```

**Kết quả mong đợi:**
- 6 subplot
- T_a = 0.25ms (rất nhanh)
- T_m = 117ms (chậm hơn 468 lần)
- Thời gian đạt 95% tốc độ: ~350ms
- Khuyến nghị tần số điều khiển: ~10Hz
- File lưu: `hang_so_thoi_gian.png`

**Thời gian chạy:** ~3-4 giây

---

#### E. Phân tích hiệu suất

**File:** `mo_phong_hieu_suat.m`

**Nội dung:**
- Hiệu suất động cơ vs tải
- Tổn thất động cơ (Cu, cơ, sắt)
- Hiệu suất ESC vs Duty
- Tổn thất ESC (dẫn, đóng/mở)
- Hiệu suất toàn hệ thống
- Phân bố tổn thất (pie chart)

**Cách chạy:**
```matlab
mo_phong_hieu_suat
```

**Kết quả mong đợi:**
- 6 subplot + pie chart
- Hiệu suất động cơ: 75-85%
- Hiệu suất ESC: 95-98%
- Hiệu suất tổng: ~73%
- Tổn thất chủ yếu: Tổn thất Cu và ma sát
- File lưu: `phan_tich_hieu_suat.png`

**Thời gian chạy:** ~2-3 giây

---

### 4.3. Tùy chỉnh mô phỏng

#### Thay đổi thông số động cơ:

**Ví dụ: Thử với động cơ mạnh hơn**

Mở file `mo_phong_khau_dong_co.m`, tìm dòng:
```matlab
R_a = 0.8;              % Điện trở [Ohm]
K_e = 0.00557;          % Hằng số EMF
```

Thay đổi thành:
```matlab
R_a = 0.5;              % Động cơ tốt hơn
K_e = 0.006;            % Động cơ nhanh hơn
```

Chạy lại và so sánh kết quả.

#### Thay đổi điện áp nguồn:

**Ví dụ: Thử với pin 3S (11.1V)**

Trong file mô phỏng, tìm:
```matlab
U_rated = 7.4;          % Điện áp [V]
```

Thay đổi thành:
```matlab
U_rated = 11.1;         % Pin 3S
```

**Lưu ý:** Tốc độ sẽ tăng ~50%, nhưng dòng điện cũng tăng!

#### Thay đổi tải:

```matlab
% Tìm dòng định nghĩa mô men tải
M_load(t >= 1.8) = M_rated;                      % 100% tải

% Thay đổi thành
M_load(t >= 1.8) = M_rated * 0.5;                % 50% tải (nhẹ hơn)
```

---

## 5. CÂU HỎI THƯỜNG GẶP

### Q1: MATLAB báo lỗi "Undefined function or variable"?

**Trả lời:** Đảm bảo đang ở đúng thư mục

```matlab
% Kiểm tra thư mục hiện tại
pwd

% Chuyển đến thư mục đúng
cd '/đường/dẫn/đến/matlab/'

% Hoặc thêm thư mục vào path
addpath('/đường/dẫn/đến/matlab/')
```

---

### Q2: Đồ thị không hiển thị?

**Trả lời:** 
```matlab
% Kiểm tra figure
figure(1)

% Bật lại hiển thị
set(0, 'DefaultFigureVisible', 'on');
```

---

### Q3: Chạy quá lâu?

**Trả lời:** Giảm thời gian mô phỏng hoặc tăng bước thời gian

```matlab
% Thay vì
t_sim = 3.0;
dt = 0.0001;

% Thử
t_sim = 1.0;
dt = 0.001;
```

---

### Q4: Muốn lưu kết quả vào Excel?

**Trả lời:** Thêm code sau cuối file:

```matlab
% Tạo bảng dữ liệu
T = table(t', U_in', I_a', n', ...
    'VariableNames', {'Time', 'Voltage', 'Current', 'Speed'});

% Lưu vào Excel
writetable(T, 'ket_qua_mo_phong.xlsx');
```

---

### Q5: Code có chạy được trên Octave không?

**Trả lời:** Có, nhưng cần chỉnh sửa nhỏ:
- Một số hàm plot có thể khác nhau
- Thay `sprintf` trong title bằng chuỗi đơn giản
- Kiểm tra compatibility mode

---

### Q6: Làm sao so sánh với thực nghiệm?

**Trả lời:** 
1. Đo thông số thực tế (R_a, K_e) bằng multimeter
2. Cập nhật vào code MATLAB
3. Chạy lại mô phỏng
4. So sánh đồ thị

Xem file `GIOI_THIEU_HUINA_1592.md` phần "Thực nghiệm"

---

### Q7: Muốn xuất video animation?

**Trả lời:** Sử dụng VideoWriter:

```matlab
v = VideoWriter('mo_phong_dong_co.avi');
open(v);

for i = 1:10:length(t)
    % Vẽ frame
    plot(t(1:i), n(1:i));
    xlabel('Time (s)');
    ylabel('Speed (rpm)');
    drawnow;
    
    % Capture
    frame = getframe(gcf);
    writeVideo(v, frame);
end

close(v);
```

---

## 6. KHẮC PHỤC SỰ CỐ

### Sự cố 1: Warning về singular matrix

**Nguyên nhân:** Thông số không hợp lý (R = 0, L = 0)

**Giải pháp:**
- Kiểm tra lại các thông số
- Đảm bảo không có giá trị 0 ở mẫu số
- Dùng giá trị nhỏ thay vì 0 (ví dụ: B = 1e-6)

---

### Sự cố 2: Kết quả không ổn định (oscillation)

**Nguyên nhân:** Bước thời gian dt quá lớn

**Giải pháp:**
```matlab
dt = 0.0001;  % Giảm bước thời gian
% Hoặc dùng ode45
[t, y] = ode45(@motor_dynamics, [0 3], [0 0]);
```

---

### Sự cố 3: Out of memory

**Nguyên nhân:** Thời gian mô phỏng quá dài với dt quá nhỏ

**Giải pháp:**
```matlab
% Giảm thời gian hoặc tăng dt
t_sim = 2.0;
dt = 0.001;

% Hoặc lưu dữ liệu mỗi N bước
if mod(i, 10) == 0
    data(j) = value;
end
```

---

### Sự cố 4: Đồ thị bị méo hoặc có NaN

**Nguyên nhân:** Dữ liệu có NaN hoặc Inf

**Giải pháp:**
```matlab
% Kiểm tra
any(isnan(I_a))
any(isinf(I_a))

% Loại bỏ
I_a(isnan(I_a)) = 0;
I_a(isinf(I_a)) = 0;

% Hoặc giới hạn
I_a = min(max(I_a, 0), 10);  % Giới hạn 0-10A
```

---

### Sự cố 5: Không lưu được file

**Nguyên nhân:** Không có quyền ghi

**Giải pháp:**
```matlab
% Chuyển sang thư mục có quyền
cd('~/Desktop/')
saveas(gcf, 'hinh_anh.png');

% Hoặc kiểm tra quyền
fileattrib(pwd)
```

---

## 7. MẸO VÀ THỦ THUẬT

### Mẹo 1: Zoom vào vùng quan tâm

```matlab
% Sau khi plot
xlim([0.5 1.0]);  % Zoom thời gian 0.5-1.0s
ylim([0 250]);    % Giới hạn trục y
```

---

### Mẹo 2: So sánh nhiều trường hợp

```matlab
% Chạy với R_a = 0.8
R_a = 0.8;
run('mo_phong_khau_dong_co.m');
n1 = n;

% Chạy với R_a = 0.5
R_a = 0.5;
run('mo_phong_khau_dong_co.m');
n2 = n;

% So sánh
figure;
plot(t, n1, 'b-', t, n2, 'r--');
legend('R_a=0.8Ω', 'R_a=0.5Ω');
```

---

### Mẹo 3: In báo cáo PDF tất cả figure

```matlab
% Lấy tất cả figure
figs = findall(0, 'Type', 'figure');

% Lưu từng figure
for i = 1:length(figs)
    figure(figs(i));
    print('-dpdf', sprintf('figure_%d.pdf', i));
end

% Hoặc ghép thành 1 file
print('-dpdf', '-fillpage', 'bao_cao_day_du.pdf', figs);
```

---

### Mẹo 4: Debug khi kết quả sai

```matlab
% Thêm điểm dừng
keyboard

% Hoặc in giá trị
fprintf('n @ t=1s: %.0f rpm\n', n(find(t>=1, 1)));

% Plot từng bước
for i = 1:100:length(t)
    plot(t(1:i), n(1:i));
    pause(0.1);
end
```

---

### Mẹo 5: Xuất dữ liệu sang Python

```matlab
% Lưu CSV
csvwrite('data.csv', [t', I_a', n']);

% Hoặc MAT file
save('data.mat', 't', 'I_a', 'n');
```

Trong Python:
```python
import pandas as pd
import scipy.io

# Từ CSV
data = pd.read_csv('data.csv')

# Từ MAT
mat = scipy.io.loadmat('data.mat')
```

---

## 8. HỖ TRỢ

### Liên hệ:

- **GitHub**: [github.com/trthanhdo41/auto-excavator-control-system](https://github.com/trthanhdo41/auto-excavator-control-system)
- **Issues**: Báo lỗi tại GitHub Issues
- **Documentation**: Xem file `BAO_CAO_TONG_HOP.md`

### Báo lỗi:

Nếu phát hiện lỗi, vui lòng báo cáo với thông tin:
1. File nào bị lỗi
2. Thông báo lỗi (copy toàn bộ)
3. Phiên bản MATLAB
4. Hệ điều hành
5. Thông số đã thay đổi (nếu có)

---

## 9. CẬP NHẬT

### Phiên bản:
- **v2.0** - Tháng 10/2025: Viết lại hoàn toàn cho Huina 1592
- **v1.0** - Tháng 10/2025: Phiên bản đầu tiên

### Bản quyền:
- Mã nguồn mở cho mục đích học tập và nghiên cứu
- Trích dẫn khi sử dụng trong công trình khoa học

### Đóng góp:
Chào mừng mọi đóng góp để cải thiện dự án!

---

**Chúc các bạn sử dụng thành công! 🚜⚡**

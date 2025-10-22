# CHƯƠNG 3 - PHẦN 1: XÁC ĐỊNH CÁC THÔNG SỐ ĐỘNG CƠ HUINA 1592

## GIỚI THIỆU

Chương này tập trung vào việc xác định và tính toán các thông số của hệ thống điều khiển động cơ DC trong máy xúc mô hình Huina 1592. Khác với máy xúc công nghiệp sử dụng hệ thống phức tạp với khuếch đại từ và máy phát DC, Huina 1592 sử dụng hệ thống đơn giản hơn với động cơ DC Brushed 540/550 và điều khiển PWM.

## 3.1.1 - Xác định điện trở phần ứng động cơ (R_a)

### Khái niệm

Điện trở phần ứng R_a là điện trở của cuộn dây phần ứng động cơ DC, là một thông số quan trọng ảnh hưởng đến:
- Dòng khởi động
- Tổn thất công suất
- Hiệu suất động cơ
- Đặc tính cơ

**GIẢI THÍCH CHI TIẾT:**

Trong động cơ DC, điện trở phần ứng bao gồm:
- Điện trở của dây đồng cuộn phần ứng
- Điện trở tiếp xúc chổi than
- Điện trở dây nối

Đối với động cơ 540/550 trong Huina 1592, R_a thường nằm trong khoảng 0.5 - 1.5Ω.

**Ý nghĩa vật lý:**
- R_a nhỏ → Dòng khởi động lớn, hiệu suất cao, nhưng khó điều khiển
- R_a lớn → Dòng khởi động nhỏ, an toàn hơn, nhưng hiệu suất thấp
- R_a tăng theo nhiệt độ (hệ số nhiệt độ α ≈ 0.004/°C cho đồng)

### Công thức tính

**1. Phương pháp đo trực tiếp (Đề xuất):**

```
R_a = U_test / I_test
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `R_a`: Điện trở phần ứng (Ω)
- `U_test`: Điện áp DC nhỏ đặt vào động cơ (V) - khuyến nghị 1-2V
- `I_test`: Dòng điện đo được (A)

**Lưu ý:** Phải đo ở điện áp nhỏ để động cơ không quay (tránh sức phản điện động)

**2. Phương pháp từ thông số kỹ thuật:**

```
R_a = (U_rated - U_no_load × 0.9) / I_rated
```

**VÍ DỤ TÍNH TOÁN TỪNG BƯỚC:**

**Bước 1: Đo trực tiếp bằng đồng hồ vạn năng**

```
Chuẩn bị:
- Đồng hồ vạn năng (multimeter)
- Nguồn DC 2V (hoặc 2 pin AA)
- Ampe kế (hoặc multimeter thứ 2)

Thực hiện:
1. Ngắt kết nối động cơ khỏi mạch
2. Đặt điện áp 2V vào 2 cực động cơ
3. Đo dòng điện: I_test = 2.5A
4. Tính R_a = 2 / 2.5 = 0.8Ω
```

**Bước 2: Kiểm tra bằng công thức**

```
Cho: 
- U_rated = 7.4V
- I_rated = 4A
- I_no_load = 0.5A

Ước tính:
R_a ≈ (U_rated - E_a) / I_rated
R_a ≈ (7.4 - 6.5) / 4 = 0.225Ω (chỉ tính rơi áp)

R_a thực tế ≈ 0.8Ω (gần với kết quả đo)
```

**Bước 3: So sánh với datasheet**

```
Động cơ 540: R_a = 0.5 - 1.0Ω
Động cơ 550: R_a = 0.7 - 1.5Ω
→ R_a = 0.8Ω hợp lý cho động cơ 550
```

### Thông số động cơ Huina 1592

| Động cơ | R_a (Ω) | Ghi chú |
|---------|---------|---------|
| 540 Motor | 0.5 - 1.0 | Nhỏ hơn, hiệu suất cao |
| 550 Motor | 0.7 - 1.5 | Phổ biến trong Huina 1592 |
| 555 Motor | 1.0 - 2.0 | Lớn hơn, ít dùng |

**Giá trị sử dụng trong tính toán:** R_a = **0.8Ω**

### Ảnh hưởng của nhiệt độ

```
R_t = R_20 × [1 + α(T - 20)]

Với α = 0.004 /°C (đồng)

Ví dụ:
R_20 = 0.8Ω ở 20°C
T = 60°C (khi hoạt động)
R_60 = 0.8 × [1 + 0.004×(60-20)] = 0.928Ω

→ Tăng 16% khi nóng!
```

### Ứng dụng thực tế

**1. Tính dòng khởi động:**

```
I_start = U_supply / R_a = 7.4 / 0.8 = 9.25A

→ Rất lớn! Cần ESC (Electronic Speed Controller) để hạn chế
```

**2. Tính tổn thất công suất:**

```
P_loss = I² × R_a = 4² × 0.8 = 12.8W

→ ~40% công suất (30W) mất qua R_a!
```

**3. Điều khiển PWM:**

```
Duty cycle để đạt I_avg = 3A:
D = (I_avg × R_a + E_a) / U_supply
D = (3 × 0.8 + 6.0) / 7.4 = 0.946 = 94.6%
```

---

## 3.1.2 - Xác định hằng số sức phản điện động (K_e)

### Khái niệm

Hằng số sức phản điện động K_e (Back-EMF constant) là hệ số tỷ lệ giữa sức phản điện động (E_a) và tốc độ góc (ω) của động cơ.

**GIẢI THÍCH CHI TIẾT:**

Khi động cơ quay, cuộn dây phần ứng cắt từ trường, sinh ra sức điện động ngược chiều với điện áp cấp (định luật Faraday). Đây gọi là sức phản điện động (Back-EMF).

**Ý nghĩa vật lý:**
- K_e lớn → Tốc độ không tải thấp, mô men lớn (động cơ mạnh)
- K_e nhỏ → Tốc độ không tải cao, mô men nhỏ (động cơ nhanh)
- K_e = K_m (trong đơn vị SI) - quan hệ quan trọng!

### Công thức tính

**1. Từ định luật Faraday:**

```
E_a = K_e × ω
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `E_a`: Sức phản điện động (V)
- `K_e`: Hằng số EMF (V/(rad/s) hoặc V/krpm)
- `ω`: Tốc độ góc (rad/s)

**2. Từ thông số định mức:**

```
K_e = (U_rated - I_rated × R_a) / ω_rated
```

**VÍ DỤ TÍNH TOÁN TỪNG BƯỚC:**

**Bước 1: Đo tốc độ không tải**

```
Cho động cơ 550 của Huina 1592:
- U_supply = 7.4V
- I_no_load = 0.5A
- n_no_load = 12000 rpm (đo bằng tachometer)

Chuyển đổi sang rad/s:
ω_no_load = 2π × n_no_load / 60
ω_no_load = 2π × 12000 / 60 = 1256.6 rad/s
```

**Bước 2: Tính E_a không tải**

```
E_a_no_load = U_supply - I_no_load × R_a
E_a_no_load = 7.4 - 0.5 × 0.8 = 7.0V
```

**Bước 3: Tính K_e**

```
K_e = E_a_no_load / ω_no_load
K_e = 7.0 / 1256.6 = 0.00557 V/(rad/s)

Hoặc đổi sang V/krpm:
K_e = 7.0 / 12 = 0.583 V/krpm
```

**Bước 4: Kiểm tra ở tải định mức**

```
Ở tải định mức:
n_rated = 8000 rpm
I_rated = 4A

E_a_rated = U_supply - I_rated × R_a
E_a_rated = 7.4 - 4 × 0.8 = 4.2V

ω_rated = 2π × 8000 / 60 = 837.8 rad/s

K_e_check = 4.2 / 837.8 = 0.00501 V/(rad/s)

→ Gần với K_e = 0.00557 (sai số do ma sát)
```

### Quan hệ K_e và K_m

```
K_m = K_e (trong đơn vị SI)

Chứng minh:
P_cơ = E_a × I_a = M × ω

M = E_a × I_a / ω = (K_e × ω) × I_a / ω = K_e × I_a

Vậy: K_m = M / I_a = K_e
```

### Bảng tra K_e các động cơ phổ biến

| Động cơ | K_e (V/(rad/s)) | K_e (V/krpm) | Ghi chú |
|---------|----------------|--------------|---------|
| 540 Motor 12000KV | 0.00796 | 0.796 | Cao tốc |
| 550 Motor 8000KV | 0.00557 | 0.583 | **Huina 1592** |
| 555 Motor 6000KV | 0.00418 | 0.418 | Mô men cao |

**KV rating** = Tốc độ (rpm) trên 1V
```
K_e (V/krpm) ≈ 1 / KV × 1000
```

### Ứng dụng thực tế

**1. Tính tốc độ tối đa:**

```
Khi I_a → 0 (không tải):
E_a ≈ U_supply
ω_max = U_supply / K_e = 7.4 / 0.00557 = 1328 rad/s
n_max = ω_max × 60 / 2π = 12686 rpm

→ Gần với datasheet 12000 rpm!
```

**2. Tính tốc độ ở tải bất kỳ:**

```
Cho I_a = 3A:
E_a = U_supply - I_a × R_a = 7.4 - 3×0.8 = 4.6V
ω = E_a / K_e = 4.6 / 0.00557 = 826 rad/s
n = 7886 rpm
```

**3. Điều khiển tốc độ PWM:**

```
Muốn n = 6000 rpm:
ω = 6000 × 2π/60 = 628.3 rad/s
E_a_cần = K_e × ω = 0.00557 × 628.3 = 3.5V

U_cần = E_a + I_a × R_a = 3.5 + 3×0.8 = 5.9V
Duty = U_cần / U_supply = 5.9 / 7.4 = 80%
```

---

## 3.1.3 - Xác định hằng số mô men (K_m)

### Khái niệm

Hằng số mô men K_m (Torque constant) là hệ số tỷ lệ giữa mô men (M) và dòng điện phần ứng (I_a).

**GIẢI THÍCH CHI TIẾT:**

Khi dòng điện chạy qua cuộn dây phần ứng trong từ trường, xuất hiện lực từ tạo ra mô men xoắn (định luật Ampère). Mô men này tỷ lệ thuận với dòng điện.

**Ý nghĩa vật lý:**
- K_m lớn → Mô men lớn với cùng dòng điện (động cơ mạnh)
- K_m nhỏ → Cần dòng điện lớn để tạo mô men (hiệu suất thấp)
- K_m = K_e (đơn vị SI) - nguyên lý bảo toàn năng lượng

### Công thức tính

**1. Từ định nghĩa:**

```
M = K_m × I_a
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `M`: Mô men (N.m)
- `K_m`: Hằng số mô men (N.m/A)
- `I_a`: Dòng điện phần ứng (A)

**2. Từ công suất:**

```
K_m = P_rated / (ω_rated × I_rated)
```

**VÍ DỤ TÍNH TOÁN TỪNG BƯỚC:**

**Bước 1: Tính công suất cơ học**

```
Cho:
- U_supply = 7.4V
- I_rated = 4A
- n_rated = 8000 rpm
- η = 75% (hiệu suất ước tính)

P_điện = U × I = 7.4 × 4 = 29.6W
P_cơ = P_điện × η = 29.6 × 0.75 = 22.2W
```

**Bước 2: Tính mô men định mức**

```
ω_rated = 2π × 8000 / 60 = 837.8 rad/s

M_rated = P_cơ / ω_rated = 22.2 / 837.8 = 0.0265 N.m
```

**Bước 3: Tính K_m**

```
K_m = M_rated / I_rated = 0.0265 / 4 = 0.00663 N.m/A

Hoặc: 6.63 mN.m/A
```

**Bước 4: Kiểm tra với K_e**

```
K_e = 0.00557 V/(rad/s)
K_m = 0.00663 N.m/A

Sai số = (0.00663 - 0.00557) / 0.00557 × 100% = 19%

→ Sai số do:
  - Tổn thất cơ học
  - Hiệu suất động cơ < 100%
  - Sai số đo
```

### Quan hệ K_m = K_e

**Chứng minh từ bảo toàn năng lượng:**

```
Công suất điện vào = Công suất cơ ra (lý tưởng)

E_a × I_a = M × ω

(K_e × ω) × I_a = M × ω

K_e × I_a = M

M / I_a = K_e

→ K_m = K_e
```

**Trong thực tế:**
```
K_m ≈ K_e / η

Với η = 0.75 - 0.85 cho động cơ Brushed
```

### Bảng tra K_m các động cơ

| Động cơ | K_m (N.m/A) | K_m (mN.m/A) | Ghi chú |
|---------|-------------|--------------|---------|
| 540 Motor | 0.005 | 5.0 | Nhỏ, cao tốc |
| 550 Motor | 0.0066 | 6.6 | **Huina 1592** |
| 555 Motor | 0.008 | 8.0 | Lớn, mô men cao |

### Ứng dụng thực tế

**1. Tính mô men ở dòng điện bất kỳ:**

```
Khi I_a = 3A:
M = K_m × I_a = 0.0066 × 3 = 0.0198 N.m = 19.8 mN.m
```

**2. Tính dòng điện cần thiết:**

```
Muốn M = 0.03 N.m:
I_a = M / K_m = 0.03 / 0.0066 = 4.55A

→ Kiểm tra: 4.55A > I_rated (4A)
→ Động cơ bị quá tải 14%
```

**3. Tính mô men khởi động tối đa:**

```
I_start_max = 2 × I_rated = 8A (giới hạn ESC)
M_start_max = K_m × I_start_max = 0.0066 × 8 = 0.053 N.m

→ Gấp đôi mô men định mức!
```

**4. Tính lực nâng gầu:**

```
Giả sử:
- Đường kính trống kéo: D = 20mm = 0.02m
- Hiệu suất cơ khí: η_mech = 0.6

Lực kéo:
F = M × η_mech / (D/2)
F = 0.0265 × 0.6 / 0.01 = 1.59 N

Khối lượng nâng:
m = F / g = 1.59 / 9.81 = 0.162 kg = 162g

→ Phù hợp với Huina 1592 (gầu nâng ~150-200g)
```

---

## 3.1.4 - Xác định hằng số thời gian điện (T_a)

### Khái niệm

Hằng số thời gian điện T_a đặc trưng cho tốc độ thay đổi dòng điện phần ứng khi có điện áp đầu vào thay đổi.

**GIẢI THÍCH CHI TIẾT:**

Khi đặt điện áp vào động cơ DC, dòng điện không tăng ngay lập tức mà tăng dần theo hàm mũ do hiện tượng tự cảm. T_a là thời gian để dòng điện đạt 63.2% giá trị cuối cùng.

**Ý nghĩa vật lý:**
- T_a nhỏ → Dòng điện thay đổi nhanh, động cơ đáp ứng nhanh
- T_a lớn → Dòng điện thay đổi chậm, có độ trễ
- Thường T_a << T_m (hằng số thời gian cơ)

### Công thức tính

```
T_a = L_a / R_a
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `T_a`: Hằng số thời gian điện (s)
- `L_a`: Độ tự cảm phần ứng (H)
- `R_a`: Điện trở phần ứng (Ω)

### Thông số động cơ 540/550

| Động cơ | L_a (mH) | R_a (Ω) | T_a (ms) |
|---------|----------|---------|----------|
| 540 Motor | 0.15 | 0.6 | 0.25 |
| 550 Motor | 0.20 | 0.8 | **0.25** |
| 555 Motor | 0.25 | 1.0 | 0.25 |

**Giá trị sử dụng:** T_a = **0.25 ms** = 0.00025 s

### VÍ DỤ TÍNH TOÁN

```
Cho:
L_a = 0.2 mH = 0.0002 H
R_a = 0.8 Ω

T_a = L_a / R_a = 0.0002 / 0.8 = 0.00025 s = 0.25 ms
```

### Đáp ứng dòng điện

```
I_a(t) = I_∞ × (1 - e^(-t/T_a))

Trong đó:
- I_∞ = (U - E_a) / R_a (dòng điện xác lập)
```

**Bảng thời gian:**

| Thời gian | % I_∞ |
|-----------|-------|
| t = 0 | 0% |
| t = T_a | 63.2% |
| t = 3T_a | 95% |
| t = 5T_a | 99.3% |

**Ví dụ:**
```
T_a = 0.25 ms

Thời gian đạt 95% dòng điện:
t = 3 × T_a = 3 × 0.25 = 0.75 ms

→ Rất nhanh! Hầu như tức thời
```

### So sánh với PWM

```
Tần số PWM thông thường: f = 20 kHz
Chu kỳ PWM: T_PWM = 1/f = 0.05 ms = 50 μs

T_a / T_PWM = 0.25 / 0.05 = 5

→ T_a gấp 5 lần chu kỳ PWM
→ Dòng điện chưa kịp xác lập trong 1 chu kỳ
→ Dòng trung bình phụ thuộc vào Duty cycle
```

### Ứng dụng

**Vì T_a << T_m**, trong hầu hết ứng dụng điều khiển động cơ RC, ta có thể:
- Bỏ qua T_a trong mô hình động học
- Coi dòng điện thay đổi tức thời với điện áp PWM
- Tập trung vào T_m (hằng số cơ) quan trọng hơn

---

## 3.1.5 - Xác định hằng số thời gian cơ (T_m)

### Khái niệm

Hằng số thời gian cơ T_m đặc trưng cho tốc độ thay đổi vận tốc góc của động cơ khi có mô men tác động.

**GIẢI THÍCH CHI TIẾT:**

Khi có mô men điện từ tác động, động cơ không tăng tốc ngay lập tức mà tăng dần do quán tính. T_m là thời gian để tốc độ đạt 63.2% giá trị cuối cùng.

**Ý nghĩa vật lý:**
- T_m nhỏ → Động cơ tăng/giảm tốc nhanh (phản ứng nhanh)
- T_m lớn → Động cơ tăng/giảm tốc chậm (ổn định hơn)
- T_m >> T_a (gấp hàng trăm lần)

### Công thức tính

```
T_m = (J_total × R_a) / (K_e × K_m)
```

Hoặc đơn giản hơn (vì K_e ≈ K_m):

```
T_m = (J_total × R_a) / K_e²
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `T_m`: Hằng số thời gian cơ (s)
- `J_total`: Mô men quán tính tổng (kg.m²)
- `R_a`: Điện trở phần ứng (Ω)
- `K_e`: Hằng số EMF (V/(rad/s))
- `K_m`: Hằng số mô men (N.m/A)

### Tính mô men quán tính

**1. Động cơ 550:**

```
J_motor ≈ 0.00005 kg.m²
```

**2. Tải (gầu + vật xúc):**

```
Giả sử:
- Khối lượng gầu: m_gau = 0.05 kg
- Bán kính quay hiệu dụng: r = 0.15 m (cần xúc 15cm)
- Hệ số quy đổi: η = 0.5

J_load = m_gau × r² / η² = 0.05 × 0.15² / 0.5² = 0.0045 kg.m²
```

**3. Tổng:**

```
J_total = J_motor + J_load = 0.00005 + 0.0045 = 0.00455 kg.m²

→ Tải >> Động cơ (gấp 90 lần!)
```

### VÍ DỤ TÍNH TOÁN

**Trường hợp không tải (chạy không):**

```
J_total = J_motor = 0.00005 kg.m²
R_a = 0.8 Ω
K_e = 0.00557 V/(rad/s)

T_m = (J_total × R_a) / K_e²
T_m = (0.00005 × 0.8) / 0.00557²
T_m = 0.00004 / 0.000031
T_m = 0.00129 s = 1.29 ms
```

**Trường hợp có tải (nâng gầu):**

```
J_total = 0.00455 kg.m²
R_a = 0.8 Ω
K_e = 0.00557 V/(rad/s)

T_m = (0.00455 × 0.8) / 0.00557²
T_m = 0.00364 / 0.000031
T_m = 0.117 s = 117 ms
```

### So sánh T_a và T_m

| Tham số | T_a | T_m (không tải) | T_m (có tải) |
|---------|-----|-----------------|--------------|
| Giá trị | 0.25 ms | 1.3 ms | 117 ms |
| Tỷ lệ | 1× | 5× | 468× |

**Kết luận:**
- T_m >> T_a (gấp hàng trăm lần)
- Động học cơ chậm hơn động học điện rất nhiều
- Trong điều khiển, T_m là yếu tố giới hạn tốc độ đáp ứng

### Thời gian tăng tốc

```
Thời gian để đạt 95% tốc độ:
t_95 = 3 × T_m = 3 × 117 = 351 ms ≈ 0.35 s

Thời gian để đạt 99% tốc độ:
t_99 = 5 × T_m = 5 × 117 = 585 ms ≈ 0.6 s
```

### Ứng dụng thực tế

**1. Điều khiển PID:**

```
Tần số lấy mẫu nên chọn:
f_sample ≥ 10 / T_m = 10 / 0.117 = 85 Hz

→ Chọn f_sample = 100 Hz (T_sample = 10 ms)
```

**2. Thời gian nâng gầu:**

```
Từ dừng → tốc độ tối đa:
t ≈ 3 × T_m = 351 ms

Để nâng gầu 20cm ở tốc độ trung bình 10 cm/s:
t_total = 20 / 10 + 0.351 = 2.351 s

→ Mất ~2.3s để nâng gầu lên
```

---

## 3.1.6 - Xác định đặc tính cơ động cơ

### Khái niệm

Đặc tính cơ là quan hệ giữa tốc độ (n) và mô men (M) của động cơ. Nó cho biết động cơ hoạt động như thế nào ở các điều kiện tải khác nhau.

**GIẢI THÍCH CHI TIẾT:**

Đặc tính cơ có 2 loại:
1. **Đặc tính tự nhiên**: U = U_rated, Φ = Φ_rated, không có điện trở phụ
2. **Đặc tính nhân tạo**: Thay đổi U hoặc R để điều khiển

### Phương trình đặc tính cơ

**1. Dạng tổng quát:**

```
n = n_0 - (R_a / K_e²) × M
```

**GIẢI THÍCH TỪNG KÝ HIỆU:**
- `n`: Tốc độ (rpm)
- `n_0`: Tốc độ không tải (rpm)
- `M`: Mô men (N.m)
- `R_a`: Điện trở phần ứng (Ω)
- `K_e`: Hằng số EMF (V/(rad/s))

**2. Tốc độ không tải:**

```
n_0 = U_supply / (K_e × 2π/60)
```

**3. Độ dốc đặc tính:**

```
Δn = (R_a × 60) / (K_e² × 2π)
```

### VÍ DỤ TÍNH TOÁN

**Bước 1: Tính n_0**

```
U_supply = 7.4V
K_e = 0.00557 V/(rad/s)

n_0 = U_supply / (K_e × 2π/60)
n_0 = 7.4 / (0.00557 × 0.1047)
n_0 = 12690 rpm
```

**Bước 2: Tính độ dốc**

```
R_a = 0.8 Ω
K_e = 0.00557 V/(rad/s)

Δn = (R_a × 60) / (K_e² × 2π)
Δn = (0.8 × 60) / (0.00557² × 2π)
Δn = 48 / 0.000195
Δn = 246154 rpm/(N.m)
```

**Bước 3: Phương trình đặc tính**

```
n (rpm) = 12690 - 246154 × M (N.m)
```

**Bước 4: Tính một vài điểm**

```
M = 0 N.m:     n = 12690 rpm (không tải)
M = 0.01 N.m:  n = 12690 - 2462 = 10228 rpm
M = 0.02 N.m:  n = 12690 - 4923 = 7767 rpm
M = 0.03 N.m:  n = 12690 - 7385 = 5305 rpm
```

### Đặc tính với các điện áp khác nhau

```
U = 3.7V:  n = 6345 - 246154 × M
U = 5.0V:  n = 8554 - 246154 × M
U = 7.4V:  n = 12690 - 246154 × M
U = 11.1V: n = 19034 - 246154 × M (nâng cấp 3S)
```

### Vẽ đồ thị

```
n (rpm)
    |
12690|●___
    |    ＼___
10000|        ＼___
    |            ＼___
 8000|                ●___  U=7.4V
    |                    ＼___
 6000|                        ＼___
    |                            ＼___
 4000|                                ●___
    |                                    ＼___
    |_____________________________________●_____ M (N.m)
    0    0.01   0.02   0.03   0.04   0.05
```

### Ứng dụng thực tế

**1. Chọn điểm làm việc:**

```
Muốn n = 8000 rpm ở tải 0.02 N.m:

Kiểm tra: n = 12690 - 246154 × 0.02 = 7767 rpm

→ Gần 8000 rpm! ✓
```

**2. Tính công suất:**

```
Tại n = 8000 rpm, M = 0.02 N.m:
ω = 8000 × 2π/60 = 837.8 rad/s
P = M × ω = 0.02 × 837.8 = 16.76 W
```

**3. Điều chỉnh PWM:**

```
Muốn n = 6000 rpm ở M = 0.02 N.m:
n_0_cần = 6000 + 246154 × 0.02 = 10923 rpm

U_cần = n_0_cần × K_e × 2π/60
U_cần = 10923 × 0.00557 × 0.1047 = 6.37V

Duty = U_cần / U_supply = 6.37 / 7.4 = 86%
```

---

## TÓM TẮT PHẦN 1

### Bảng tổng hợp thông số động cơ Huina 1592

| Thông số | Ký hiệu | Giá trị | Đơn vị |
|----------|---------|---------|--------|
| Điện trở phần ứng | R_a | 0.8 | Ω |
| Độ tự cảm phần ứng | L_a | 0.2 | mH |
| Hằng số EMF | K_e | 0.00557 | V/(rad/s) |
| Hằng số mô men | K_m | 0.0066 | N.m/A |
| Mô men quán tính motor | J_motor | 0.00005 | kg.m² |
| Mô men quán tính tải | J_load | 0.0045 | kg.m² |
| Hằng số thời gian điện | T_a | 0.25 | ms |
| Hằng số thời gian cơ | T_m | 117 | ms |
| Tốc độ không tải | n_0 | 12690 | rpm |
| Độ dốc đặc tính | Δn | 246154 | rpm/(N.m) |

### Các công thức quan trọng

```
1. Điện trở:         R_a = U_test / I_test
2. Hằng số EMF:      K_e = E_a / ω
3. Hằng số mô men:   K_m = M / I_a  (≈ K_e)
4. Thời gian điện:   T_a = L_a / R_a
5. Thời gian cơ:     T_m = (J × R_a) / K_e²
6. Đặc tính cơ:      n = n_0 - Δn × M
```

---

**HẾT PHẦN 1**

Tiếp theo: [Phần 2 - Điều khiển PWM và ESC](chuong3_phan2.md)

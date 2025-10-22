# HƯỚNG DẪN THỰC NGHIỆM VỚI HUINA 1592

##  MỤC LỤC
1. [Giới thiệu](#1-giới-thiệu)
2. [Thiết bị cần thiết](#2-thiết-bị-cần-thiết)
3. [Chuẩn bị thực nghiệm](#3-chuẩn-bị-thực-nghiệm)
4. [Các thí nghiệm cơ bản](#4-các-thí-nghiệm-cơ-bản)
5. [Các thí nghiệm nâng cao](#5-các-thí-nghiệm-nâng-cao)
6. [Thu thập và xử lý dữ liệu](#6-thu-thập-và-xử-lý-dữ-liệu)
7. [An toàn thực nghiệm](#7-an-toàn-thực-nghiệm)
8. [Troubleshooting](#8-troubleshooting)

---

## 1. GIỚI THIỆU

### 1.1. Mục tiêu thực nghiệm
Hướng dẫn này giúp bạn:
-  Đo đạc các thông số thực tế của động cơ DC 540/550 trên Huina 1592
-  Kiểm chứng các tính toán lý thuyết với kết quả thực tế
-  Hiểu rõ đặc tính động cơ DC và điều khiển PWM
-  Xây dựng cơ sở để phát triển hệ thống điều khiển tự động

### 1.2. Đối tượng thực nghiệm
- **Mô hình:** Huina 1592 RC Excavator (1:14 scale)
- **Động cơ:** 540/550 Brushed DC Motor
- **Điện áp:** 7.4V (2S LiPo)
- **Công suất:** 30W nominal
- **Tốc độ không tải:** 8000 rpm

---

## 2. THIẾT BỊ CẦN THIẾT

### 2.1. Thiết bị đo lường
#### A. Thiết bị BẮT BUỘC:
1. **Đồng hồ vạn năng số (Multimeter)**
   - Đo được dòng điện tối thiểu 5A
   - Đo được điện áp 0-20V
   - Giá: 200,000 - 500,000 VND
   - Ví dụ: DT-830B, DT-9205A

2. **Máy đo tốc độ quay (Tachometer)**
   - Loại không tiếp xúc (laser/quang học)
   - Dải đo: 10-99,999 RPM
   - Giá: 300,000 - 800,000 VND
   - Ví dụ: DT-2234C+

3. **Nguồn DC điều chỉnh được**
   - Điện áp: 0-15V
   - Dòng điện: tối thiểu 5A
   - Giá: 400,000 - 1,000,000 VND
   - Hoặc dùng Pin LiPo 2S (7.4V) + sạc cân bằng

4. **Đồng hồ đo công suất (Wattmeter)**
   - Đo được V, A, W, mAh
   - Giá: 150,000 - 400,000 VND
   - Ví dụ: GT Power RC Wattmeter

#### B. Thiết bị KHUYẾN NGHỊ:
1. **Oscilloscope (Máy hiện sóng)**
   - Để quan sát dạng sóng PWM
   - Băng thông tối thiểu: 20 MHz
   - Giá: 1,500,000 - 5,000,000 VND
   - Ví dụ: DSO138, Hantek DSO5072P
   - **Alternative:** Logic Analyzer (rẻ hơn, 200k-500k)

2. **Máy đo mômen xoắn**
   - Dải đo: 0-1 Nm
   - Giá: 2,000,000+ VND
   - **Alternative:** Phương pháp cân bằng với cánh tay đòn

3. **Cảm biến nhiệt độ**
   - Loại không tiếp xúc (IR) hoặc thermocouple
   - Giá: 100,000 - 300,000 VND

### 2.2. Thiết bị điều khiển
1. **Arduino Uno/Nano**
   - Để tạo tín hiệu PWM chính xác
   - Giá: 70,000 - 150,000 VND

2. **Module ESC hoặc H-Bridge**
   - **Option 1:** ESC sẵn có của Huina 1592
   - **Option 2:** Module H-Bridge L298N (30,000-50,000 VND)
   - **Option 3:** Module BTS7960 (100,000-150,000 VND - tốt hơn)

3. **Breadboard và dây nối**
   - Breadboard 830 điểm
   - Dây jumper đủ màu
   - Giá: 50,000 - 100,000 VND

### 2.3. Phụ kiện khác
- Băng keo cách điện
- Dây đồng tiết diện 1.5mm² (chịu được 5A)
- Đế gá động cơ (có thể in 3D hoặc làm bằng gỗ)
- Cánh quạt/tải giả (để tạo tải cho động cơ)
- Sổ ghi chép/máy tính để ghi dữ liệu

---

## 3. CHUẨN BỊ THỰC NGHIỆM

### 3.1. Chuẩn bị mô hình Huina 1592

#### Bước 1: Tháo rời động cơ
```
 LƯU Ý: Chụp ảnh hoặc đánh dấu vị trí dây trước khi tháo!

1. Tắt nguồn, tháo pin ra khỏi mô hình
2. Tháo vỏ che để tiếp cận động cơ (thường là động cơ di chuyển)
3. Gỡ các connector điện (chú ý cực +/-)
4. Tháo ốc vít cố định động cơ
5. Cẩn thận tháo động cơ cùng với hộp số (nếu có)
```

#### Bước 2: Nhận diện động cơ
```
Kiểm tra:
 Loại động cơ: 540 hay 550 (đo đường kính thân: 36mm = 540, 38mm = 550)
 Số vòng dây (turns): thường in trên vỏ (ví dụ: 35T, 27T, 21T)
 Dây dẫn: 2 dây (động cơ brushed thường)
 Tình trạng: không có vết cháy, không mùi khét
```

#### Bước 3: Gá động cơ lên bàn thí nghiệm
```
Cách 1: Giữ nguyên trong mô hình (dễ nhất)
  - Nhưng khó đo tốc độ và mômen

Cách 2: Gá động cơ ra ngoài (khuyến nghị)
  - Làm giá đỡ bằng gỗ hoặc in 3D
  - Cố định chắc chắn bằng vít
  - Trục động cơ phải quay tự do
  - Dán băng phản quang lên trục để đo tốc độ
```

### 3.2. Lắp đặt mạch đo

#### Sơ đồ kết nối cơ bản:
```
        Nguồn 7.4V
           |
           |
    +------+------+
    |             |
    |          [Ampe kế]
    |             |
    |             |
    V          [ESC/H-Bridge]
 [Vôn kế]         |
    |          [Động cơ]
    |             |
    +------+------+
           |
          GND
```

#### Sơ đồ kết nối với Arduino (PWM control):
```
Arduino Nano/Uno
  ┌─────────────┐
  │   D9 (PWM)  │────────> ESC Signal
  │             │
  │   D2        │────────> Start Button
  │   D3        │────────> Stop Button
  │             │
  │   GND       │────────> GND chung
  │   5V        │────────> (không dùng)
  └─────────────┘

ESC / H-Bridge
  Signal ───────> từ Arduino D9
  VCC ───────────> 7.4V từ Pin
  GND ───────────> GND chung
  OUT+ ──────────> Động cơ (+)
  OUT- ──────────> Động cơ (-)
```

### 3.3. Kiểm tra an toàn
```
 Tất cả kết nối chắc chắn, không bị lỏng
 Không có chập mạch giữa dây + và -
 Động cơ được cố định chắc chắn
 Trục động cơ không va chạm vật cản
 Có bảo vệ quá dòng (fuse hoặc trong nguồn)
 Khu vực thí nghiệm thông thoáng, không cháy nổ
 Có dụng cụ dập lửa (bình cứu hỏa mini) gần đó
```

---

## 4. CÁC THÍ NGHIỆM CƠ BẢN

### Thí nghiệm 1: Đo điện trở phần ứng (Ra)

#### Mục tiêu:
Xác định điện trở của cuộn dây động cơ (R_a)

#### Thiết bị:
- Đồng hồ vạn năng (chế độ đo Ω)
- Động cơ (đứng yên)

#### Các bước thực hiện:
```
1. Tháo động cơ ra khỏi mạch điện
2. Chọn chế độ đo điện trở (Ω) trên đồng hồ
3. Đo ở thang đo 200Ω hoặc 20Ω
4. Chạm đầu đo vào 2 cực của động cơ
5. Đọc giá trị trên màn hình
6. Lặp lại 5 lần, lấy trung bình
```

#### Kết quả mong đợi:
```
Giá trị lý thuyết: R_a ≈ 0.4 - 0.8 Ω (động cơ 540/550)

Lưu ý:
- Nếu đo được 0Ω → đồng hồ chưa đúng hoặc chập mạch
- Nếu đo được ∞Ω → động cơ đứt dây, hỏng
- Nếu đo được > 5Ω → động cơ yếu hoặc sai loại
```

#### Ghi dữ liệu:
```
Bảng 1: Đo điện trở phần ứng

Lần đo | R_a (Ω) | Ghi chú
-------|---------|--------
1      |         |
2      |         |
3      |         |
4      |         |
5      |         |
-------|---------|--------
TB     |         | R_a trung bình
```

---

### Thí nghiệm 2: Đo dòng điện không tải (I_0)

#### Mục tiêu:
Xác định dòng điện khi động cơ quay không tải (I_0)

#### Thiết bị:
- Nguồn DC 7.4V
- Ampe kế (thang 5A)
- Tachometer

#### Các bước thực hiện:
```
1. Kết nối ampe kế nối tiếp với động cơ
2. Đảm bảo trục động cơ quay tự do (không tải)
3. Cấp điện áp 7.4V
4. Đợi 5 giây cho động cơ ổn định
5. Đọc dòng điện I_0
6. Đồng thời đo tốc độ không tải n_0
7. Tắt nguồn, chờ động cơ nguội
8. Lặp lại 3 lần
```

#### Kết quả mong đợi:
```
Giá trị lý thuyết:
- I_0 ≈ 0.3 - 0.8 A (dòng không tải)
- n_0 ≈ 7500 - 8500 rpm (tốc độ không tải)

Nếu I_0 > 1.5A → có thể bị kẹt ổ bi, tải ký sinh
```

#### Ghi dữ liệu:
```
Bảng 2: Dòng điện không tải

Lần đo | V (V) | I_0 (A) | n_0 (rpm) | Ghi chú
-------|-------|---------|-----------|--------
1      | 7.4   |         |           |
2      | 7.4   |         |           |
3      | 7.4   |         |           |
-------|-------|---------|-----------|--------
TB     | 7.4   |         |           |
```

---

### Thí nghiệm 3: Đo dòng điện định mức (I_n)

#### Mục tiêu:
Xác định dòng điện khi động cơ hoạt động ở chế độ định mức

#### Thiết bị:
- Nguồn DC 7.4V
- Ampe kế, vôn kế
- Wattmeter
- Tải giả (quạt, phanh từ, hoặc tải cơ)

#### Các bước thực hiện:
```
1. Lắp tải lên trục động cơ (bắt đầu với tải nhẹ)
2. Kết nối đầy đủ: V, A, W
3. Cấp điện 7.4V
4. Tăng dần tải cho đến khi P ≈ 30W
5. Đo: V, I, P, n (tốc độ)
6. Tính: hiệu suất η = P_ra / P_vào
7. Giữ trong 10 giây, kiểm tra nhiệt độ
8. Nếu quá nóng (>70°C) → giảm tải
```

#### Kết quả mong đợi:
```
Điểm định mức:
- V_n = 7.4V
- I_n ≈ 4A
- P_n ≈ 30W
- n_n ≈ 6000-7000 rpm (có tải)

 Không giữ động cơ ở I > 5A quá 30 giây!
```

#### Ghi dữ liệu:
```
Bảng 3: Đặc tính định mức

Thông số    | Giá trị | Đơn vị | Ghi chú
------------|---------|--------|--------
V_n         | 7.4     | V      |
I_n         |         | A      |
P_in        |         | W      | (V × I)
n_n         |         | rpm    |
M_n         |         | mNm    | (tính toán)
Nhiệt độ    |         | °C     | (sau 1 phút)
```

---

### Thí nghiệm 4: Đo hằng số sức điện động (K_e)

#### Mục tiêu:
Xác định hệ số K_e (V/rad/s) hoặc K_e' (V/rpm)

#### Phương pháp 1: Từ EMF ngược
```
1. Cho động cơ chạy không tải ở 7.4V
2. Đo: V = 7.4V, I_0, n_0
3. Tính EMF ngược: E = V - I_0 × R_a
4. Đổi n_0 sang rad/s: ω = n_0 × (2π/60)
5. Tính: K_e = E / ω

Ví dụ:
V = 7.4V, I_0 = 0.5A, R_a = 0.5Ω, n_0 = 8000 rpm
E = 7.4 - 0.5×0.5 = 7.15V
ω = 8000 × (2π/60) = 837.76 rad/s
K_e = 7.15 / 837.76 = 0.00853 V/(rad/s)
```

#### Phương pháp 2: Từ đặc tính n = f(V)
```
1. Đo tốc độ không tải ở nhiều điện áp:
   V = 3V, 5V, 7.4V, 9V
2. Vẽ đồ thị n = f(V)
3. Tính độ dốc: dn/dV
4. K_e = 1 / (độ dốc)
```

#### Ghi dữ liệu:
```
Bảng 4: Tính K_e

V (V) | I_0 (A) | n_0 (rpm) | E (V) | ω (rad/s) | K_e (V/rad/s)
------|---------|-----------|-------|-----------|---------------
3.0   |         |           |       |           |
5.0   |         |           |       |           |
7.4   |         |           |       |           |
9.0   |         |           |       |           |
------|---------|-----------|-------|-----------|---------------
Trung bình K_e:                                 |
```

---

### Thí nghiệm 5: Đặc tính cơ n = f(M)

#### Mục tiêu:
Xây dựng đường đặc tính cơ của động cơ

#### Thiết bị:
- Nguồn 7.4V
- Ampe kế
- Tachometer
- Tải điều chỉnh được (phanh từ hoặc tải cơ)

#### Các bước thực hiện:
```
1. Bắt đầu không tải: đo n_0, I_0
2. Tăng dần tải theo các bước 10%, 20%, ..., 100%
3. Mỗi điểm tải:
   - Đo: I, n
   - Tính: M = K_m × I (hoặc đo trực tiếp)
   - Ghi dữ liệu
4. Vẽ đồ thị n = f(M)
5. Kiểm tra tính tuyến tính
```

#### Ghi dữ liệu:
```
Bảng 5: Đặc tính cơ

Tải (%) | I (A) | n (rpm) | M (mNm) | P_out (W) | Ghi chú
--------|-------|---------|---------|-----------|--------
0       |       |         | 0       | 0         | Không tải
25      |       |         |         |           |
50      |       |         |         |           |
75      |       |         |         |           |
100     |       |         |         |           | Định mức
--------|-------|---------|---------|-----------|--------
```

#### Vẽ đồ thị:
```
Dùng Excel hoặc MATLAB để vẽ:
- Trục X: Mômen M (mNm)
- Trục Y: Tốc độ n (rpm)
- Đường cong: n = n_0 - (n_0/M_max) × M
```

---

## 5. CÁC THÍ NGHIỆM NÂNG CAO

### Thí nghiệm 6: Điều khiển PWM

#### Mục tiêu:
Nghiên cứu ảnh hưởng của duty cycle đến tốc độ động cơ

#### Thiết bị:
- Arduino Uno/Nano
- ESC hoặc H-Bridge
- Oscilloscope (nếu có)

#### Code Arduino:
```cpp
// File: PWM_Control_Test.ino
// Điều khiển PWM cho động cơ DC

const int motorPin = 9;     // PWM pin
const int buttonUp = 2;     // Tăng PWM
const int buttonDown = 3;   // Giảm PWM

int dutyCycle = 0;          // 0-255

void setup() {
  pinMode(motorPin, OUTPUT);
  pinMode(buttonUp, INPUT_PULLUP);
  pinMode(buttonDown, INPUT_PULLUP);
  
  Serial.begin(9600);
  Serial.println("PWM Control Test");
  Serial.println("Duty: 0-255, Speed: rpm");
}

void loop() {
  // Đọc nút nhấn
  if (digitalRead(buttonUp) == LOW) {
    dutyCycle = min(dutyCycle + 10, 255);
    delay(200);
  }
  if (digitalRead(buttonDown) == LOW) {
    dutyCycle = max(dutyCycle - 10, 0);
    delay(200);
  }
  
  // Xuất PWM
  analogWrite(motorPin, dutyCycle);
  
  // Hiển thị
  Serial.print("Duty: ");
  Serial.print(dutyCycle);
  Serial.print(" (");
  Serial.print((dutyCycle/255.0)*100, 1);
  Serial.println("%)");
  
  delay(100);
}
```

#### Các bước thực hiện:
```
1. Upload code lên Arduino
2. Kết nối Arduino → ESC → Motor
3. Mở Serial Monitor (9600 baud)
4. Thay đổi duty cycle: 0%, 25%, 50%, 75%, 100%
5. Mỗi điểm:
   - Đo tốc độ n
   - Đo dòng điện I
   - Đo điện áp trung bình (nếu có oscilloscope)
6. Vẽ đồ thị n = f(duty%)
```

#### Ghi dữ liệu:
```
Bảng 6: PWM vs Tốc độ

Duty (%) | Duty (0-255) | V_avg (V) | I (A) | n (rpm) | n/n_max (%)
---------|--------------|-----------|-------|---------|------------
0        | 0            | 0         | 0     | 0       | 0
25       | 64           |           |       |         |
50       | 128          |           |       |         |
75       | 192          |           |       |         |
100      | 255          | 7.4       |       |         | 100
---------|--------------|-----------|-------|---------|------------
```

#### Phân tích:
```
 n có tuyến tính với duty% không?
 V_avg = V_supply × (duty/100) ?
 Tốc độ tối đa đạt được bao nhiêu?
 Có hiện tượng "dead zone" ở duty thấp không?
```

---

### Thí nghiệm 7: Đo dòng điện gợn sóng (Ripple Current)

#### Mục tiêu:
Đo biên độ dòng điện gợn sóng khi điều khiển PWM

#### Thiết bị:
- Oscilloscope
- Current probe hoặc shunt resistor (0.1Ω, 5W)

#### Sơ đồ đo:
```
    +7.4V
      |
      |
   [Shunt]---+--- Probe 1 (CH1)
      |      |
      |      +--- Probe 2 (CH2)
      |
    [ESC]
      |
   [Motor]
      |
     GND

Đo: V_ripple = V_CH1 - V_CH2
Tính: I_ripple = V_ripple / R_shunt
```

#### Các bước thực hiện:
```
1. Lắp shunt resistor nối tiếp với động cơ
2. Kết nối oscilloscope qua 2 đầu shunt
3. Cài đặt oscilloscope:
   - Timebase: 10μs/div (để thấy PWM 20kHz)
   - Voltage: 100mV/div
   - Trigger: Rising edge
4. Chạy PWM ở duty = 50%
5. Đo:
   - I_avg (dòng trung bình)
   - ΔI_pp (biên độ peak-to-peak)
   - Tần số PWM thực tế
6. Lặp lại với duty = 25%, 75%
```

#### Ghi dữ liệu:
```
Bảng 7: Dòng gợn sóng

Duty (%) | I_avg (A) | ΔI_pp (A) | ΔI/I_avg (%) | f_PWM (kHz)
---------|-----------|-----------|--------------|------------
25       |           |           |              |
50       |           |           |              |
75       |           |           |              |
---------|-----------|-----------|--------------|------------
```

#### So sánh với lý thuyết:
```
Công thức: ΔI = (V_in × D × (1-D)) / (L × f_PWM)

Với:
- V_in = 7.4V
- D = duty cycle (0-1)
- L = inductance động cơ (ước tính ~100μH)
- f_PWM = 20kHz

ΔI_max ở D = 0.5:
ΔI = (7.4 × 0.5 × 0.5) / (100e-6 × 20e3)
ΔI = 1.85 / 2 = 0.925 A

So sánh với kết quả đo!
```

---

### Thí nghiệm 8: Hiệu suất hệ thống

#### Mục tiêu:
Xác định hiệu suất tổng (động cơ + ESC)

#### Công thức:
```
η_total = P_out / P_in

Trong đó:
- P_in = V_battery × I_battery (công suất đầu vào từ pin)
- P_out = M × ω = M × (2π × n / 60) (công suất cơ trên trục)
```

#### Các bước thực hiện:
```
1. Đo công suất đầu vào:
   - Đặt wattmeter giữa pin và ESC
   - Đọc: V_in, I_in, P_in

2. Đo công suất đầu ra:
   - Đo tốc độ: n (rpm)
   - Đo mômen: M (mNm)
   - Tính: P_out = M × (2πn/60) / 1000 (W)

3. Tính hiệu suất:
   - η = (P_out / P_in) × 100%

4. Lặp lại ở nhiều điểm tải: 25%, 50%, 75%, 100%
```

#### Ghi dữ liệu:
```
Bảng 8: Hiệu suất hệ thống

Tải | V_in | I_in | P_in | n   | M    | P_out | η    | Tổn thất
(%) | (V)  | (A)  | (W)  |(rpm)|(mNm) | (W)   | (%)  | (W)
----|------|------|------|-----|------|-------|------|--------
25  | 7.4  |      |      |     |      |       |      |
50  | 7.4  |      |      |     |      |       |      |
75  | 7.4  |      |      |     |      |       |      |
100 | 7.4  |      |      |     |      |       |      |
----|------|------|------|-----|------|-------|------|--------
```

#### Phân tích tổn thất:
```
Tổn thất = P_in - P_out

Phân loại tổn thất:
1. Tổn thất đồng (I²R): P_Cu = I² × R_a
2. Tổn thất sắt + ma sát: P_mech ≈ P_0 (công suất không tải)
3. Tổn thất ESC: P_ESC = V_drop × I + P_switching

Tính % từng loại:
- % Copper loss = P_Cu / P_in × 100%
- % Mech loss = P_mech / P_in × 100%
- % ESC loss = P_ESC / P_in × 100%
```

---

### Thí nghiệm 9: Hằng số thời gian

#### Mục tiêu:
Đo hằng số thời gian điện (τ_a) và cơ (τ_m)

#### A. Hằng số thời gian điện (τ_a)

**Phương pháp:** Đo thời gian dòng điện tăng từ 0 đến 63.2% giá trị ổn định

```
Các bước:
1. Chặn trục động cơ (rotor locked)
2. Kết nối oscilloscope đo dòng điện
3. Cấp bước nhảy điện áp: 0V → 7.4V
4. Quan sát dạng sóng I(t)
5. Đo thời gian đến 63.2% I_max
6. τ_a = thời gian này

Lý thuyết:
τ_a = L_a / R_a

Ước tính:
- L_a ≈ 50-150 μH (động cơ 540/550)
- R_a ≈ 0.5 Ω
- τ_a ≈ 0.1-0.3 ms
```

#### B. Hằng số thời gian cơ (τ_m)

**Phương pháp:** Đo thời gian tốc độ tăng từ 0 đến 63.2% tốc độ ổn định

```
Các bước:
1. Động cơ quay tự do (không tải)
2. Cấp bước nhảy điện áp: 0V → 7.4V
3. Dùng tachometer ghi tốc độ theo thời gian
4. Vẽ đồ thị n(t)
5. Đo thời gian đến 63.2% n_max
6. τ_m = thời gian này

Lý thuyết:
τ_m = (J × R_a) / (K_e × K_m)

Ước tính:
- J ≈ 50-100 g·cm² (moment quán tính)
- τ_m ≈ 50-150 ms (động cơ nhỏ)
```

#### Ghi dữ liệu:
```
Bảng 9: Hằng số thời gian

Lần đo | τ_a (ms) | τ_m (ms) | Ghi chú
-------|----------|----------|--------
1      |          |          |
2      |          |          |
3      |          |          |
-------|----------|----------|--------
TB     |          |          |

So sánh với lý thuyết:
τ_a_theory = L_a / R_a = _____ ms
τ_m_theory = (J × R_a)/(K_e × K_m) = _____ ms
```

---

## 6. THU THẬP VÀ XỬ LÝ DỮ LIỆU

### 6.1. Ghi dữ liệu

#### Phương pháp thủ công:
```
Tạo bảng Excel với các cột:
- Thời gian đo
- Điều kiện (nhiệt độ, độ ẩm)
- Các thông số đo được (V, I, n, M, ...)
- Ghi chú
```

#### Phương pháp tự động (Arduino + PC):
```cpp
// File: Data_Logger.ino
// Ghi dữ liệu qua Serial

const int voltagePin = A0;
const int currentPin = A1;

void setup() {
  Serial.begin(115200);
  Serial.println("Time(ms),Voltage(V),Current(A)");
}

void loop() {
  unsigned long t = millis();
  float V = analogRead(voltagePin) * (5.0/1023.0) * 3; // scale
  float I = analogRead(currentPin) * (5.0/1023.0) * 2; // scale
  
  Serial.print(t);
  Serial.print(",");
  Serial.print(V, 3);
  Serial.print(",");
  Serial.println(I, 3);
  
  delay(10); // 100Hz sampling
}
```

**Lưu dữ liệu trên PC:**
```python
# File: serial_logger.py
import serial
import csv
from datetime import datetime

ser = serial.Serial('COM3', 115200)  # Đổi COM port
filename = f"data_{datetime.now().strftime('%Y%m%d_%H%M%S')}.csv"

with open(filename, 'w', newline='') as f:
    writer = csv.writer(f)
    
    while True:
        line = ser.readline().decode('utf-8').strip()
        print(line)
        writer.writerow(line.split(','))
        f.flush()  # Ghi ngay
```

### 6.2. Xử lý dữ liệu

#### Tính toán thống kê cơ bản:
```
Giá trị trung bình: x̄ = Σx_i / n
Độ lệch chuẩn: σ = sqrt(Σ(x_i - x̄)² / (n-1))
Sai số tương đối: ε = |x_đo - x_lý_thuyết| / x_lý_thuyết × 100%
```

#### Vẽ đồ thị (MATLAB):
```matlab
% File: plot_motor_characteristics.m
% Vẽ đặc tính động cơ

% Dữ liệu từ thí nghiệm 5
M = [0, 20, 40, 60, 80, 100];  % mNm
n = [8000, 7500, 7000, 6500, 6000, 5500];  % rpm

% Vẽ đồ thị
figure('Name', 'Đặc tính cơ động cơ Huina 1592');
plot(M, n, 'bo-', 'LineWidth', 2, 'MarkerSize', 8);
grid on;
xlabel('Mômen M (mNm)', 'FontSize', 12);
ylabel('Tốc độ n (rpm)', 'FontSize', 12);
title('Đặc tính cơ n = f(M)', 'FontSize', 14);

% Fitting tuyến tính
p = polyfit(M, n, 1);
n_fit = polyval(p, M);
hold on;
plot(M, n_fit, 'r--', 'LineWidth', 1.5);
legend('Dữ liệu thực nghiệm', 'Fitting tuyến tính', 'Location', 'best');

% Hiển thị phương trình
eq_text = sprintf('n = %.1f - %.2f×M', p(2), -p(1));
text(50, 7500, eq_text, 'FontSize', 11, 'BackgroundColor', 'white');
```

#### Vẽ đồ thị (Python):
```python
# File: plot_motor_data.py
import numpy as np
import matplotlib.pyplot as plt

# Dữ liệu
M = np.array([0, 20, 40, 60, 80, 100])  # mNm
n = np.array([8000, 7500, 7000, 6500, 6000, 5500])  # rpm

# Vẽ
plt.figure(figsize=(10, 6))
plt.plot(M, n, 'bo-', linewidth=2, markersize=8, label='Thực nghiệm')

# Fitting
coeffs = np.polyfit(M, n, 1)
n_fit = np.polyval(coeffs, M)
plt.plot(M, n_fit, 'r--', linewidth=1.5, label='Fitting')

plt.xlabel('Mômen M (mNm)', fontsize=12)
plt.ylabel('Tốc độ n (rpm)', fontsize=12)
plt.title('Đặc tính cơ động cơ Huina 1592', fontsize=14)
plt.grid(True, alpha=0.3)
plt.legend()

# Phương trình
eq = f"n = {coeffs[1]:.1f} - {-coeffs[0]:.2f}×M"
plt.text(50, 7500, eq, fontsize=11, bbox=dict(boxstyle='round', facecolor='white'))

plt.tight_layout()
plt.savefig('motor_characteristics.png', dpi=300)
plt.show()
```

### 6.3. Báo cáo kết quả

#### Cấu trúc báo cáo:
```
1. MỤC TIÊU
   - Mục đích thí nghiệm
   - Các thông số cần xác định

2. THIẾT BỊ
   - Danh sách thiết bị
   - Sơ đồ kết nối

3. PHƯƠNG PHÁP
   - Các bước thực hiện
   - Điều kiện thí nghiệm

4. KẾT QUẢ
   - Bảng dữ liệu
   - Đồ thị
   - Tính toán

5. PHÂN TÍCH
   - So sánh lý thuyết vs thực nghiệm
   - Sai số và nguyên nhân
   - Kết luận

6. TÀI LIỆU THAM KHẢO
```

---

## 7. AN TOÀN THỰC NGHIỆM

### 7.1. An toàn điện

```
 NGUY HIỂM
 Pin LiPo có thể phát nổ/cháy nếu bị chập mạch
 Dòng điện ngắn mạch có thể > 50A → rất nguy hiểm
 Luôn kiểm tra cực tính trước khi cấp điện

 BIỆN PHÁP AN TOÀN
 Dùng fuse hoặc MCB để bảo vệ quá dòng
 Không để dây trần chạm vào nhau
 Sạc pin LiPo đúng cách (balance charging)
 Không dùng pin sưng phồng hoặc hư hỏng
 Có bình cứu hỏa hoặc cát gần nơi làm việc
```

### 7.2. An toàn cơ khí

```
 NGUY HIỂM
 Trục động cơ quay với tốc độ 8000 rpm rất nguy hiểm
 Vật thể có thể văng ra nếu không cố định chắc
 Động cơ có thể nóng > 70°C

 BIỆN PHÁP AN TOÀN
 Cố định chắc chắn động cơ trước khi chạy
 Không đưa tay gần trục động cơ khi đang quay
 Dùng vỏ bảo vệ cho trục động cơ
 Đeo kính bảo hộ khi làm việc
 Để động cơ nguội trước khi chạm vào
```

### 7.3. An toàn nhiệt

```
 NGUY HIỂM
 Động cơ quá tải có thể nóng > 100°C
 ESC/MOSFET có thể bị cháy nếu quá nhiệt
 Pin LiPo quá nóng có thể phồng/nổ

 BIỆN PHÁP AN TOÀN
 Giám sát nhiệt độ bằng cảm biến
 Không chạy động cơ liên tục > 2 phút
 Có tản nhiệt cho ESC và động cơ
 Dừng ngay nếu thấy mùi khét
 Để nguội ít nhất 5 phút giữa các lần chạy
```

### 7.4. Quy trình khẩn cấp

```
 NẾU CÓ CHÁY
1. Ngắt nguồn ngay lập tức
2. Dùng bình cứu hỏa CO2 hoặc cát (KHÔNG dùng nước)
3. Di tản khỏi khu vực
4. Gọi 114 nếu cần

 NẾU BỊ ĐIỆN GIẬT
1. Ngắt nguồn ngay
2. Không chạm trực tiếp vào nạn nhân
3. Dùng vật cách điện để tách nạn nhân
4. Gọi 115 ngay lập tức

 NẾU ĐỘNG CƠ QUÁ NÓNG
1. Ngắt nguồn
2. Không chạm vào động cơ
3. Để nguội tự nhiên (không dùng nước)
4. Kiểm tra nguyên nhân trước khi chạy lại
```

---

## 8. TROUBLESHOOTING

### 8.1. Động cơ không quay

```
TRIỆU CHỨNG: Cấp điện nhưng động cơ không quay

NGUYÊN NHÂN CÓ THỂ:
1. Không có điện
   → Kiểm tra: pin, dây nối, công tắc
   
2. Động cơ bị kẹt
   → Kiểm tra: quay tay trục xem có mượt không
   
3. ESC bị lỗi
   → Thử: kết nối trực tiếp động cơ với pin (qua công tắc)
   
4. Động cơ hỏng (đứt dây)
   → Đo điện trở: nếu ∞Ω → hỏng

5. PWM duty quá thấp
   → Tăng duty cycle lên > 30%
```

### 8.2. Động cơ quay nhưng yếu

```
TRIỆU CHỨNG: Động cơ quay nhưng không đủ mạnh

NGUYÊN NHÂN CÓ THỂ:
1. Pin yếu
   → Đo điện áp: nếu < 7V → sạc pin
   
2. Dây quá nhỏ (tổn thất áp lớn)
   → Dùng dây tiết diện lớn hơn (> 1.5mm²)
   
3. Động cơ bị mài mòn chổi than
   → Thay chổi than hoặc động cơ mới
   
4. Tải quá lớn
   → Giảm tải hoặc dùng động cơ mạnh hơn

5. ESC giới hạn dòng
   → Kiểm tra cài đặt ESC
```

### 8.3. Động cơ quay rung giật

```
TRIỆU CHỨNG: Động cơ quay không đều, giật cục

NGUYÊN NHÂN CÓ THỂ:
1. Tần số PWM quá thấp
   → Tăng f_PWM lên > 10kHz
   
2. Trục bị cong hoặc ổ bi hỏng
   → Kiểm tra bằng tay, thay nếu cần
   
3. Chổi than tiếp xúc kém
   → Vệ sinh hoặc thay chổi than
   
4. Dây nối lỏng
   → Kiểm tra và vặn chặt

5. Nhiễu điện từ
   → Thêm tụ lọc (100nF) song song với động cơ
```

### 8.4. Động cơ quá nóng

```
TRIỆU CHỨNG: Động cơ nóng > 70°C sau < 1 phút

NGUYÊN NHÂN CÓ THỂ:
1. Quá tải
   → Giảm tải xuống < 30W
   
2. Chạy liên tục quá lâu
   → Chạy theo chu kỳ: 30s ON, 5 phút OFF
   
3. Ổ bi kẹt, ma sát lớn
   → Bôi trơn hoặc thay ổ bi
   
4. Điện áp quá cao
   → Chỉ dùng 7.4V, không > 9V

5. Thông gió kém
   → Dùng quạt tản nhiệt hoặc tản nhiệt nhôm
```

### 8.5. Kết quả đo không ổn định

```
TRIỆU CHỨNG: Giá trị đo nhảy lung tung

NGUYÊN NHÂN CÓ THỂ:
1. Tiếp xúc kém
   → Hàn hoặc kẹp chặt dây đo
   
2. Nhiễu từ động cơ
   → Dùng dây xoắn đôi, thêm tụ lọc
   
3. Tải không ổn định
   → Dùng tải giả điện tử hoặc phanh từ
   
4. Nhiệt độ thay đổi
   → Chờ động cơ ổn định nhiệt (2-3 phút)

5. Pin không ổn định
   → Dùng nguồn DC thay vì pin
```

### 8.6. Sai số quá lớn

```
TRIỆU CHỨNG: Kết quả đo khác lý thuyết > 20%

NGUYÊN NHÂN CÓ THỂ:
1. Thông số động cơ không đúng
   → Xác định lại loại động cơ (540 hay 550, số vòng dây)
   
2. Thiết bị đo không chính xác
   → Hiệu chuẩn đồng hồ vạn năng
   
3. Điều kiện đo không đúng
   → Đảm bảo: không tải khi đo n_0, đúng tải khi đo n_n
   
4. Công thức tính sai
   → Kiểm tra lại đơn vị: rad/s vs rpm, mNm vs Nm

5. Động cơ đã bị mòn
   → Thử với động cơ mới
```

---

## PHỤ LỤC

### A. Bảng tra thông số động cơ 540/550

```
┌──────────┬────────────┬──────────┬──────────┬───────────┐
│ Loại     │ Điện áp    │ Công suất│ Tốc độ   │ Số vòng   │
│ động cơ  │ định mức   │ (W)      │ (rpm)    │ dây (T)   │
├──────────┼────────────┼──────────┼──────────┼───────────┤
│ 540-21T  │ 7.4V       │ 40W      │ 10000    │ 21        │
│ 540-27T  │ 7.4V       │ 35W      │ 8500     │ 27        │
│ 540-35T  │ 7.4V       │ 30W      │ 8000     │ 35       │
│ 550-21T  │ 7.4V       │ 60W      │ 11000    │ 21        │
│ 550-27T  │ 7.4V       │ 50W      │ 9500     │ 27        │
│ 550-35T  │ 7.4V       │ 40W      │ 8500     │ 35        │
└──────────┴────────────┴──────────┴──────────┴───────────┘

 Thông dụng nhất trong Huina 1592

Lưu ý:
- Số vòng dây càng nhiều (T lớn) → mômen lớn, tốc độ thấp
- 540 nhỏ hơn 550 (36mm vs 38mm đường kính)
```

### B. Công thức tổng hợp

```
1. Điện trở phần ứng:
   R_a = V / I_locked (Ω)

2. Hằng số sức điện động:
   K_e = (V - I_0×R_a) / ω (V/rad/s)
   K_e' = K_e × (60/2π) ≈ K_e × 9.55 (V/1000rpm)

3. Hằng số mômen:
   K_m = K_e (Nm/A) [trong SI]
   K_m' = K_e' × 1000 / 9.55 ≈ K_e' × 104.7 (mNm/A)

4. Hằng số thời gian điện:
   τ_a = L_a / R_a (s)

5. Hằng số thời gian cơ:
   τ_m = (J × R_a) / (K_e × K_m) (s)

6. Phương trình đặc tính cơ:
   n = (V - I×R_a) / K_e' (rpm)
   n = n_0 - (R_a / K_e'^2) × M

7. Công suất:
   P_in = V × I (W)
   P_out = M × ω = M × (2π×n/60) / 1000 (W)
   η = P_out / P_in × 100 (%)

8. Tổn thất:
   P_Cu = I² × R_a (W) - tổn thất đồng
   P_mech ≈ V × I_0 (W) - tổn thất cơ + sắt
```

### C. Checklist trước thí nghiệm

```
 Đã đọc kỹ hướng dẫn an toàn
 Đã kiểm tra tất cả thiết bị hoạt động tốt
 Đã chuẩn bị sổ ghi chép/file Excel
 Pin đã sạc đầy (7.4V - 8.4V)
 Động cơ cố định chắc chắn
 Kết nối điện đúng cực tính (+/-)
 Không có vật cản gần trục động cơ
 Có bình cứu hỏa/cát gần đó
 Đã thông báo cho người xung quanh
 Đã đeo kính bảo hộ (nếu cần)
```

### D. Liên hệ và hỗ trợ

```
 Email hỗ trợ: [email của bạn]
 Website: https://github.com/trthanhdo41/auto-excavator-control-system
 Zalo/Telegram: [số điện thoại]

Các nhóm/diễn đàn hữu ích:
- RC Việt Nam: facebook.com/groups/rcvietnam
- Arduino Việt Nam: facebook.com/groups/arduinovn
- DIY Electronics: reddit.com/r/AskElectronics
```

---

## KẾT LUẬN

Hướng dẫn này cung cấp đầy đủ các thông tin cần thiết để thực hiện thí nghiệm với động cơ DC của Huina 1592. Thông qua các thí nghiệm, bạn sẽ:

 Hiểu rõ nguyên lý hoạt động của động cơ DC brushed
 Xác định được các thông số kỹ thuật thực tế
 Kiểm chứng được tính toán lý thuyết
 Nắm vững điều khiển PWM
 Có cơ sở để phát triển hệ thống tự động

**Chúc bạn thí nghiệm thành công! **

---

*Phiên bản: 1.0*  
*Ngày cập nhật: 22/10/2025*  
*Tác giả: Nhóm nghiên cứu Huina 1592*


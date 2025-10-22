# CHƯƠNG 3 - PHẦN 2: ĐIỀU KHIỂN PWM VÀ ESC

## GIỚI THIỆU

Phần này tập trung vào hệ thống điều khiển tốc độ động cơ DC trong Huina 1592 sử dụng PWM (Pulse Width Modulation) và ESC (Electronic Speed Controller). Đây là cách thức thực tế để điều khiển máy xúc RC, hoàn toàn khác với hệ thống khuếch đại từ trong máy công nghiệp.

## 3.2.1 - Nguyên lý điều khiển PWM

### Khái niệm

PWM (Pulse Width Modulation - Điều chế độ rộng xung) là kỹ thuật điều khiển tốc độ động cơ DC bằng cách thay đổi độ rộng xung của tín hiệu điện áp.

**GIẢI THÍCH CHI TIẾT:**

Thay vì thay đổi điện áp liên tục (0-7.4V), PWM bật/tắt điện áp với tần số cao và thay đổi tỷ lệ thời gian bật/tắt.

**Ưu điểm PWM:**
- ✅ Hiệu suất cao (>95%)
- ✅ Không có tổn thất điện trở (như điều chỉnh bằng biến trở)
- ✅ Dễ dàng điều khiển bằng vi điều khiển
- ✅ Giá thành thấp

### Các thông số PWM

**1. Tần số PWM (f):**

```
f = 1 / T_period

Với T_period = thời gian 1 chu kỳ
```

**Tần số thông dụng:**
- RC Hobby ESC: 50 Hz - 500 Hz (PWM thông thường)
- Brushed ESC: 1 kHz - 20 kHz
- Arduino PWM: 490 Hz - 980 Hz (mặc định)
- STM32 PWM: Có thể lên đến 100 kHz

**2. Duty Cycle (D):**

```
D = T_on / T_period × 100%

Với:
- T_on: Thời gian bật (HIGH)
- T_off: Thời gian tắt (LOW)
- T_period = T_on + T_off
```

**3. Điện áp trung bình:**

```
U_avg = D × U_supply

Ví dụ:
D = 75%, U_supply = 7.4V
→ U_avg = 0.75 × 7.4 = 5.55V
```

### VÍ DỤ TÍNH TOÁN PWM

**Ví dụ 1: Tần số 20 kHz**

```
f = 20000 Hz
T_period = 1 / 20000 = 0.00005 s = 50 μs

Duty cycle 60%:
T_on = 0.6 × 50 = 30 μs
T_off = 0.4 × 50 = 20 μs

Điện áp trung bình:
U_avg = 0.6 × 7.4 = 4.44V
```

**Ví dụ 2: Arduino PWM 490 Hz**

```
f = 490 Hz
T_period = 1 / 490 = 0.00204 s = 2.04 ms

Duty cycle 128/255 = 50.2%:
T_on = 0.502 × 2.04 = 1.024 ms
T_off = 0.498 × 2.04 = 1.016 ms

Điện áp trung bình:
U_avg = 0.502 × 7.4 = 3.71V
```

### Tín hiệu PWM

```
     ___     ___     ___
    |   |   |   |   |   |
    |   |   |   |   |   |
____|   |___|   |___|   |____

T_on  T_off
<---><--->
<---------> T_period

Duty = 40%
```

### Ảnh hưởng của tần số PWM

**1. Tần số thấp (< 1 kHz):**
- ⚠️ Động cơ có thể rung, ồn
- ⚠️ Dòng điện gợn sóng lớn
- ✅ Dễ quan sát bằng oscilloscope
- ✅ Ít nhiễu điện từ

**2. Tần số cao (> 10 kHz):**
- ✅ Động cơ chạy êm, không rung
- ✅ Dòng điện gợn sóng nhỏ
- ⚠️ Tổn thất đóng/mở MOSFET tăng
- ⚠️ Nhiễu điện từ cao

**Khuyến nghị:** f = 10 - 20 kHz cho động cơ Brushed

---

## 3.2.2 - ESC (Electronic Speed Controller)

### Khái niệm

ESC là mạch điện tử điều khiển tốc độ động cơ DC, bao gồm:
- Vi điều khiển (MCU)
- Cầu H MOSFET (H-Bridge)
- Mạch bảo vệ quá dòng/nhiệt
- Giao tiếp điều khiển (PWM servo, I2C, UART...)

### Cấu trúc ESC

```
                  ESC
    ┌─────────────────────────────┐
    │                             │
Pin │  ┌───────┐    ┌─────────┐  │  Motor
7.4V├─>│ BEC   │    │ H-Bridge│──┼──> M
    │  │5V/3A  │    │ MOSFET  │  │
    │  └───┬───┘    └────┬────┘  │
    │      │             │        │
    │      v             │        │
    │  ┌───────────┐     │        │
PWM │  │    MCU    │─────┘        │
 ├──┼─>│ ATmega8/  │              │
    │  │ STM32F0   │              │
    │  └───────────┘              │
    └─────────────────────────────┘
```

### Thông số ESC cho Huina 1592

| Thông số | Giá trị | Ghi chú |
|----------|---------|---------|
| Điện áp vào | 6-12V | Hỗ trợ 2S-3S Li-ion |
| Dòng liên tục | 10-20A | Mỗi động cơ ~5A |
| Dòng đỉnh | 30-40A | Trong 10s |
| Tần số PWM | 1-20 kHz | Có thể điều chỉnh |
| BEC đầu ra | 5V/2A | Cấp cho receiver |
| Bảo vệ | Quá dòng, quá nhiệt, điện áp thấp | Tự động ngắt |

### Các loại tín hiệu điều khiển ESC

**1. PWM Servo (RC Standard):**

```
Tần số: 50 Hz (chu kỳ 20ms)
Độ rộng xung: 1000 - 2000 μs

1000 μs → Dừng/Lùi max
1500 μs → Dừng
2000 μs → Tiến max

Ví dụ:
1200 μs → Lùi 40%
1750 μs → Tiến 50%
```

**2. Analog (Potentiometer):**

```
0-5V tương ứng với 0-100% tốc độ

Ví dụ:
0V → Dừng
2.5V → 50% tốc độ
5V → 100% tốc độ
```

**3. I2C/UART (Digital):**

```
Gửi lệnh qua giao thức I2C:
- Địa chỉ ESC: 0x40
- Byte điều khiển: 0-255

Ví dụ Arduino:
Wire.beginTransmission(0x40);
Wire.write(128);  // 50% tốc độ
Wire.endTransmission();
```

---

## 3.2.3 - Mạch cầu H (H-Bridge)

### Khái niệm

Cầu H là mạch điện tử cho phép điều khiển chiều quay và tốc độ động cơ DC bằng cách đảo chiều dòng điện.

### Sơ đồ cầu H

```
        Vcc (+7.4V)
         │
    ┌────┴────┐
    │    S1   S2
    │    │    │
    ├────┼────┤
    │    M    │     M = Motor
    ├────┼────┤
    │    S3   S4
    │    │    │
    └────┴────┘
         │
        GND

S1, S2, S3, S4 = MOSFET switches
```

### Các chế độ hoạt động

**1. Quay thuận (Forward):**

```
S1 = ON,  S2 = OFF
S3 = OFF, S4 = ON

Dòng điện: Vcc → S1 → Motor → S4 → GND
```

**2. Quay ngược (Reverse):**

```
S1 = OFF, S2 = ON
S3 = ON,  S4 = OFF

Dòng điện: Vcc → S2 → Motor → S3 → GND
```

**3. Dừng nhanh (Brake):**

```
S1 = OFF, S2 = OFF
S3 = ON,  S4 = ON

Hoặc:
S1 = ON,  S2 = ON
S3 = OFF, S4 = OFF

→ Ngắn mạch 2 đầu motor → Hãm điện
```

**4. Chạy tự do (Coast):**

```
S1 = OFF, S2 = OFF
S3 = OFF, S4 = OFF

→ Motor không còn điện, chạy tự do
```

### PWM với cầu H

**Phương pháp 1: Sign-Magnitude PWM**

```
Chiều quay: S1/S4 (hoặc S2/S3) luôn ON
Tốc độ: PWM trên S3/S4 (hoặc S1/S2)

Ví dụ quay thuận 60%:
S1 = ON (100%)
S4 = PWM 60%
S2 = OFF
S3 = OFF
```

**Phương pháp 2: Locked Anti-Phase PWM**

```
S1 và S3 PWM cùng pha
S2 và S4 PWM ngược pha

Duty 50% = Dừng
Duty 0-50% = Quay ngược
Duty 50-100% = Quay thuận
```

### IC cầu H phổ biến

| IC | Điện áp | Dòng | Số kênh | Giá |
|----|---------|------|---------|-----|
| L293D | 4.5-36V | 600mA | 2 | Rẻ |
| L298N | 5-35V | 2A | 2 | Rẻ |
| TB6612 | 2.5-13.5V | 1.2A | 2 | Tốt |
| DRV8833 | 2.7-10.8V | 1.5A | 2 | Nhỏ |
| VNH5019 | 5.5-24V | 12A | 1 | Mạnh |

**Huina 1592 thường dùng:** IC tương tự L298N hoặc MOSFET rời

---

## 3.2.4 - Tính toán mạch điều khiển PWM

### Điện áp và dòng điện trung bình

**1. Điện áp trung bình:**

```
U_avg = D × U_supply

Ví dụ:
D = 70%, U_supply = 7.4V
U_avg = 0.7 × 7.4 = 5.18V
```

**2. Dòng điện trung bình:**

```
I_avg = (U_avg - E_a) / R_a

Trong đó:
E_a = K_e × ω (phụ thuộc tốc độ)

Ví dụ:
U_avg = 5.18V
ω = 600 rad/s
K_e = 0.00557 V/(rad/s)
E_a = 0.00557 × 600 = 3.34V

I_avg = (5.18 - 3.34) / 0.8 = 2.3A
```

**3. Dòng gợn sóng:**

```
ΔI = (U_supply - E_a) × D × (1-D) / (L_a × f)

Ví dụ:
U_supply = 7.4V
E_a = 3.34V
D = 0.7
L_a = 0.0002 H
f = 20000 Hz

ΔI = (7.4 - 3.34) × 0.7 × 0.3 / (0.0002 × 20000)
ΔI = 0.853 / 4 = 0.21A

→ Dòng dao động ±0.105A quanh giá trị trung bình
```

### Chọn tần số PWM tối ưu

```
Điều kiện: T_PWM << T_a

f_PWM >> 1 / T_a = R_a / L_a

f_PWM >> 0.8 / 0.0002 = 4000 Hz

→ Chọn f_PWM = 20 kHz (gấp 5 lần)
```

### Tính công suất tổn thất

**1. Tổn thất dẫn MOSFET:**

```
P_cond = I_rms² × R_ds_on

Với:
R_ds_on = 0.02Ω (MOSFET tốt)
I_rms = I_avg × √(1 + (ΔI/I_avg)²/12)
I_rms ≈ 2.3A

P_cond = 2.3² × 0.02 = 0.106W × 4 transistor = 0.42W
```

**2. Tổn thất đóng/mở:**

```
P_sw = 0.5 × U_supply × I_avg × (t_rise + t_fall) × f

Với:
t_rise + t_fall ≈ 100 ns

P_sw = 0.5 × 7.4 × 2.3 × 100×10⁻⁹ × 20000
P_sw = 0.017W × 4 = 0.068W
```

**3. Tổn thất tổng:**

```
P_total = P_cond + P_sw = 0.42 + 0.068 = 0.49W

Hiệu suất:
η = P_motor / (P_motor + P_loss)
η = 15 / (15 + 0.49) = 96.8%
```

---

## 3.2.5 - Lập trình PWM Arduino

### Code Arduino cơ bản

```cpp
// Định nghĩa chân
const int PWM_PIN = 9;    // Chân PWM ~ (490 Hz)
const int DIR_PIN1 = 7;   // Chiều quay 1
const int DIR_PIN2 = 8;   // Chiều quay 2

void setup() {
  pinMode(PWM_PIN, OUTPUT);
  pinMode(DIR_PIN1, OUTPUT);
  pinMode(DIR_PIN2, OUTPUT);
  
  // Tần số PWM 31 kHz trên pin 9 và 10
  TCCR1B = TCCR1B & 0b11111000 | 0x01;
}

void setMotorSpeed(int speed) {
  // speed: -255 (lùi max) đến +255 (tiến max)
  
  if (speed > 0) {
    // Quay thuận
    digitalWrite(DIR_PIN1, HIGH);
    digitalWrite(DIR_PIN2, LOW);
    analogWrite(PWM_PIN, speed);
  } 
  else if (speed < 0) {
    // Quay ngược
    digitalWrite(DIR_PIN1, LOW);
    digitalWrite(DIR_PIN2, HIGH);
    analogWrite(PWM_PIN, -speed);
  }
  else {
    // Dừng
    digitalWrite(DIR_PIN1, LOW);
    digitalWrite(DIR_PIN2, LOW);
    analogWrite(PWM_PIN, 0);
  }
}

void loop() {
  // Tăng tốc từ 0 → 100%
  for(int speed = 0; speed <= 255; speed += 5) {
    setMotorSpeed(speed);
    delay(100);
  }
  
  delay(1000);
  
  // Giảm tốc về 0
  for(int speed = 255; speed >= 0; speed -= 5) {
    setMotorSpeed(speed);
    delay(100);
  }
  
  delay(1000);
}
```

### Code với ESC RC (PWM Servo)

```cpp
#include <Servo.h>

Servo esc;

void setup() {
  esc.attach(9);          // Chân tín hiệu ESC
  
  // Khởi tạo ESC (thường cần 1500μs = dừng)
  esc.writeMicroseconds(1500);
  delay(2000);
}

void loop() {
  // Tăng tốc từ dừng → max
  for(int pulse = 1500; pulse <= 2000; pulse += 10) {
    esc.writeMicroseconds(pulse);
    delay(50);
  }
  
  delay(1000);
  
  // Giảm về dừng
  for(int pulse = 2000; pulse >= 1500; pulse -= 10) {
    esc.writeMicroseconds(pulse);
    delay(50);
  }
  
  delay(1000);
}
```

### Điều khiển PWM nâng cao với Timer

```cpp
// PWM 20 kHz trên Arduino Uno (Timer 1)
void setupPWM20kHz() {
  // Chế độ Fast PWM, TOP = ICR1
  TCCR1A = _BV(COM1A1) | _BV(WGM11);
  TCCR1B = _BV(WGM13) | _BV(WGM12) | _BV(CS10);
  
  // Tần số 20 kHz: ICR1 = 16MHz / 20kHz = 800
  ICR1 = 800;
  OCR1A = 0;  // Duty cycle 0%
  
  pinMode(9, OUTPUT);  // Pin OC1A
}

void setPWMDuty(uint8_t percent) {
  // percent: 0-100
  OCR1A = (uint16_t)ICR1 * percent / 100;
}

void setup() {
  setupPWM20kHz();
}

void loop() {
  // Ramp up 0→100%
  for(uint8_t d = 0; d <= 100; d++) {
    setPWMDuty(d);
    delay(20);
  }
  delay(500);
  
  // Ramp down 100→0%
  for(uint8_t d = 100; d > 0; d--) {
    setPWMDuty(d);
    delay(20);
  }
  delay(500);
}
```

---

## 3.2.6 - Bảo vệ và an toàn

### Các chế độ bảo vệ cần có

**1. Bảo vệ quá dòng:**

```cpp
const float MAX_CURRENT = 5.0;  // 5A
const int CURRENT_PIN = A0;     // Cảm biến dòng ACS712

float readCurrent() {
  int raw = analogRead(CURRENT_PIN);
  // ACS712-5A: 185 mV/A, offset 2.5V
  float voltage = raw * 5.0 / 1023.0;
  float current = (voltage - 2.5) / 0.185;
  return abs(current);
}

void checkOvercurrent() {
  float current = readCurrent();
  if(current > MAX_CURRENT) {
    setMotorSpeed(0);  // Tắt motor
    digitalWrite(LED_ERROR, HIGH);
    Serial.println("OVERCURRENT!");
  }
}
```

**2. Bảo vệ điện áp thấp:**

```cpp
const float MIN_VOLTAGE = 6.0;  // 6V
const int VOLTAGE_PIN = A1;

float readVoltage() {
  int raw = analogRead(VOLTAGE_PIN);
  // Chia áp R1=10k, R2=2.2k
  float v_divider = raw * 5.0 / 1023.0;
  float v_battery = v_divider * (10 + 2.2) / 2.2;
  return v_battery;
}

void checkUndervoltage() {
  float voltage = readVoltage();
  if(voltage < MIN_VOLTAGE) {
    setMotorSpeed(0);
    digitalWrite(LED_WARNING, HIGH);
    Serial.println("LOW BATTERY!");
  }
}
```

**3. Bảo vệ quá nhiệt:**

```cpp
const float MAX_TEMP = 80.0;  // 80°C
const int TEMP_PIN = A2;      // NTC thermistor

float readTemperature() {
  int raw = analogRead(TEMP_PIN);
  // Tính theo công thức NTC
  float resistance = 10000.0 * (1023.0 / raw - 1.0);
  float temp = /* công thức Steinhart-Hart */;
  return temp;
}

void checkOvertemp() {
  float temp = readTemperature();
  if(temp > MAX_TEMP) {
    setMotorSpeed(0);
    digitalWrite(LED_ERROR, HIGH);
    Serial.println("OVERTEMP!");
  }
}
```

### Soft start (Khởi động mềm)

```cpp
void softStart(int targetSpeed, int rampTime) {
  int currentSpeed = 0;
  int steps = 50;
  int delayTime = rampTime / steps;
  int increment = targetSpeed / steps;
  
  for(int i = 0; i < steps; i++) {
    currentSpeed += increment;
    setMotorSpeed(currentSpeed);
    delay(delayTime);
  }
}

// Sử dụng:
// softStart(200, 1000);  // Tăng lên 200 trong 1 giây
```

---

## TÓM TẮT PHẦN 2

### So sánh hệ thống điều khiển

| Đặc điểm | Máy công nghiệp (EKG-5A) | Huina 1592 (RC) |
|----------|-------------------------|-----------------|
| Nguồn điện | 220V DC | 7.4V Li-ion |
| Điều khiển | Khuếch đại từ + Máy phát | PWM + ESC |
| Công suất | 75 kW | 30W |
| Tần số điều khiển | 50 Hz | 10-20 kHz |
| Phức tạp | Rất cao | Đơn giản |
| Giá thành | Hàng tỷ | < 500k VNĐ |
| Ứng dụng | Công nghiệp | Hobby, nghiên cứu |

### Ưu điểm PWM so với điều chỉnh analog

| Tiêu chí | PWM | Analog |
|----------|-----|--------|
| Hiệu suất | >95% | 50-70% |
| Tổn thất nhiệt | Rất thấp | Cao |
| Khả năng điều khiển | Chính xác | Khó điều chỉnh |
| Chi phí | Thấp | Cao |
| Nhiễu điện từ | Có | Không |

### Các thông số quan trọng

```
1. Tần số PWM:          f = 10-20 kHz
2. Duty cycle:          D = 0-100%
3. Điện áp trung bình:  U_avg = D × U_supply
4. Dòng trung bình:     I_avg = (U_avg - E_a) / R_a
5. Hiệu suất ESC:       η ≈ 95-98%
```

---

**HẾT PHẦN 2**

Tiếp theo: [Mô phỏng MATLAB](../matlab/)

# SƠ ĐỒ MẠCH ĐIỀU KHIỂN HUINA 1592

##  MỤC LỤC
1. [Tổng quan hệ thống](#1-tổng-quan-hệ-thống)
2. [Sơ đồ khối hệ thống](#2-sơ-đồ-khối-hệ-thống)
3. [Mạch nguồn](#3-mạch-nguồn)
4. [Mạch điều khiển Arduino](#4-mạch-điều-khiển-arduino)
5. [Mạch công suất (H-Bridge)](#5-mạch-công-suất-h-bridge)
6. [Mạch cảm biến](#6-mạch-cảm-biến)
7. [Sơ đồ PCB](#7-sơ-đồ-pcb)
8. [Danh sách linh kiện](#8-danh-sách-linh-kiện)

---

## 1. TỔNG QUAN HỆ THỐNG

### 1.1. Mô tả chung
Hệ thống điều khiển Huina 1592 bao gồm:
- **Vi điều khiển:** Arduino Nano (ATmega328P)
- **Nguồn:** Pin LiPo 2S (7.4V, 2200mAh)
- **Driver động cơ:** H-Bridge (BTS7960 hoặc L298N)
- **Động cơ:** 6x DC Brushed Motors 540/550 (di chuyển, cần, gầu, xoay)
- **Cảm biến:** Encoder, potentiometer, current sensor
- **Giao tiếp:** RC Receiver (PWM) hoặc Serial (PC/ROS)

### 1.2. Sơ đồ tổng thể (ASCII)

```
                   HỆ THỐNG ĐIỀU KHIỂN HUINA 1592
     ┌┐
     │                                                              │
     │   ┌┐         ┌┐                    │
     │   │  Pin 7.4V│┤  Mạch nguồn  ├┬┬┐  │
     │   │  2200mAh │         │   (LDO 5V)   │     │      │    │  │
     │   └┘         └┘     │      │    │  │
     │                                 │            │      │    │  │
     │                                 5V          7.4V   7.4V 7.4V│
     │                                 │            │      │    │  │
     │        ┌┴┐       │      │    │  │
     │        │   Arduino Nano (5V)         │       │      │    │  │
     │        │  - ATmega328P @ 16MHz       │       │      │    │  │
     │        │  - PWM outputs (D3-D11)     │       │      │    │  │
     │        │  - Analog inputs (A0-A7)    │       │      │    │  │
     │        └┬┘       │      │    │  │
     │                 │                             │      │    │  │
     │        PWM      │ I2C    Serial              │      │    │  │
     │      signals    │ (SDA,  (RX,TX)             │      │    │  │
     │                 │  SCL)                       │      │    │  │
     │   ┌┴┐             │      │    │  │
     │   │                             │             │      │    │  │
     │                                                         │
     │┌┐  ┌┐  ┌┐  ┌┐│
     ││H-Bridge│  │H-Bridge│  │H-Bridge│  │   Cảm biến (I2C)     ││
     ││ #1     │  │ #2     │  │ #3     │  │ - IMU (MPU6050)      ││
     ││(BTS7960│  │(L298N) │  │(L298N) │  │ - Encoder            ││
     ││  43A)  │  │  2A×2) │  │  2A×2) │  │ - Current (INA219)   ││
     │└┬┘  └┬┘  └┬┘  └┘│
     │    │           │           │                                 │
     │                                                           │
     │ ┌┐   ┌┐   ┌┐                              │
     │ │Motor1│   │Motor2│   │Motor3│   ...                        │
     │ │Di    │   │Cần   │   │Gầu   │                              │
     │ │chuyển│   │      │   │      │                              │
     │ │(5A)  │   │(2A)  │   │(2A)  │                              │
     │ └┘   └┘   └┘                              │
     │                                                              │
     └┘
```

---

## 2. SƠ ĐỒ KHỐI HỆ THỐNG

### 2.1. Khối chức năng

```
┌┐
│                        INPUT                                     │
├┤
│  ┌┐   ┌┐   ┌┐        │
│  │ RC Receiver  │   │   Serial     │   │   Button     │        │
│  │   (PWM CH1-6)│   │   (USB/BT)   │   │   (Manual)   │        │
│  └┬┘   └┬┘   └┬┘        │
│         │                   │                   │                │
│         └┴┘                │
│                             │                                    │
└┼┘
                              │
┌┼┐
│                    PROCESSING (Arduino)                          │
├┼┤
│         ┌┐                 │
│         │   Xử lý tín hiệu đầu vào            │                 │
│         │   - RC PWM decode                   │                 │
│         │   - Serial command parsing          │                 │
│         └┬┘                 │
│                         │                                        │
│         ┌┐                     │
│         │   Điều khiển logic              │                     │
│         │   - Trajectory planning         │                     │
│         │   - PID controller              │                     │
│         │   - Safety check                │                     │
│         └┬┘                     │
│                         │                                        │
│         ┌┐                     │
│         │   PWM Generation                │                     │
│         │   - 20kHz carrier               │                     │
│         │   - Duty cycle 0-100%           │                     │
│         └┬┘                     │
│                         │                                        │
│         ┌┐                     │
│         │   Feedback từ cảm biến          │                     │
│         │   - Position (encoder)          │                     │
│         │   - Current (INA219)            │                     │
│         │   - Angle (IMU)                 │                     │
│         └┘                     │
└┬┘
                              │
┌┼┐
│                          OUTPUT                                  │
├┼┤
│  ┌┐   ┌┐   ┌┐        │
│  │  H-Bridge 1  │   │  H-Bridge 2  │   │  H-Bridge 3  │        │
│  │  (Di chuyển) │   │  (Cần gầu)   │   │  (Xoay)      │        │
│  └┬┘   └┬┘   └┬┘        │
│         │                   │                   │                │
│  ┌┐   ┌┐   ┌┐        │
│  │   Motor 1    │   │   Motor 2    │   │   Motor 3    │        │
│  │  (Trái/Phải) │   │  (Cần/Gầu)   │   │  (Xoay)      │        │
│  └┘   └┘   └┘        │
└┘
```

### 2.2. Luồng dữ liệu

```
User Input → Arduino → PWM Signal → H-Bridge → Motor → Mechanical Output
    ↑                     ↑                                    ↓
    └ Feedback ┴ Sensors ┘
                       (Closed-loop control)
```

---

## 3. MẠCH NGUỒN

### 3.1. Sơ đồ mạch nguồn

```
      Pin LiPo 2S (7.4V - 8.4V, 2200mAh)
                 │
                 │ (+)
      ┌┴┐
      │                     │
      │   XT60 Connector    │
      │   (+)         (-)   │
      └┬┬┘
         │              │
         │              GND
         │
    ┌┴┐
    │  Fuse    │  10A (bảo vệ quá dòng)
    │  (10A)   │
    └┬┘
         │
    ┌┴┐
    │                             │
    │        ON/OFF Switch        │
    │                             │
    └┬┘
         │
         ├┬┬> 7.4V (to H-Bridge)
         │                     │                  │
         │                  ┌┐          ┌┐
         │                  │ C1   │          │ C4   │
         │                  │1000μF│          │1000μF│
         │                  │ 16V  │          │ 16V  │
         │                  └┬┘          └┬┘
         │                     │                  │
    ┌┐              GND                GND
    │  LM7805  │
    │   (5V)   │  Voltage Regulator
    │ IN  OUT  │
    │     GND  │
    └┬┬┘
       │   │
    ┌┐ GND
    │ C2 │
    │100nF
    └┬┘
      GND
       │
    ┌┐
    │ C3 │ 470μF
    │ 10V│ (lọc nhiễu)
    └┬┘
      GND
       │
       └> 5V (to Arduino, sensors)
```

### 3.2. Giải thích

**Chức năng các thành phần:**

1. **XT60 Connector:**
   - Chuẩn kết nối pin LiPo
   - Chịu được dòng > 30A

2. **Fuse 10A:**
   - Bảo vệ quá dòng
   - Nếu I > 10A → fuse đứt → bảo vệ mạch

3. **ON/OFF Switch:**
   - Công tắc nguồn chính
   - Loại: Toggle switch 10A

4. **LM7805 (5V Regulator):**
   - Chuyển 7.4V → 5V cho Arduino và cảm biến
   - I_max = 1.5A (đủ cho Arduino + sensors)
   - Cần tản nhiệt nếu I > 500mA

5. **Tụ lọc:**
   - C1, C4 (1000μF): lọc nhiễu tần số thấp, chống sụt áp khi động cơ khởi động
   - C2 (100nF): lọc nhiễu tần số cao
   - C3 (470μF): ổn định điện áp 5V

**Tính toán công suất:**

```
Pin: 7.4V × 2.2Ah = 16.28 Wh

Tiêu thụ:
- Arduino Nano: ~20mA × 5V = 0.1W
- Sensors: ~50mA × 5V = 0.25W
- Motors (6 cái, trung bình 50% power):
  6 × 30W × 0.5 = 90W

Tổng: ~90W → I = 90/7.4 ≈ 12A (peak)

Thời gian hoạt động:
t = 2.2Ah / (12A × 0.5) ≈ 22 phút (duty cycle 50%)
```

---

## 4. MẠCH ĐIỀU KHIỂN ARDUINO

### 4.1. Sơ đồ chân Arduino Nano

```
                      Arduino Nano v3
                  ┌┐
                  │                    │
           ┌┤ D13 (SCK)     VIN  ├ (không dùng)
           │  ┌┤ 3V3           GND  ├ GND chung
           │  │┌┤ AREF          RST  ├ (Pull-up)
           │  ││┌┤ A0/D14   D12 (MISO)├┐
 Current1┼┘││ │ A1/D15   D11 (MOSI)├┤
 Current2┼┘│ │ A2/D16        D10  ├┼> Motor PWM
 Pot1 ┼┘ │ A3/D17         D9  ├┼> Motor PWM
 Pot2 ┤      │ A4 (SDA)       D8  ├┼> Motor DIR
 Encoder A ┤      │ A5 (SCL)       D7  ├┼> Motor DIR
 Encoder B ┤      │ A6             D6  ├┼> Motor PWM
 Button ┤      │ A7             D5  ├┼> Motor DIR
           │      │ +5V            D4  ├┼> Motor DIR
           └┤ RST            D3  ├┼> Motor PWM (INT1)
                  │ GND            D2  ├┼> RC Input (INT0)
                  │ VIN         TX/D1  ├┼> Serial TX
                  │              RX/D0  ├┘> Serial RX
                  └┘

PIN ASSIGNMENT:

Digital PWM outputs (490Hz hoặc 980Hz):
  D3, D5, D6, D9, D10, D11 → PWM cho H-Bridge

Digital outputs (DIR):
  D4, D7, D8 → Direction cho H-Bridge

Digital inputs:
  D2 (INT0) → RC Receiver Channel 1 (interrupt)
  D3 (INT1) → RC Receiver Channel 2 (interrupt)

Analog inputs:
  A0 → Current Sensor 1 (INA219 hoặc ACS712)
  A1 → Current Sensor 2
  A2 → Potentiometer 1 (position feedback)
  A3 → Potentiometer 2
  A6 → Encoder A (counting)
  A7 → Button input

I2C:
  A4 (SDA) → I2C Data (MPU6050, INA219, ...)
  A5 (SCL) → I2C Clock

Serial:
  D0 (RX) → Serial receive (PC communication)
  D1 (TX) → Serial transmit
```

### 4.2. Code Arduino cơ bản

```cpp
// File: Huina1592_Control.ino
// Điều khiển cơ bản cho Huina 1592

// ========== PIN DEFINITIONS ==========
// Motor 1 (Di chuyển trái)
#define MOTOR1_PWM  9
#define MOTOR1_DIR  8

// Motor 2 (Di chuyển phải)
#define MOTOR2_PWM  10
#define MOTOR2_DIR  7

// Motor 3 (Cần gầu)
#define MOTOR3_PWM  11
#define MOTOR3_DIR  4

// Inputs
#define RC_CH1      2   // Interrupt pin
#define BUTTON      7   // Manual button
#define CURRENT_1   A0  // Current sensor
#define POT_1       A2  // Position sensor

// ========== CONSTANTS ==========
const int PWM_FREQ = 20000;  // 20kHz (Timer1)
const int PWM_MAX = 255;
const float CURRENT_LIMIT = 5.0;  // Ampere

// ========== VARIABLES ==========
volatile int rcPulse = 1500;  // RC pulse width (μs)
int motorSpeed = 0;           // -255 to +255
float current1 = 0;

// ========== SETUP ==========
void setup() {
  // Serial
  Serial.begin(115200);
  Serial.println("Huina 1592 Control System");
  
  // Pin modes
  pinMode(MOTOR1_PWM, OUTPUT);
  pinMode(MOTOR1_DIR, OUTPUT);
  pinMode(MOTOR2_PWM, OUTPUT);
  pinMode(MOTOR2_DIR, OUTPUT);
  pinMode(MOTOR3_PWM, OUTPUT);
  pinMode(MOTOR3_DIR, OUTPUT);
  
  pinMode(RC_CH1, INPUT);
  pinMode(BUTTON, INPUT_PULLUP);
  
  // PWM frequency (20kHz on Timer1: D9, D10)
  setPwmFrequency(9, 1);   // 31.25kHz (closest to 20kHz)
  setPwmFrequency(10, 1);
  
  // Interrupt for RC input
  attachInterrupt(digitalPinToInterrupt(RC_CH1), rcInterrupt, CHANGE);
  
  // Initialize motors (stop)
  stopAllMotors();
}

// ========== MAIN LOOP ==========
void loop() {
  // 1. Read inputs
  readCurrentSensor();
  
  // 2. Convert RC pulse to motor speed
  motorSpeed = map(rcPulse, 1000, 2000, -255, 255);
  motorSpeed = constrain(motorSpeed, -255, 255);
  
  // 3. Safety check
  if (current1 > CURRENT_LIMIT) {
    stopAllMotors();
    Serial.println("OVERCURRENT! Stopped.");
    delay(1000);
    return;
  }
  
  // 4. Drive motors
  driveMotor(1, motorSpeed);
  driveMotor(2, motorSpeed);
  
  // 5. Debug output
  if (millis() % 100 == 0) {  // Every 100ms
    Serial.print("RC: ");
    Serial.print(rcPulse);
    Serial.print(" μs, Speed: ");
    Serial.print(motorSpeed);
    Serial.print(", Current: ");
    Serial.print(current1, 2);
    Serial.println(" A");
  }
  
  delay(10);  // 100Hz control loop
}

// ========== FUNCTIONS ==========

// RC interrupt handler
void rcInterrupt() {
  static unsigned long rising = 0;
  
  if (digitalRead(RC_CH1) == HIGH) {
    rising = micros();
  } else {
    rcPulse = micros() - rising;
  }
}

// Drive motor (1, 2, or 3)
void driveMotor(int motorNum, int speed) {
  int pwmPin, dirPin;
  
  // Select pins
  if (motorNum == 1) {
    pwmPin = MOTOR1_PWM;
    dirPin = MOTOR1_DIR;
  } else if (motorNum == 2) {
    pwmPin = MOTOR2_PWM;
    dirPin = MOTOR2_DIR;
  } else {
    pwmPin = MOTOR3_PWM;
    dirPin = MOTOR3_DIR;
  }
  
  // Direction
  if (speed >= 0) {
    digitalWrite(dirPin, HIGH);
  } else {
    digitalWrite(dirPin, LOW);
    speed = -speed;
  }
  
  // PWM
  analogWrite(pwmPin, speed);
}

// Stop all motors
void stopAllMotors() {
  analogWrite(MOTOR1_PWM, 0);
  analogWrite(MOTOR2_PWM, 0);
  analogWrite(MOTOR3_PWM, 0);
}

// Read current sensor (ACS712 30A)
void readCurrentSensor() {
  int raw = analogRead(CURRENT_1);
  float voltage = raw * (5.0 / 1023.0);
  
  // ACS712-30A: 66mV/A, Vcc/2 = 2.5V at 0A
  current1 = (voltage - 2.5) / 0.066;
}

// Set PWM frequency
void setPwmFrequency(int pin, int divisor) {
  byte mode;
  if(pin == 9 || pin == 10) {  // Timer1
    switch(divisor) {
      case 1: mode = 0x01; break;  // 31.25kHz
      case 8: mode = 0x02; break;  // 3.9kHz
      case 64: mode = 0x03; break; // 488Hz
      case 256: mode = 0x04; break;// 122Hz
      case 1024: mode = 0x05; break;//30Hz
      default: return;
    }
    TCCR1B = (TCCR1B & 0b11111000) | mode;
  }
}
```

---

## 5. MẠCH CÔNG SUẤT (H-BRIDGE)

### 5.1. Sơ đồ H-Bridge BTS7960 (43A)

**BTS7960 Module:** (dùng cho động cơ di chuyển - dòng lớn)

```
                       BTS7960 Module
      ┌┐
      │                                      │
  ┤ VCC (5V logic)                       │
  ┤ GND                                  │
      │                                      │
  ┤ RPWM (Right PWM)  ┌┐        │
  ┤ LPWM (Left PWM)   │BTS7960 │        │
  ┤ R_EN (Right EN)   │H-Bridge│  OUT+ ┼┬> Motor (+)
  ┤ L_EN (Left EN)    │  IC    │        │  │
      │                   │(43A max│  OUT- ┼┤
  ┤ R_IS (Right I sense)       │        │  └> Motor (-)
  ┤ L_IS (Left I sense)└┘        │
      │                                      │
  ┤ B+ (7.4V motor power)               │
  ┤ B-                                  │
      │                                      │
      └┘

KẾT NỐI VỚI ARDUINO:
  RPWM → Arduino D9 (PWM)
  LPWM → Arduino D10 (PWM)
  R_EN → 5V (hoặc Arduino D8)
  L_EN → 5V (hoặc Arduino D8)
  R_IS → Arduino A0 (current feedback)
  L_IS → Arduino A1 (current feedback)
  VCC → 5V
  GND → GND
  B+ → Pin 7.4V (+)
  B- → GND

CÁCH ĐIỀU KHIỂN:
  - Tiến (Forward): RPWM = 255, LPWM = 0
  - Lùi (Reverse): RPWM = 0, LPWM = 255
  - Dừng (Brake): RPWM = 0, LPWM = 0
  - Phanh (Brake): RPWM = 255, LPWM = 255
```

**Code điều khiển BTS7960:**
```cpp
// BTS7960 Driver
#define RPWM 9
#define LPWM 10
#define REN 8
#define LEN 7

void setup() {
  pinMode(RPWM, OUTPUT);
  pinMode(LPWM, OUTPUT);
  pinMode(REN, OUTPUT);
  pinMode(LEN, OUTPUT);
  
  digitalWrite(REN, HIGH);  // Enable
  digitalWrite(LEN, HIGH);
}

void driveMotorBTS7960(int speed) {
  // speed: -255 to +255
  
  if (speed > 0) {
    // Forward
    analogWrite(RPWM, speed);
    analogWrite(LPWM, 0);
  } else if (speed < 0) {
    // Reverse
    analogWrite(RPWM, 0);
    analogWrite(LPWM, -speed);
  } else {
    // Stop
    analogWrite(RPWM, 0);
    analogWrite(LPWM, 0);
  }
}
```

### 5.2. Sơ đồ H-Bridge L298N (2A×2)

**L298N Module:** (dùng cho động cơ cần, gầu, xoay - dòng nhỏ)

```
                       L298N Module
      ┌┐
      │                                      │
  ┤ +12V (7.4V motor power)             │
  ┤ GND                                  │
  ┤ +5V out (logic power, nếu VIN > 12V)│
      │                                      │
  ┤ ENA (Enable A) ┌┐           │
  ┤ IN1 (Input 1)  │ L298N  │   OUT1 ┼> Motor A (+)
  ┤ IN2 (Input 2)  │H-Bridge│   OUT2 ┼> Motor A (-)
  ┤ IN3 (Input 3)  │  Dual  │   OUT3 ┼> Motor B (+)
  ┤ IN4 (Input 4)  │ 2A×2   │   OUT4 ┼> Motor B (-)
  ┤ ENB (Enable B) └┘           │
      │                                      │
      └┘

KẾT NỐI VỚI ARDUINO (Motor A):
  ENA → Arduino D9 (PWM for speed)
  IN1 → Arduino D8 (Direction bit 1)
  IN2 → Arduino D7 (Direction bit 2)
  +12V → Pin 7.4V (+)
  GND → GND

BẢNG SỰ THẬT (Motor A):
  ENA | IN1 | IN2 | Hoạt động
  ----|-----|-----|----------
   0  |  X  |  X  | Stop (coast)
   1  |  0  |  0  | Stop (brake)
   1  |  0  |  1  | Forward (CCW)
   1  |  1  |  0  | Reverse (CW)
   1  |  1  |  1  | Stop (brake)
```

**Code điều khiển L298N:**
```cpp
// L298N Driver (Motor A)
#define ENA 9   // PWM
#define IN1 8
#define IN2 7

void setup() {
  pinMode(ENA, OUTPUT);
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
}

void driveMotorL298N(int speed) {
  // speed: -255 to +255
  
  if (speed > 0) {
    // Forward
    digitalWrite(IN1, LOW);
    digitalWrite(IN2, HIGH);
    analogWrite(ENA, speed);
  } else if (speed < 0) {
    // Reverse
    digitalWrite(IN1, HIGH);
    digitalWrite(IN2, LOW);
    analogWrite(ENA, -speed);
  } else {
    // Stop (brake)
    digitalWrite(IN1, LOW);
    digitalWrite(IN2, LOW);
    analogWrite(ENA, 0);
  }
}
```

### 5.3. So sánh BTS7960 vs L298N

```
┌┬┬┬┐
│ Thông số   │   BTS7960    │    L298N     │  Ghi chú    │
├┼┼┼┤
│ Dòng max   │ 43A (peak)   │ 2A/channel   │ BTS >> L298 │
│ Điện áp    │ 5.5-27V      │ 5-35V        │ Tương đương │
│ Hiệu suất  │ ~97%         │ ~75%         │ BTS tốt hơn │
│ Tổn thất áp│ ~0.2V        │ ~2V          │ BTS tốt hơn │
│ Tần số PWM │ Tới 25kHz    │ Tới 10kHz    │             │
│ Kích thước │ Lớn hơn      │ Nhỏ gọn      │             │
│ Giá        │ ~150k VND    │ ~40k VND     │             │
│ Dùng cho   │ Di chuyển    │ Cần, gầu     │             │
└┴┴┴┘

KHUYẾN NGHỊ:
 BTS7960: cho động cơ di chuyển (dòng lớn, 3-5A)
 L298N: cho động cơ cần, gầu, xoay (dòng nhỏ, 1-2A)
```

---

## 6. MẠCH CẢM BIẾN

### 6.1. Cảm biến dòng điện (INA219)

```
                    INA219 Module
      ┌┐
      │                            │
  ┤ VCC (+3-5V)                │
  ┤ GND                        │
  ┤ SDA > Arduino A4     │
  ┤ SCL > Arduino A5     │
      │                            │
  ┤ VIN+ (từ nguồn)            │
  ┤ VIN- > Load (motor/ESC)  │
      │                            │
      └┘

ĐẶC ĐIỂM:
- Đo dòng: 0-3.2A (±0.8mA resolution)
- Đo áp: 0-26V (±4mV resolution)
- Giao tiếp: I2C (địa chỉ 0x40)
- Chính xác cao hơn ACS712

ARDUINO CODE:
#include <Wire.h>
#include <Adafruit_INA219.h>

Adafruit_INA219 ina219;

void setup() {
  Serial.begin(115200);
  ina219.begin();
}

void loop() {
  float shuntvoltage = ina219.getShuntVoltage_mV();
  float busvoltage = ina219.getBusVoltage_V();
  float current_mA = ina219.getCurrent_mA();
  float power_mW = ina219.getPower_mW();
  
  Serial.print("V: "); Serial.print(busvoltage);
  Serial.print("V, I: "); Serial.print(current_mA/1000, 2);
  Serial.print("A, P: "); Serial.print(power_mW/1000, 2);
  Serial.println("W");
  
  delay(100);
}
```

### 6.2. Cảm biến góc (MPU6050 - IMU)

```
                    MPU6050 Module
      ┌┐
      │                            │
  ┤ VCC (+3-5V)                │
  ┤ GND                        │
  ┤ SDA > Arduino A4     │
  ┤ SCL > Arduino A5     │
  ┤ INT > Arduino D2 (opt)│
  ┤ AD0 > GND (addr 0x68)│
      │                            │
      └┘

ĐẶC ĐIỂM:
- 3-axis accelerometer ±2/4/8/16g
- 3-axis gyroscope ±250/500/1000/2000°/s
- Đo góc nghiêng của xe (pitch, roll)
- Giao tiếp: I2C (0x68 hoặc 0x69)

ARDUINO CODE:
#include <Wire.h>
#include <MPU6050.h>

MPU6050 mpu;

void setup() {
  Serial.begin(115200);
  Wire.begin();
  mpu.initialize();
  
  if (!mpu.testConnection()) {
    Serial.println("MPU6050 not found!");
    while(1);
  }
}

void loop() {
  int16_t ax, ay, az, gx, gy, gz;
  mpu.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);
  
  // Tính góc nghiêng (pitch, roll)
  float pitch = atan2(ax, sqrt(ay*ay + az*az)) * 180/PI;
  float roll = atan2(ay, az) * 180/PI;
  
  Serial.print("Pitch: "); Serial.print(pitch);
  Serial.print("°, Roll: "); Serial.print(roll);
  Serial.println("°");
  
  delay(100);
}
```

### 6.3. Encoder (đo vị trí/tốc độ)

```
            Encoder (Quang học hoặc Hall)
      ┌┐
      │                            │
  ┤ VCC (+5V)                  │
  ┤ GND                        │
  ┤ OUT A > Arduino D2 (INT0)
  ┤ OUT B > Arduino D3 (INT1)
      │                            │
      └┘

NGUYÊN LÝ:
- 2 kênh A, B lệch pha 90°
- Đếm xung để tính vị trí
- Xác định chiều quay từ trình tự A-B

ARDUINO CODE:
volatile long encoderCount = 0;
int lastA = 0, lastB = 0;

void setup() {
  pinMode(2, INPUT_PULLUP);  // A
  pinMode(3, INPUT_PULLUP);  // B
  
  attachInterrupt(0, encoderISR, CHANGE);  // D2
  attachInterrupt(1, encoderISR, CHANGE);  // D3
  
  Serial.begin(115200);
}

void loop() {
  Serial.print("Position: ");
  Serial.println(encoderCount);
  delay(100);
}

void encoderISR() {
  int A = digitalRead(2);
  int B = digitalRead(3);
  
  if (A != lastA) {
    if (A == B) encoderCount++;
    else encoderCount--;
  }
  
  lastA = A;
  lastB = B;
}
```

---

## 7. SƠ ĐỒ PCB

### 7.1. Layout đơn giản (Breadboard/Perfboard)

```
     PCB LAYOUT (Top view)
┌┐
│                                         │
│  ┌┐      ┌┐  │
│  │  Terminals │      │   Arduino    │  │
│  │  (Screw)   │      │    Nano      │  │
│  │            │      │              │  │
│  │ +7.4V  GND │      └┬┘  │
│  └┬┘              │         │
│        │                     │         │
│   ┌┐    │
│   │   LM7805 (with heatsink)      │    │
│   │   IN   OUT   GND              │    │
│   └┬┬┬┘    │
│        │     │       │                 │
│      +7.4V  +5V     GND                │
│        │     │       │                 │
│   ┌┴┴┴┐            │
│   │  Capacitors (C1-C4)   │            │
│   └┘            │
│                                         │
│  ┌┐  ┌┐    │
│  │  BTS7960 #1  │  │   L298N #1   │    │
│  │  (Motor 1)   │  │  (Motor 2,3) │    │
│  └┘  └┘    │
│                                         │
│  ┌┐    │
│  │  Connectors (to motors)        │    │
│  │  M1  M2  M3  M4  M5  M6        │    │
│  └┘    │
│                                         │
└┘

KÝ HIỆU:
 = Mounting hole
 = Power trace (thick)
 = Signal trace (thin)
```

### 7.2. Lưu ý thiết kế PCB

```
 POWER TRACES:
  - Dùng trace rộng (≥2mm) cho dòng > 3A
  - Hoặc dùng dây đồng 1.5mm² hàn trực tiếp

 GROUND PLANE:
  - Dùng copper pour cho GND (cả 2 mặt)
  - Giảm nhiễu và tản nhiệt tốt hơn

 SIGNAL ROUTING:
  - PWM signals: xa các dây nguồn lớn
  - I2C: dây ngắn, không song song với PWM
  - Encoder: dây xoắn đôi, có GND shield

 DECOUPLING:
  - Tụ 100nF gần mỗi IC (VCC-GND)
  - Tụ lớn (1000μF) gần connector nguồn

 THERMAL:
  - LM7805: pad lớn cho heatsink
  - BTS7960: khe tản nhiệt hoặc quạt
  - L298N: heatsink nhôm

 MECHANICAL:
  - 4 lỗ mounting M3
  - Khoảng cách chuẩn Arduino (50.8mm)
  - Connector chắc chắn (screw terminal hoặc XT60)
```

---

## 8. DANH SÁCH LINH KIỆN

### 8.1. Linh kiện chính

```
┌┬┬┬┬┐
│ STT │ Tên linh kiện        │ Số l.│ Đơn giá │ Thành tiền│
├┼┼┼┼┤
│  1  │ Arduino Nano (clone) │  1   │  70k    │   70k     │
│  2  │ BTS7960 43A module   │  1   │ 150k    │  150k     │
│  3  │ L298N module         │  2   │  40k    │   80k     │
│  4  │ LM7805 (TO-220)      │  1   │   5k    │    5k     │
│  5  │ Heatsink for 7805    │  1   │  10k    │   10k     │
│  6  │ Tụ 1000μF/16V        │  2   │   5k    │   10k     │
│  7  │ Tụ 470μF/10V         │  1   │   3k    │    3k     │
│  8  │ Tụ 100nF ceramic     │  5   │   1k    │    5k     │
│  9  │ Fuse 10A (blade)     │  1   │  10k    │   10k     │
│ 10  │ Fuse holder          │  1   │   5k    │    5k     │
│ 11  │ Toggle switch 10A    │  1   │  15k    │   15k     │
│ 12  │ XT60 connector (F+M) │  1   │  20k    │   20k     │
│ 13  │ Screw terminals 2pin │  8   │   3k    │   24k     │
│ 14  │ INA219 current sensor│  2   │  30k    │   60k     │
│ 15  │ MPU6050 IMU module   │  1   │  40k    │   40k     │
│ 16  │ Encoder module (opt) │  2   │  25k    │   50k     │
│ 17  │ Perfboard 10×15cm    │  1   │  30k    │   30k     │
│ 18  │ Dây đồng 1.5mm²      │  5m  │  10k/m  │   50k     │
│ 19  │ Header pins          │ 1 set│  10k    │   10k     │
│ 20  │ Standoff M3×10mm     │  8   │   2k    │   16k     │
├┴┴┴┼┤
│                                      TỔNG:  │  663k VND │
└┴┘

GHI CHÚ:
- Giá tham khảo tại Việt Nam (2025)
- Chưa bao gồm pin LiPo và sạc
- Encoder là tùy chọn (cho control chính xác hơn)
```

### 8.2. Công cụ cần thiết

```
 Mỏ hàn 60W + thiếc hàn
 Kìm cắt, kìm bấm, tuốc nơ vít
 Đồng hồ vạn năng
 Dao rọc mạch (nếu tự làm PCB)
 Keo nến (hot glue) để cố định
 Băng keo điện
```

### 8.3. Nơi mua

```
VIỆT NAM:
 Nshop Electronics: nshopvn.com
 Hshop: hshop.vn
 Linh kiện điện tử Sài Gòn: dientusg.vn
 icdayroi: icdayroi.com

QUỐC TẾ (ship lâu nhưng rẻ):
 AliExpress: aliexpress.com
 Banggood: banggood.com
```

---

## KẾT LUẬN

Tài liệu này cung cấp **sơ đồ mạch chi tiết** để xây dựng hệ thống điều khiển cho Huina 1592:

 **Mạch nguồn** ổn định với bảo vệ quá dòng  
 **Arduino Nano** làm bộ não điều khiển  
 **H-Bridge** (BTS7960 + L298N) phù hợp với từng động cơ  
 **Cảm biến** (dòng, góc, encoder) cho feedback chính xác  
 **Code mẫu** Arduino sẵn sàng sử dụng  
 **Danh sách linh kiện** đầy đủ với giá tham khảo  

**Bước tiếp theo:** Hàn mạch, test từng module, rồi tích hợp vào Huina 1592! 

---

*Phiên bản: 1.0*  
*Ngày cập nhật: 22/10/2025*  
*Tác giả: Nhóm nghiên cứu Huina 1592*  
*Repository: https://github.com/trthanhdo41/auto-excavator-control-system*


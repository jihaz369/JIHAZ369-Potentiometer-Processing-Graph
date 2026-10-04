# JIHАZ369 Potentiometer Serial Graph

A simple real-time Arduino UNO + Processing visualization project that reads a potentiometer through analog input **A0** and displays the value as a live scrolling graph on a computer.

The project is designed as a lightweight starting point for Arduino telemetry, sensor monitoring, and futuristic data visualization projects.

## 🚀 Features

* Arduino UNO analog potentiometer input
* Reads values from **0–1023**
* Serial communication at **115200 baud**
* Real-time Processing graph
* Live numerical value display
* Percentage level display
* Scrolling waveform
* Grid with 0–1023 scale
* Serial connection status
* Easy to extend for other sensors and telemetry systems

## 🧰 Hardware

### Required

* Arduino UNO
* 10K potentiometer
* USB cable
* Computer
* 3 jumper wires

### Potentiometer Wiring

```text
        10K POTENTIOMETER
       
       ┌───────────────┐
       │               │
5V ────┤ LEFT          │
       │               │
A0 ────┤ CENTER        │
       │               │
GND ───┤ RIGHT         │
       │               │
       └───────────────┘
```

### Arduino Connection

| Potentiometer  | Arduino UNO |
| -------------- | ----------- |
| VCC            | 5V          |
| Wiper / Center | A0          |
| GND            | GND         |

## 💻 Software

### Arduino

The Arduino sketch reads the potentiometer using:

```cpp
analogRead(A0);
```

The resulting value is transmitted through USB Serial.

Range:

```text
0 → 1023
```

### Processing

Processing 4.x receives the serial data and converts it into a live graph.

The graph displays:

```text
0       Minimum
512     Center
1023    Maximum
```

## 📡 Serial Protocol

The Arduino sends one integer value per line.

Example:

```text
0
35
127
256
512
734
901
1023
```

Communication settings:

```text
Baud Rate: 115200
Data:      Integer
Range:     0–1023
Format:    One value per line
```

## 📁 Project Structure

```text
JIHAZ369-Potentiometer-Graph/
│
├── Arduino/
│   └── JIHAZ369_Potentiometer_Serial_Graph.ino
│
├── Processing/
│   └── JIHAZ369_Potentiometer_Graph.pde
│
└── README.md
```

## 🔧 Arduino Setup

1. Connect the potentiometer to the Arduino UNO.
2. Connect the Arduino UNO to your computer.
3. Open the Arduino IDE.
4. Select:

```text
Board: Arduino UNO
```

5. Select the correct COM port.
6. Upload the Arduino sketch.

The Arduino will continuously send the A0 value at approximately 50 samples per second.

## 📊 Processing Setup

Open the Processing sketch.

First check the available serial ports:

```java
println(Serial.list());
```

Processing may display:

```text
[0] "COM3"
[1] "COM9"
[2] "COM12"
```

Find the COM port belonging to your Arduino UNO.

Then change:

```java
port = new Serial(this, "COM9", 115200);
```

For example, if your Arduino is on COM3:

```java
port = new Serial(this, "COM3", 115200);
```

### ⚠️ Important

Close the **Arduino Serial Monitor** before starting Processing.

The Arduino serial port should normally be used by Processing while the visualization is running.

## 🖥️ Visualization

The Processing interface provides:

```text
JIHAZ369 POTENTIOMETER MONITOR

VALUE: 512        LEVEL: 50.0%

1023 ─────────────────────────────
      │                 ╱╲
      │               ╱    ╲
      │       ╱╲    ╱        ╲
      │      ╱  ╲__╱
      │
 512  ─────────────────────────────
      │
      │
      │
   0  ─────────────────────────────

SERIAL: ONLINE    BAUD: 115200    INPUT: A0
```

Turning the potentiometer changes the graph in real time.

## 🧪 Testing

Turn the potentiometer slowly from minimum to maximum.

Expected values:

```text
Fully Counter-Clockwise
        ↓
       ~0

        ↓
     ~512
        ↓

Fully Clockwise
        ↓
      ~1023
```

The exact minimum and maximum may vary slightly depending on the potentiometer and Arduino ADC.

## 🔄 Data Flow

```text
       POTENTIOMETER
             │
             ▼
        Arduino A0
             │
             ▼
       analogRead()
             │
             ▼
        0 – 1023
             │
             ▼
       USB Serial
       115200 baud
             │
             ▼
        Processing
             │
             ▼
      Live Data Graph
```

## 🧠 How It Works

### Arduino

The Arduino continuously samples A0:

```cpp
int value = analogRead(A0);
```

Then sends the value to the computer:

```cpp
Serial.println(value);
```

A short delay controls the sampling rate:

```cpp
delay(20);
```

This produces approximately:

```text
1000 / 20 = 50 samples/second
```

### Processing

Processing waits for a complete line of serial data:

```java
void serialEvent(Serial p)
```

The received value is converted into a number:

```java
float value = float(data);
```

The graph array is then shifted and the newest value is added to the right side of the graph.

## 🛠️ Customization

You can easily replace the potentiometer with other analog sensors.

Examples:

* LDR
* Temperature sensor
* Joystick
* Analog pressure sensor
* Voltage sensor
* Battery monitor
* Audio level sensor
* Custom analog telemetry

For example:

```cpp
int value = analogRead(A1);
```

Then connect the sensor to A1.

## 📈 Future Development

Possible upgrades for the project:

* Multiple analog channels
* Real-time sensor dashboards
* Voltage measurement
* Battery monitoring
* RPM monitoring
* Joystick visualization
* GPS telemetry
* MPU6050 data
* BMP280 altitude
* nRF24 telemetry
* Wi-Fi telemetry
* CSV data logging
* Data recording and playback
* Futuristic JIHАZ369 HUD interface

## ⚡ JIHАZ369 Project

This project is part of the **JIHАZ369 electronics and AI development ecosystem**, focused on Arduino, robotics, telemetry, wireless communication, embedded systems, and real-time visualization.

## 📜 License

This project is provided for educational, experimental, and development purposes.

Use and modify the code according to your own project requirements.

---

# JIHАZ369

**Arduino • Electronics • Robotics • AI • Telemetry • Embedded Systems**

Built for experimentation, learning, and future autonomous systems.

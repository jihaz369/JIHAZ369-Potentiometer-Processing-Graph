/*
  ============================================================
  JIHAZ369 POTENTIOMETER GRAPH
  Processing 4.x
  ============================================================

  Arduino:
    A0 potentiometer
    115200 baud

  Graph:
    0    = bottom
    1023 = top
*/

import processing.serial.*;

Serial port;

float currentValue = 0;
float[] graph = new float[800];

void setup() {
  size(1000, 600);

  // CHANGE THIS TO YOUR ARDUINO COM PORT
  println(Serial.list());

  port = new Serial(this, "COM3", 115200);

  // Ignore old serial data until a newline arrives
  port.bufferUntil('\n');

  // Start graph at zero
  for (int i = 0; i < graph.length; i++) {
    graph[i] = 0;
  }

  textFont(createFont("Arial", 16));
}

void draw() {
  background(5, 10, 20);

  // ----------------------------------------------------------
  // TITLE
  // ----------------------------------------------------------

  fill(0, 220, 255);
  textSize(24);
  text("JIHAZ369 POTENTIOMETER MONITOR", 25, 35);

  // ----------------------------------------------------------
  // CURRENT VALUE
  // ----------------------------------------------------------

  fill(255);
  textSize(20);
  text("VALUE: " + int(currentValue), 25, 75);

  float percent = map(currentValue, 0, 1023, 0, 100);

  text("LEVEL: " + nf(percent, 0, 1) + "%", 200, 75);

  // ----------------------------------------------------------
  // GRAPH AREA
  // ----------------------------------------------------------

  int gx = 25;
  int gy = 110;
  int gw = width - 50;
  int gh = height - 150;

  // Graph background
  fill(8, 18, 30);
  stroke(30, 70, 90);
  rect(gx, gy, gw, gh);

  // ----------------------------------------------------------
  // GRID
  // ----------------------------------------------------------

  stroke(20, 55, 70);

  for (int i = 0; i <= 10; i++) {
    float y = map(i, 0, 10, gy + gh, gy);

    line(gx, y, gx + gw, y);

    fill(120, 160, 175);
    textSize(12);

    int value = int(map(i, 0, 10, 0, 1023));

    text(str(value), gx + 5, y - 4);
  }

  for (int i = 0; i <= 10; i++) {
    float x = map(i, 0, 10, gx, gx + gw);
    line(x, gy, x, gy + gh);
  }

  // ----------------------------------------------------------
  // GRAPH LINE
  // ----------------------------------------------------------

  noFill();
  stroke(0, 220, 255);
  strokeWeight(2);

  beginShape();

  for (int i = 0; i < graph.length; i++) {

    float x = map(i, 0, graph.length - 1, gx, gx + gw);

    float y = map(
      graph[i],
      0,
      1023,
      gy + gh,
      gy
    );

    vertex(x, y);
  }

  endShape();

  strokeWeight(1);

  // ----------------------------------------------------------
  // CURRENT VALUE MARKER
  // ----------------------------------------------------------

  float markerY = map(
    currentValue,
    0,
    1023,
    gy + gh,
    gy
  );

  stroke(255);
  line(gx, markerY, gx + gw, markerY);

  fill(255);
  textSize(14);
  text(
    "A0 = " + int(currentValue),
    gx + gw - 100,
    markerY - 8
  );

  // ----------------------------------------------------------
  // STATUS
  // ----------------------------------------------------------

  fill(0, 220, 255);
  textSize(14);
  text(
    "SERIAL: ONLINE    BAUD: 115200    INPUT: A0",
    25,
    height - 15
  );
}

// ============================================================
// SERIAL DATA
// ============================================================

void serialEvent(Serial p) {

  String data = p.readStringUntil('\n');

  if (data != null) {

    data = trim(data);

    try {

      float value = float(data);

      if (value >= 0 && value <= 1023) {

        currentValue = value;

        // Shift graph left
        for (int i = 0; i < graph.length - 1; i++) {
          graph[i] = graph[i + 1];
        }

        // Add newest value
        graph[graph.length - 1] = currentValue;
      }

    } 
    catch (Exception e) {
      println("Invalid data: " + data);
    }
  }
}

/*
  ============================================================
  JIHAZ369 POTENTIOMETER SERIAL GRAPH
  ============================================================

  BOARD:
    Arduino UNO

  POTENTIOMETER:
    VCC  -> 5V
    GND  -> GND
    WIPER -> A0

  SERIAL:
    115200 baud

  OUTPUT:
    0 - 1023
*/

const int POT_PIN = A0;

void setup() {
  Serial.begin(115200);
}

void loop() {
  int value = analogRead(POT_PIN);

  // Send one value per line
  Serial.println(value);

  delay(20);   // ~50 samples/sec
}
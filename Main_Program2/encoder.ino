//void enc_motor() {
//  if (millis() - timelast >= 1000) {
//    timelast = millis();
//    rpm_ = ((counter * 60) / 120) * 10;
//    rpm_ = map(rpm_, 900, 3010, 1050, 2350);
//    PID_counter();
//  }
//}

void doEncoderA() {
  bool PinB = digitalRead(encoderPinB);
  bool PinA = digitalRead(encoderPinA);

  if (PinB == LOW) {
    if (PinA == HIGH) {
      counter++;
    }
    else {
      counter--;
    }
  }
  else {
    if (PinA == HIGH) {
      counter--;
    }
    else {
      counter++;
    }
  }
}

void doEncoderB() {
  bool PinB = digitalRead(encoderPinA);
  bool PinA = digitalRead(encoderPinB);

  if (PinA == LOW) {
    if (PinB == HIGH) {
      counter--;
    }
    else {
      counter++;
    }
  }
  else {
    if (PinB == HIGH) {
      counter++;
    }
    else {
      counter--;
    }
  }
}

void updateEncoder() {
  // Read the current state of CLK
  currentStateCLK = digitalRead(encoderPinA);

  // If last and current state of CLK are different, then pulse occurred
  // React to only 1 state change to avoid double counter
  if (currentStateCLK != lastStateCLK  && currentStateCLK == 1) {

    // If the DT state is different than the CLK state then
    // the encoder is rotating CCW so decrement
    if (digitalRead(encoderPinB) != currentStateCLK) {
      counter --;
    } else {
      // Encoder is rotating CW so increment
      counter ++;
    }
  }

  // Remember last CLK state
  lastStateCLK = currentStateCLK;
}

void enc_debug() {
  Serial.print("Counter: ");
  Serial.print(counter);
  lcd.setCursor(0, 1);
  lcd.print("Counter : ");
  lcd.print(counter);
}

//void enc_interupt() {
//  rotate = (360 * counter) / (PPR * decodeNumber * gearRatio);
//  counter = rotate;
//  if (counter == previous_counter) {
//    counter = 0;
//  }
//  lcd.setCursor(2, 1);
//  lcd.print(counter);
//  Serial.print("Encoder : ");
//  Serial.println(counter);
//  previous_counter = counter;
//}

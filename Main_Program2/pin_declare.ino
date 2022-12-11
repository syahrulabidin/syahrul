void val_pin() {
  val_tacho_n = analogRead(tacho_cw);
  val_tacho_n1 = analogRead(tacho_ccw);
  val_encp_n = analogRead(enc_pot);
  val_encs_n = analogRead(enc_set);
  for (int i = 0; i < 3; i++) {
    val_pot_n[i] = analogRead(pin_pid[i]);
  }
  val_times_n = analogRead(time_s);
}

void switch_pin() {
  val_SEL1 = digitalRead(SEL1);
  val_SEL2 = digitalRead(SEL2);
  val_SEL3 = digitalRead(SEL3);

}

void types(String a) {
  Serial.println("it's a String");
}
void types(int a) {
  Serial.println("it's an int");
}
void types(char *a) {
  Serial.println("it's a char*");
}
void types(float a) {
  Serial.println("it's a float");
}
void types(bool a) {
  Serial.println("it's a bool");
}

void val_pin_setup() {
  val_tacho_n = analogRead(tacho_cw);
  val_tacho_ccw = analogRead(tacho_ccw);
  val_encp_n = analogRead(enc_pot);
  val_encs_n = analogRead(enc_set);
  for (int i = 0; i < 3; i++) {
    val_pid[i] = analogRead(pin_pid[i]);
  }
  val_times = analogRead(time_s);
}

void filter_pot() {
  val_pin_setup();

  #ifdef Rafief
    val_tacho_n = map(val_tacho_n, 0, 1023, 0, 255);    //tacho_cw
    val_encp_n = map(val_encp_n, 0, 671, 0, 360);            //Output
    val_encs_n = map(val_encs_n, 0, 671, 0, 360);            // Input
    for (int i = 0; i < 3; i++) {
      val_pid[i] = map(val_pid[i], 0, 671, 0, 100) * 0.1;
    }
    val_times = map(val_times, 0, 671, 0, 100) * 10;
  
    val_encs_n = poten_filter(val_encs_n, 348);
    val_encp_n = poten_filter(val_encp_n, 131);
  #endif
    
  #ifdef Sidik
    val_tacho_n = map(val_tacho_n, 0, 1023, 0, 255);    //tacho_cw
    val_encp_n = map(val_encp_n, 0, 667, 0, 360);            //Output
    val_encs_n = map(val_encs_n, 0, 667, 0, 360);            // Input
    for (int i = 0; i < 3; i++) {
      val_pid[i] = map(val_pid[i], 0, 667, 0, 100) * 0.1;
    }
    val_times = map(val_times, 0, 667, 0, 100) * 10;
  
    val_encs_n = poten_filter(val_encs_n, 55);
    val_encp_n = poten_filter(val_encp_n, 200);
  #endif

  #ifdef Abidin
    val_tacho_n = map(val_tacho_n, 0, 1023, 0, 255);    //tacho_cw
    val_encp_n = map(val_encp_n, 0, 694, 0, 360);            //Output
    val_encs_n = map(val_encs_n, 0, 694, 0, 360);            // Input
    for (int i = 0; i < 3; i++) {
      val_pid[i] = map(val_pid[i], 0, 694, 0, 100) * 0.1;
    }
    val_times = map(val_times, 0, 694, 0, 100) * 10;
  
    val_encs_n = poten_filter(val_encs_n, 180);
    val_encp_n = poten_filter(val_encp_n, 132);
  #endif

  val_tacho_cw = (EMA_a * val_tacho_n) + ((1 - EMA_a) * val_tacho_cw);
  val_encp = (EMA_a * val_encp_n) + ((1 - EMA_a) * val_encp);
  val_encs = (EMA_a * val_encs_n) + ((1 - EMA_a) * val_encs);

}

//int valp_filter(float var, int sp) {
//  SP_nol = sp;
//  selisih = 360 - SP_nol;
//  if (var >= SP_nol) {
//    var = map(var, SP_nol, 360, 0, selisih);
//  } else {
//    var = map(var, 0, (SP_nol - 1), (selisih + 1), 360);
//  }
//  return var;
//}

int SP_nol, SP_360;
float real_sensor, real_sensor1;

int poten_filter(float raw, int sp_nol) {
  SP_nol = sp_nol;
  SP_360 = 360 - SP_nol;
  real_sensor = raw - SP_nol;
  if (real_sensor < 0) {
    real_sensor = 360 + real_sensor;
  }
  return real_sensor;
}

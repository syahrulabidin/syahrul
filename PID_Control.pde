void GUI_setup()
{
  int PosXslider = 450;
  int PosYslider = 100;
  
    cp5.addToggle("Tuning PID")
    .setPosition(PosXslider, PosYslider-30)
      .setSize(10, 10)
        ;  

  cp5.addSlider("SP")
    .setPosition(PosXslider, PosYslider)
      .setRange(0, 360)
        ;

  cp5.addSlider("KP")
    .setPosition(PosXslider, PosYslider+(20*1))
      .setRange(0, 10)
        ;

  cp5.addSlider("KI")
    .setPosition(PosXslider, PosYslider+(20*2))
      .setRange(0, 10)
        ;

  cp5.addSlider("KD")
    .setPosition(PosXslider, PosYslider+(20*3))
      .setRange(0, 10)
        ;
}

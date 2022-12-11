import processing.serial.Serial;
import controlP5.*;
Serial serial;
ControlP5 cp5;

PFont font10, font12, font14, font20;

Chart val_tacho_cw_chart;
color yellow_ = color(200, 200, 20), green_ = color(46, 209, 2), red_ = color(120, 30, 30), blue_ = color (0, 102, 200);
color white_ = color(255, 255, 255), black_ = color(0, 0, 0), pink_ = color(255, 0, 255), gray_ = color(128,128,128);
color brown_ = color(150, 75, 0), zaitun_ = color(128, 128, 0);

//UART Variable
int serial_conect = 0;
int commListMax;
int[] data = null;

Textlabel txtwhichcom; 
ListBox commListbox;
ListBox portlist;

String shortifyPortName(String portName, int maxlen)  
{
  String shortName = portName;
  if (shortName.startsWith("/dev/")) shortName = shortName.substring(5);  
  if (shortName.startsWith("tty.")) shortName = shortName.substring(4); // get rid off leading tty. part of device name
  if (portName.length()>maxlen) shortName = shortName.substring(0, (maxlen-1)/2) + "~" +shortName.substring(shortName.length()-(maxlen-(maxlen-1)/2));
  if (shortName.startsWith("cu.")) shortName = "";// only collect the corval_tacho_cwding tty. devices
  return shortName;
}

PImage logo;

boolean TuningPID = false;

float SP,KP,KI,KD;

float val_tacho_cw,val_times,val_encs,kape,kai,kade,error;

void setup()
{
  size(800, 400, OPENGL);
  PImage logo;
  cp5 = new ControlP5(this);
  
  font10 = createFont("Arial bold", 10, false);
  font12 = createFont("Arial bold", 12, false);
  font14 = createFont("Arial bold", 14, false);
  font20 = createFont("Arial bold", 20, false);
  
  val_tacho_cw_chart = cp5.addChart("RESPON GRAPH")
    .setPosition(10, 170)
      .setSize(400, 200)
        .setRange(0, 360)
          .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
            ;
  val_tacho_cw_chart.getColor().setBackground(color(255, 100));
  
  val_tacho_cw_chart.addDataSet("val_encs");
  val_tacho_cw_chart.setColors("val_encs", color(255, 255, 0), color(255));
  val_tacho_cw_chart.setData("val_encs", new float[255]);

  val_tacho_cw_chart.addDataSet("val_tacho_cw");
  val_tacho_cw_chart.setColors("val_tacho_cw", color(0, 255, 0), color(255));
  val_tacho_cw_chart.updateData("val_tacho_cw", new float[255]);
  
  GUI_setup();
  setup_UART();
}

void draw()
{
  background(gray_);
  logo = loadImage("Lambang UGM.png");
  //image(logo, 0, 0);
  image(logo, 10, 10, logo.width/20, logo.height/20);
  
  
  textFont(font12);
  
  text("TRIK 20", 750, 390);
  textFont(font20);
  text("Speed Control of DC Motor using PID", 95, 45);
  textFont(font14);
  text("Kelompok 3", 95, 70);
  
  val_tacho_cw_chart.push("val_encs", SP);
  val_tacho_cw_chart.push("val_tacho_cw", val_tacho_cw);
  
  int PosX_info=  450;
  int PosY_info=  180;

  textFont(font14);
  text("Set Point : "+SP, PosX_info, PosY_info+(30*1));
  textFont(font14);
  text("Tacho : "+val_tacho_cw , PosX_info, PosY_info+(30*2));

  textFont(font14);
  text("Kp : "+KP, PosX_info, PosY_info+(30*3));
  textFont(font14);
  text("Ki : "+KI, PosX_info, PosY_info+(30*4));
  textFont(font14);
  text("Kd : "+KD, PosX_info, PosY_info+(30*5));
  
  textFont(font14);
  text("Time Sampling : "+val_times + " s", PosX_info, PosY_info+(30*6));
  
  Send_To_Arduino();
}

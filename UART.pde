void setup_UART()
{
  //Comport List Selection                   
  commListbox = cp5.addListBox("portComList",10,100,110,240); // make a listbox and populate it with the available comm ports

  commListbox.getCaptionLabel().set("PORT COM");commListbox.setColorBackground(red_);
  
  for(int i=0;i<Serial.list().length;i++) 
  {
    
    String pn = shortifyPortName(Serial.list()[i], 13);
    if (pn.length() >0 ) commListbox.addItem(pn,i); // addItem(name,value)
    commListMax = i;
  }
  
  commListbox.addItem("Close Comm",++commListMax); // addItem(name,value)
  // text label for which comm port selected
  //txtwhichcom = cp5.addTextlabel("txtwhichcom","No Port Selected",10,90); // textlabel(name,text,x,y)
  fill(0, 255, 0);
  noFill();
}

void Tuning_PID_param()
{

  byte out[]=new byte[6];
  out[0]=byte(255);
  out[1]=byte(int(SP*100));
  out[2]=byte(int(KP*100));
  out[3]=byte(int(KI*100));
  out[4]=byte(int(KD*100));
  out[5]=byte(254);

  serial.write(out);
}


void Send_To_Arduino()
{

  if (serial_conect==1) 
  {  
       //indicator connect
      fill(0, 255, 0);
      ellipse(100, 67, 10, 10);
      noFill();

    if (TuningPID==true) {
      Tuning_PID_param();
    }


  } 
  
  else 
  {//indicator no connect
      fill(128, 0, 0);
      ellipse(100, 67, 10, 10);
      noFill();
    
  }
}


void serialEvent (Serial usbPort) 
{
  try{
  String usbString = usbPort.readStringUntil ('\n');
  
  if (usbString != null) 
    {
    usbString = trim(usbString);
    println(usbString); //--> for debuging
    }

      float data[] = float(split(usbString, ','));
      //for (int sensorNum = 1; sensorNum < data.length; sensorNum++) { println(sensorNum + " " + data[sensorNum]);  } //--> for debuging
      
      val_tacho_cw=data[1]; //respon (nilai tacho)
      val_encs=data[2]; //setpoint
      
      val_times=data[3];
      
      kape=data[4];
      kai=data[5];
      kade=data[6];
      
      //error=data[7];
      
  }
  catch(RuntimeException e)
  {
    println("Serial event is not null");
  }
    
}


 //initialize the serial port selected in the listBox
 void InitSerial(float portValue) 
 {
  if (portValue < commListMax) {
    String portPos = Serial.list()[int(portValue)];
    txtwhichcom.setValue("Connected = " + shortifyPortName(portPos, 8));
    serial = new Serial(this, portPos, 9600); //buat connect arduino
    serial.bufferUntil('\n');
    serial_conect=1;

   

  } else 
  {
    txtwhichcom.setValue("Not Connected");
    serial.clear();
    serial.stop();
    serial_conect=0;

  }
 }
 
 void controlEvent(ControlEvent theControlEvent)
{
  if (theControlEvent.isGroup()) if (theControlEvent.name()=="portComList") InitSerial(theControlEvent.group().getValue()); // initialize the serial port selected
  
}

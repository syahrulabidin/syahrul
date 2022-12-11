void Read_command()
{
    static unsigned char data[255]={0}; 
     int i,msg;
          msg = Serial.available();
          
          if (msg>255) msg=0; //protection buffer
          if(msg > 0){for(i = 0; i < msg; i++){data[i] = Serial.read();}}
        
          if(data[0] == 255 && data[5] == 254) //packet data
          {
            val_encs_p = data[1]; //set point
            kp_p = data[2];
            ki_p = data[3];
            kd_p = data[4];
          }
          
//          if(data[0] == 255 && data[2] == 254) //one character
//          {
//
//          }
//          
//          if(data[0] == 155 && data[9] == 154) //packet tuning parameter
//          {
//    
//          }
//
//          if(data[0] == 100 && data[12] == 99) //packet tuning offset motor
//          {
//          
//         }
          
 Serial.flush();
  }

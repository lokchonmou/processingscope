/*
2014-10-9
 Using to plot the analog value
 Here is the Arduino Code:
/*------------------------------
 void setup()
 {
 Serial.begin(115200);
 }
 
 void loop(){
 Serial.print(analogRead(0));
 Serial.print(',');
 Serial.println(analogRead(1));
 delay(5);
 }
/*------------------------------
 Change the  delay(5) to change the scale of time
 Change the y_low_limit, y_up_limit, y_grid, x_grid to change the display
 Change the no_of_data to make sure the data number are match, you can add more no of data
 */



void setup() {

  size(640, 480);
  //設定上下限和格線等
  y_low_limit = 0;
  y_up_limit = 1023;
  y_grid = 100;
  
  delay_value = 5;  //輸入在arduino端的delay值   
  x_grid = 1000;      //輸入每多少ms一個grid
  
  no_of_data = 2;
  blank_space = 0.08;   //上下左右留白多少, 0.05=5%
  //---------------------------------
  calibration();
  //---------------------------------
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[9], 115200); //有需要可修改方括, 得出不同的com頭, 也可修改bitrate
  myPort.bufferUntil('\n');  //收到enter就處理
  //---------------------------------
  
}
<<<<<<< HEAD



=======
>>>>>>> FETCH_HEAD

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
   Serial.print(analogRead(1));
   Serial.print(',');
   Serial.println(analogRead(2));
  delay(10);
}
/*------------------------------
Change the  delay(10) to change the scale of time
Change the y_low_limit, y_up_limit, y_grid, x_grid to change the display
Change the no_of_data to make sure the data number are match 
*/


import processing.serial.*;
Serial myPort;
float x, y, y_low_limit, y_up_limit, x_grid, y_grid;
byte no_of_data;
long counter;
float[] data, last_data;

void setup() {

  //設定上下限和格線等
  y_low_limit = 0;
  y_up_limit = 1100;
  y_grid = 100;
  x_grid = 100;
  no_of_data = 3;
  //---------------------------------

  size(800, 700);
  strokeWeight(3); //線段粗幼
  textAlign(LEFT, LEFT); //字體對中

  data = new float[no_of_data];
  last_data = new float[no_of_data];
  
  refresh(); //自訂函數, 見下文
  counter++;
  
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[9], 115200);
  myPort.bufferUntil('\n');  //收到enter就處理
}

void draw() {
  //此處為空
}

void refresh() {    //重填背景, 之後再劃上座標線
  x = 0;
  colorMode(RGB, 255);
  background(255);
  stroke(100);
  strokeWeight(1);
  fill(0);
  textSize(12);
  for (float i = y_low_limit; i <= y_up_limit; i+=y_grid) {
    line(0, map(i, y_low_limit, y_up_limit, height, 0), width, map(i, y_low_limit, y_up_limit, height, 0));
    text(str(int(i)), 0, map(i, y_low_limit, y_up_limit, height, 0));
  }
  for ( long j = 0; j <= width; j+=x_grid) {
    line(j, 0, j, height);
    text(str(int(counter*width + j)), j, height);
  }
}

void serialEvent(Serial myPort) {  //每次serial收到之後運行
  String myString = myPort.readStringUntil('\n');

  if (myString != null) {
    myString = trim(myString);
    data = float(split(myString, ','));

    strokeWeight(2);
    colorMode(HSB, 100);
    for (int i = 0; i < data.length; i++) {
      print(data[i] + "    "  );
      stroke(i*100/data.length, 100, 100);
      line(x-1, map(last_data[i], y_low_limit, y_up_limit, height, 0), x, map(data[i], y_low_limit, y_up_limit, height, 0));
    }
    println();
    x++;
    if (x > width) {
      refresh();
      counter++;
    }
    for (int i = 0; i < data.length; i++) 
      last_data[i] = data[i];
  }
}


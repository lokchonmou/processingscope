import processing.serial.*;
Serial myPort;
float x, y, y_low_limit, y_up_limit, x_grid, y_grid, delay_value, blank_space;
byte no_of_data;
long counter;
float[] data, last_data;

void draw() {
  //此處為空
}

void refresh() {    //重填背景, 之後再劃上座標線
  x = 0;
  colorMode(RGB, 255);
  background(193);
  stroke(0);
  fill(255);
  rect(blank_space*width,blank_space*height, (1- blank_space*2)*width, (1- blank_space*2)*height);
  stroke(100);
  strokeWeight(1);
  fill(0);
  textSize(12);
  for (float i = y_low_limit; i <= y_up_limit; i+=y_grid) {
        line(blank_space*width, map(i, y_low_limit, y_up_limit, (1-blank_space)*height, blank_space*height), (1-blank_space)*width, map(i, y_low_limit, y_up_limit, height*(1-blank_space), height*blank_space));
        text(str(int(i)), blank_space*width, map(i, y_low_limit, y_up_limit, height*(1-blank_space), blank_space*width));
  }
  for ( long j = 0; j <= width; j+=x_grid/delay_value) {
        line(map(j,0,width,blank_space*width,(1-blank_space)*width), blank_space*height, map(j,0,width,blank_space*width,(1-blank_space)*width), (1-blank_space)*height);
        text(int((counter*width + j)*delay_value)+"ms", map(j,0,width,blank_space*width,(1-blank_space)*width), (1-blank_space)*height);
  }
}

void serialEvent(Serial myPort) {  //每次serial收到之後運行

  String myString = myPort.readStringUntil('\n');

  if (myString != null) {
    myString = trim(myString);
    data = float(split(myString, ','));

    strokeWeight(1);
    colorMode(HSB, 100);
    for (int i = 0; i < data.length; i++) {
      print(data[i] + "    "  );
      stroke(i*100/data.length, 100, 100);
        line(map(x-1,0,width,blank_space*width,(1-blank_space)*width), map(last_data[i], y_low_limit, y_up_limit, (1-blank_space)*height, blank_space*height), map(x,0,width,blank_space*width,(1-blank_space)*width), map(data[i], y_low_limit, y_up_limit, (1-blank_space)*height, blank_space*height));
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


void calibration(){
  textAlign(LEFT, LEFT); //字體對左
  data = new float[no_of_data];
  last_data = new float[no_of_data];
  refresh(); //自訂函數, 見下文
  counter++;
}

import controlP5.*;

class Store {
  ControlP5 cp5;
  Button toLibrary;
  
  public Store(PApplet p) {
    cp5 = new ControlP5(p);
    toLibrary = cp5.addButton("Library")
    .setPosition(width*40/500, height*25/500-(height*10/500))
    .setSize(width*50/500, height*20/500)
    .setVisible(false)
    .setColorBackground(color(110))
    .setColorForeground(color(90))
    .setColorActive(color(70))
    .setFont(createFont("Arial", 11));
  }

  public void drawStore() {
    clear();
    toLibrary.setVisible(true);
    fill(255);
    textSize((int) ((double)1 / (double)15 * (double)height));
    text("Store", (int)((double)17/(double)40 * (double)width), (int)((double)3/(double)40 * (double)height));
    // Line
    fill(255, 255, 2500);
    stroke(126);
    // Line across screen at 10% down
    line(0, (int)((double)height/(double)10), width, (int)((double)height/(double)10));
  }
}

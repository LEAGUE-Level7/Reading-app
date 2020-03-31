import controlP5.*;

class Store {
  ControlP5 cp5;
  Textfield storeSearch;
  Button clear;
  Button toLibrary;

  String searchQuery;

  Controller[] widgets;
  
  public Store(PApplet p) {
    cp5 = new ControlP5(p);
    storeSearch = cp5.addTextfield("StoreSearch")
    .setPosition(width*330/500, height*25/500-(height*10/500))
    .setSize(width*100/500, height*20/500)
    .setFont(createFont("Arial", 16))
    .setFocus(true)
    .setAutoClear(false)
    .setVisible(false)
    .setColor(color(0))
    .setColorBackground(color(255))
    .setColorForeground(color(255))
    .setColorCursor(color(0));
    clear = cp5.addButton("Clear")
    .setPosition(width*440/500, height*25/500-(height*10/500))
    .setSize(width*50/500, height*20/500)
    .setVisible(false)
    .setColorBackground(color(110))
    .setColorForeground(color(90))
    .setColorActive(color(70))
    .setFont(createFont("Arial", 11));
    toLibrary = cp5.addButton("Library")
    .setPosition(width*40/500, height*25/500-(height*10/500))
    .setSize(width*50/500, height*20/500)
    .setVisible(false)
    .setColorBackground(color(110))
    .setColorForeground(color(90))
    .setColorActive(color(70))
    .setFont(createFont("Arial", 11));

    searchQuery = "";
    
    widgets = new Controller[3];
    widgets[0] = storeSearch;
    widgets[1] = clear;
    widgets[2] = toLibrary;
  }

  public void drawStore() {
    clear();
    storeSearch.setVisible(true);
    clear.setVisible(true);
    toLibrary.setVisible(true);
    cp5.getController("StoreSearch").getCaptionLabel().setVisible(false);

    if(storeSearch.isFocus() && keyPressed) {
      if(key==ENTER || key==RETURN) {
        searchQuery =  storeSearch.getText();
        //set cPage to 0
      }
    }

    fill(255);
    textSize((int) ((double)1 / (double)15 * (double)height));
    text("Store", (int)((double)17/(double)40 * (double)width), (int)((double)3/(double)40 * (double)height));
    // Line
    fill(255, 255, 2500);
    stroke(126);
    // Line across screen at 10% down
    line(0, (int)((double)height/(double)10), width, (int)((double)height/(double)10));
  }

  void clearSearch() {
    searchQuery = "";
    storeSearch.setText("");
    //set cPage to 0
  }
}

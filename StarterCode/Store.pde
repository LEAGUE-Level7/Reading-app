import controlP5.*;
import de.bezier.data.sql.*;

class Store {
  ControlP5 cp5;
  Textfield storeSearch;
  Button clear;
  Button toLibrary;

  String searchQuery;

  Controller[] widgets;

  SQLite db;
  RetrieveData rd = new RetrieveData();

  ArrayList<String> bookImages;
  ArrayList<ArrayList<String>> imageMat;

  int cPage;
  int columns;
  
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

    cPage = 0;
    columns = width/250;

    bookImages = new ArrayList<String>();
    imageMat = new ArrayList<ArrayList<String>>();

    db = new SQLite(new StarterCode(), "readingapp.db");

    try{
      println(rd.retrieveData("http://localhost:8080/all"));
      String data = rd.retrieveData("http://localhost:8080/all");
      values = parseJSONArray(data);
      if (values == null){
        println("JSONArray could not be parsed");
      } else{
        for(int i = 0; i < values.size(); i++) {
          bookImages.add(values.getJSONObject(i).getString("image"));
        }
      }
    
    }catch (Exception e){
      println(e);
    }
  }

  public void drawStore() {
    imageMat = convertToMat(searchQuery);
    clear();
    storeSearch.setVisible(true);
    clear.setVisible(true);
    toLibrary.setVisible(true);
    cp5.getController("StoreSearch").getCaptionLabel().setVisible(false);

    int numBooks = imageMat.size() == 0 ? 0 : 4*(imageMat.size()-1)+imageMat.get(imageMat.size()-1).size();

    if(storeSearch.isFocus() && keyPressed) {
      if(key==ENTER || key==RETURN) {
        searchQuery =  storeSearch.getText();
        cPage = 0;
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

    if(numBooks!=0) {
      drawBooks(); 
    } else {
      //either no books to show or book not found
    }
  }

  void clearSearch() {
    searchQuery = "";
    storeSearch.setText("");
    cPage = 0;
  }

  ArrayList<ArrayList<String>> convertToMat(String filter) {
    ArrayList<ArrayList<String>> imageMat = new ArrayList<ArrayList<String>>();
    ArrayList<String> temporaryList = new ArrayList<String>();
    int it = 0;
    for (String s : bookImages) {
      if (filter.equals("")) {
        temporaryList.add(s);
      } else if (s.toLowerCase().contains(filter.toLowerCase())) {
        temporaryList.add(s);
      } else continue;

      if (it == columns*columns-1) {
        it = 0;
        imageMat.add(temporaryList);
        temporaryList = new ArrayList<String>();
      } else {
        it++;
      }
    }
    if (temporaryList.size() > 0) {
      imageMat.add(temporaryList);
    }
    return imageMat;
  }

  void drawBooks() {
    int coverWidth = width*285/500;
    int coverHeight = height*285/500;
    float xPos = width*428/500;
    float yPos = height*428/500;
    int newHeight = height - (int)((double)height/(double)10);
    float xOffset = (float) width/10;
    float yOffset = (float)((double)height/10) + (int) ((double) 1/columns * (double) (newHeight - (double) coverHeight/columns - (double) (columns-1)* (double) yPos/columns));

    //drawing books that belong to spot/page
    int bookIterator = 0;
    for (String s : imageMat.get(cPage)) {
      // iterate over treemap for each book.
      PImage cover = loadImage(s);
      cover.resize(coverWidth/columns, coverHeight/columns);
      image(cover, xOffset+(bookIterator % (columns)) * xPos/columns, yOffset+(bookIterator - (bookIterator % (columns)))/(columns) * yPos/columns);
      bookIterator++;
    }
  }
}

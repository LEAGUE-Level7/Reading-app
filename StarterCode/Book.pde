class Book {
 private String title;
 private int nPages;
 //current page object
 private Page currentPage;
 //current page #
 private int curPageN;
 private PImage coverImg;
 private int page;
 private int spot;
 
 private Page[] pages;

 public Book(String title, int nPages, Page[] pages) {
  if(nPages!=0) {
    currentPage = pages[0];   
  }
  if(pages.length != nPages) {
    System.out.println("Page number mismatch");
  }
  this.pages = pages;
  this.title = title;
  this.nPages = nPages;
  this.pages = pages;
  curPageN = 1;
 }

 public Book(String title, int nPages, Page[] pages, String coverFile) {
  this(title, nPages, pages);
  coverImg = loadImage(coverFile);
 }
 
 public Book(String title, int nPages, Page[] pages, String coverFile, boolean url) {
   this(title, nPages, pages);
   if(url) {
    coverImg = loadImage(coverFile, "png");
   } else {
    coverImg = loadImage(coverFile);
   }
 }
   
 
 public String getTitle() {
   return title;
 }
 
 public Page getCurrentPage() {
   return currentPage;
 }
 
 public int getCurPage() {
   return curPageN; 
 }
 
 public void setCurPage(int n) {
   curPageN = n; 
 }
 
 public int getTotalPages() {
   return nPages; 
 }
 
 public PImage getCoverImg() {
   return coverImg;
 }
 public void setPage(int p){
   page = p;
 }
 public int getPage(){
   return page;
 }
 public void setSpot(int s){
   spot = s;
 }
 public int getSpot(){
   return spot;
 }
}

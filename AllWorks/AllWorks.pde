import java.util.Date;
String path;
Table files;
int imgCount = 0;
PImage img;

void setup(){
  
  noLoop();
  files = new Table();
  files.addColumn("Path", Table.STRING);
  files.addColumn("Date", Table.LONG);
  files.addColumn("Width", Table.INT);
  files.addColumn("Height", Table.INT);
  selectFolder("Select a folder to process:", "folderSelected");
}

void draw(){

}

void folderSelected(File selection) {
  if (selection == null)
    println("Window was closed or the user hit cancel.");
  else {
    path = selection.getAbsolutePath();
    println(path);
    getFiles(path);
  }
  
  println(imgCount);
  saveTable(files, "data/images.csv");
}

void getFiles(String dir){
  File file = new File(dir);
  if (file.isDirectory()){
    File[] subFiles = file.listFiles();
    //println(subFiles.length);
    for(int i = 0; i < subFiles.length; i++){
      getFiles(subFiles[i].getAbsolutePath());
    }
  }
  else {
    String ext = file.getName();
    ext = ext.substring(ext.indexOf(".")+1);
    ext.toLowerCase();
    if(ext.equals("png")) {
      img = loadImage(file.getAbsolutePath());
      if (img.width < 200 || img.height<200)
        return;
      
      TableRow timg = files.addRow();
      timg.setInt("Width", img.width);
      timg.setInt("Height", img.height);
      timg.setString("Path", file.getAbsolutePath());
      timg.setLong("Date", file.lastModified());
      
      imgCount++;
    }
  }
  
}
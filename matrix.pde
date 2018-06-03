//char[] chars = {'｡','｢','｣','､','･','ｦ','ｧ','ｨ','ｩ','ｪ','ｫ','ｬ','ｭ','ｮ','ｯ','ｰ','ｱ','ｲ','ｳ','ｴ','ｵ','ｶ','ｷ','ｸ','ｹ','ｺ','ｻ','ｼ','ｽ','ｾ','ｿ','ﾀ','ﾁ','ﾂ','ﾃ','ﾄ','ﾅ','ﾆ','ﾇ','ﾈ','ﾉ','ﾊ','ﾋ','ﾌ','ﾍ','ﾎ','ﾏ','ﾐ','ﾑ','ﾒ','ﾓ','ﾔ','ﾕ','ﾖ','ﾗ','ﾘ','ﾙ','ﾚ','ﾛ','ﾜ','ﾝ','ﾞ','ﾟ','7','ｧ','ｨ','ｩ','ｪ','ｫ','ｬ','ｭ','ｮ','ｯ','ｰ','ｱ','ｲ','ｳ','ｴ','ｵ','ｶ','ｷ','ｸ','ｹ','ｺ','ｻ','ｼ','ｽ','ｾ'};
char[] chars = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','a','b','c','d','e','f','g','h','i','j','k','l','0','1','2','3','4','5','6','7','8','9','$','+','-','*','/','=','%','"','\'','#','@','&','_','(',')',',','.',';',':','?','!','\\','<','[',']','`','^'};
char[] humanReadableChars;
PFont font;
PFont humanReadableFont;
int colWidth;
int lineHeight = 25;
int particleTailLength = 35;
int xOffset = 0; // For example 1920: left screen with width of 1920px is left blank
int xMax = 0;
float minSpeed = 0.3;
float maxSpeed = 1.7;
int particleStability = 15;
int particleVitality = 90;
int particleCount = 45;
boolean endOnKey = true;
boolean endOnMouse = true;
Particle[] particles;
boolean checkUpdate = true;
String downloadLink = "";
String downloadKey = "y";

int version = 1;

void setup() {
  fullScreen(P2D, SPAN);
  noCursor();
  textAlign(CENTER, TOP);
  font = loadFont("Katakana-96.vlw");
  humanReadableFont = loadFont("Calibri-96.vlw");
  loadConf();
  textFont(font, int(lineHeight*1.85));
  colWidth = lineHeight;
  //frameRate(10);
  particles = new Particle[particleCount];
  for(int i = 0; i<particles.length; i++) {
    particles[i] = new Particle();
  }
  if (checkUpdate) {
    thread("checkUpdate");
  }
}

void draw() {
  background(0);
  for(int i = 0; i<particles.length; i++) {
    particles[i].tick();
  }
  
  checkMouse();
}

void checkMouse() {
  if (frameCount > 2 && endOnMouse && (pmouseY != mouseY || pmouseX != mouseX)) {
    exit();
  }
}

void keyPressed() {
  if ((key == downloadKey.charAt(0) || key == downloadKey.toUpperCase().charAt(0)) && downloadLink != "") {
    link(downloadLink);
  }
  if (endOnKey) {
    exit();
  }
}

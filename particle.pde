class Particle {
  PVector pos;
  PVector desiredPos;
  char currentChar;
  int stability = particleStability;
  int vitality = particleVitality;
  int tailLength = particleTailLength;
  int age = 0;
  float speed = 1;
  boolean humanReadable = false;
  int charIndex = 0; // used to display characters in order if humanReadable
  Particle tail;
  
  Particle() {
    desiredPos = randomPos();
    pos = desiredPos.copy();
    speed = random(minSpeed, maxSpeed);
    newChar();
  }
  
  Particle copy() {
    Particle p = new Particle();
    p.pos.x = pos.x;
    p.pos.y = pos.y;
    p.desiredPos.x = desiredPos.x;
    p.desiredPos.y = desiredPos.y;
    p.currentChar = currentChar;
    p.stability = stability;
    p.vitality = vitality;
    p.age = age;
    p.humanReadable = humanReadable;
    p.tailLength = tailLength;
    if (tail != null) {
      p.tail = tail.copy();
    }
    return p;
  }
  
  void newChar() {
    if (humanReadable) {
      newChar(humanReadableChars[charIndex%humanReadableChars.length]);
      charIndex++;
    } else {
      newChar(chars[int(random(chars.length))]);
    }
  }
  void newChar(char c) {
    currentChar = c;
  }
  
  void tick() {
    if (age == 0) {
      desiredPos.y += lineHeight*speed;
    }
    if (desiredPos.y - pos.y >= lineHeight) {
      while(desiredPos.y - pos.y >= lineHeight) {
        move();
        //draw();
      }
    } else {
      //draw();
    }
    draw();
    if (tail != null) {
      tail.draw();
    }
  }
  
  void draw() {
    if (tail != null) {
      if (tail.age >= tailLength) {
        tail = null;
      } else {
        //tail.draw();
      }
    }
    if (age == 0) {
      fill(200, 255, 200);
    } else {
      if (tail != null) {
        tail.draw();
      }
      fill(0, 255, 0, map(age, 0, tailLength, 255, 0));
      age++;
    }
    pushMatrix();
    translate(pos.x+0.5*colWidth, pos.y);
    if (humanReadable) {
      textFont(humanReadableFont, int(lineHeight*1.3));
      //translate(pos.x+0.5*colWidth, pos.y);
      rotate(HALF_PI);
    }
    text(currentChar,0,0);
    popMatrix();
    if (humanReadable) {
      textFont(font, int(lineHeight*1.85));
    } else if (int(random(stability))==0 && stability > 0) {
      newChar();
    }
  }
  
  void move() {
    tail = this.copy();
    tail.age ++;
    tail.stability /= 2;
    if (humanReadable) {
      pos.y += lineHeight*0.6;
    } else {
      pos.y += lineHeight;
    }
    if (pos.y >= height) {
      pos.y = desiredPos.y = 0;
      if (humanReadable) {
        pos.x = desiredPos.x = pos.x+colWidth;
        if (pos.x > width-xMax) {
          desiredPos = randomPos();
          pos = desiredPos.copy();
        }
      }
    }
    if (int(random(vitality))==0 && vitality > 0) {
      desiredPos = randomPos();
      pos = desiredPos.copy();
      speed = random(minSpeed, maxSpeed);
      newChar();
    }
    if (humanReadable) {
      newChar();
    }
  }
  
  PVector randomPos() {
    return new PVector(int(random(int((width-xOffset-xMax)/colWidth)))*colWidth+xOffset, int(random(int(height/lineHeight)))*lineHeight);
  }
  
  void makeHumanReadable() {
    humanReadable = true;
    vitality = 200;
    speed = 0.3;
    tailLength = humanReadableChars.length*4;
  }
}

/** Configuration
    '- Functions for loading and saving the following variables to data/config.txt:
+ version
+ checkUpdate
+ lineHeight
+ tailLength
+ minSpeed
+ maxSpeed
+ xOffset
+ xMax
+ particleCount
+ particleStability
+ particleVitality
+ endOnMouse
+ endOnKey
+ version (used determine if the config file has to be updated)
*/

void loadConf() {
  Compare[] data = Compare.toArray(loadStrings("data/config.txt"));
  if (data == null) {
    println("Creating config file at data/config.txt");
    saveConf();
  } else {
    boolean versionMatch = false;
    readConfig: for (int i = 0; i < data.length; i++) {
      while (data[i].startsWith("#") || trim(data[i].value).equals("")) { // skip comments and empty lines
        i++;
        if (i >= data.length) { // necessary if the config ends on a comment to prevent arrayIndex outOfBounds
          break readConfig;
        }
      }
      
      if (data[i].startsWith("lineHeight")) {
        lineHeight = int(data[i].rest);
      } else if (data[i].startsWith("tailLength")) {
        particleTailLength = int(data[i].rest);
      } else if (data[i].startsWith("minSpeed")) {
        minSpeed = float(data[i].rest);
      } else if (data[i].startsWith("maxSpeed")) {
        maxSpeed = float(data[i].rest);
      } else if (data[i].startsWith("xOffset")) {
        xOffset = int(data[i].rest);
      } else if (data[i].startsWith("xMax")) {
        xMax = int(data[i].rest);
      } else if (data[i].startsWith("particleCount")) {
        particleCount = int(data[i].rest);
      } else if (data[i].startsWith("particleStability")) {
        particleStability = int(data[i].rest);
      } else if (data[i].startsWith("particleVitality")) {
        particleVitality = int(data[i].rest);
      } else if (data[i].startsWith("endOnMouse")) {
        endOnMouse = boolean(data[i].rest);
      } else if (data[i].startsWith("endOnKey")) {
        endOnKey = boolean(data[i].rest);
      } else if (data[i].startsWith("version")) {
        versionMatch = (int(data[i].rest) == version);
      } else if (data[i].startsWith("checkUpdate")) {
        checkUpdate = boolean(data[i].rest);
      } else {
        println("Warning! Line "+(i+1)+" in data/config.txt was not recognized:\n"+data[i].value);
      }
    }
    if (!versionMatch) {
      println("Config version does not match program version. Updating config file...");
      saveConf(); // rewrites the config file, but uses values from previous config where applicable
    }
  }
}

void saveConf() {
  String[] data =
  {
    "# Version of this settings file",
    "version           "+version,"",
    "# Check for updates? [true]",
    "checkUpdate       "+checkUpdate,"",
    "# Character size [25]",
    "lineHeight        "+lineHeight,"",
    "# Amount of characters visible after the first one",
    "# (at a speed of 1) [35]",
    "tailLength        "+particleTailLength,"",
    "# Minimum speed (in characters/frame) [0.3]",
    "minSpeed          "+minSpeed,"",
    "# Maximum speed [1.7]",
    "maxSpeed          "+maxSpeed,"",
    "# Amount of pixels to leave blank from the left [0]",
    "xOffset           "+xOffset,"",
    "# Amount of pixels to leave blank from the right [0]",
    "xMax              "+xMax,"",
    "# Amount of particles [45]",
    "particleCount     "+particleCount,"",
    "# 1/particleStability chance for a character to change",
    "# (-1 to disable) [15]",
    "particleStability "+particleStability,"",
    "# 1/particleVitality chance for a particle to reappear somewhere else",
    "# (und alte verschwinden) (-1 to disable) [90]",
    "particleVitality  "+particleVitality,"",
    "# Exit screensaver by moving the mouse? [true]",
    "endOnMouse        "+endOnMouse,"",
    "# Exit screensaver by pressing a key (Escape will always work) [true]",
    "endOnKey          "+endOnKey
  };
  
  saveStrings("data/config.txt", data);
  println("Done.");
}

static class Compare { // used for easily detecting config parameters and extracting their values 
  String value;
  String rest;
  Compare(String in) {
    value = in;
    if (!value.equals("") && value != null) {
      if (int(value.charAt(0)) == 65279) { // It appears that editing the file in notepad etc. causes this to be the first character of the file.
        value = value.substring(1);        // I'm removing it because it can prevent the first line from being recognized as a comment
      }
    }
    rest = value;
  }
  boolean startsWith(String s) {
    if (value.length() >= s.length()) {
      rest = trim(value.substring(s.length()));
      return (s.equals(value.substring(0, s.length())));
    } else {
      rest = null;
      return false;
    }
  }
  static Compare[] toArray(String[] s) {
    if (s == null) return null;
    Compare[] out = new Compare[s.length];
    for (int i = 0; i < s.length; i++) {
      out[i] = new Compare(s[i]);
    }
    return out;
  }
}

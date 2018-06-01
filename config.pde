/** Einstellungen
    '- Funktionen zum Laden und speichern der folgenden Variablen:
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
+ version (verwendet zum Erneuern der Konfigurationsdatei bei einem Update)
*/

void loadConf() {
  Compare[] data = Compare.toArray(loadStrings("data/config.txt"));
  if (data == null) {
    println("Creating config file at data/config.txt");
    saveConf();
  } else {
    boolean versionMatch = false;
    for (int i = 0; i < data.length; i++) {
      while (data[i].startsWith("#") || trim(data[i].value).equals("")) {
        i++;
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
        println("Warnung! Zeile "+(i+1)+" in data/config.txt wurde nicht erkannt:\n"+data[i].value);
      }
    }
    if (!versionMatch) {
      println("Config version does not match program version. Updating config file...");
      saveConf();
    }
  }
}

void saveConf() {
  String[] data =
  {
    "# Version dieser Konfigurationsdatei",
    "version           "+version,"",
    "# Nach updates suchen? [true]",
    "checkUpdate       "+checkUpdate,"",
    "# Größe der Zeichen [25]",
    "lineHeight        "+lineHeight,"",
    "# Anzahl an Zeichen, die auf das erste folgen,",
    "# bis sie verblasst sind (bei einer Geschwindigkeit von 1) [35]",
    "tailLength        "+particleTailLength,"",
    "# Kleinste mögliche Geschwindigkeit (Zeichen pro Bild) [0.3]",
    "minSpeed          "+minSpeed,"",
    "# Größte mögliche Geschwindigkeit [1.7]",
    "maxSpeed          "+maxSpeed,"",
    "# Breite des Randes am linken Bildschirm(-rand) [0]",
    "xOffset           "+xOffset,"",
    "# Breite des Randes an rechten Bildschirm(-rand) [0]",
    "xMax              "+xMax,"",
    "# Anzahl an Partikeln [45]",
    "particleCount     "+particleCount,"",
    "# Je kleiner dieser Wert, je öfter wechselt der Buchstabe",
    "# (-1 zum Ausschalten) [15]",
    "particleStability "+particleStability,"",
    "# Je kleiner dieser Wert, je öfter entstehen neue Partikel",
    "# (und alte verschwinden) (-1 zum Ausschalten) [90]",
    "particleVitality  "+particleVitality,"",
    "# Mausbewegung beendet das Programm [true]",
    "endOnMouse        "+endOnMouse,"",
    "# Tastatur beendet das Programm (Esc funktioniert immer) [true]",
    "endOnKey          "+endOnKey
  };
  
  saveStrings("data/config.txt", data);
  println("Done.");
}

static class Compare {
  String value;
  String rest;
  Compare(String in) {
    value = in;
    rest = value;
  }
  boolean startsWith(String s) {
    //println("\""+value+"\".startsWith(\""+s+"\")");
    if (value.length() >= s.length()) {
      rest = trim(value.substring(s.length()));
      //println("\""+s+"\" == \""+value.substring(0, s.length())+"\"   ("+(s.equals(value.substring(0, s.length())))+")");
      //println("rest = "+rest+"\n");
      return (s.equals(value.substring(0, s.length())));
    } else {
      rest = null;
      //println("rest = "+rest+"\n");
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

void checkUpdate() {
  String updateCheckUrl = "http://darnok2221.no-ip.biz/matrix/updateInfo.json";
  
  println("Checking for updates...");
  String[] test = loadStrings(updateCheckUrl);
  if (test == null) {
    println("Unable to fetch update info!");
  } else {
    JSONObject updateInfo = loadJSONObject(updateCheckUrl);
    int latestVersion = updateInfo.getInt("version");
    String updateMessage = updateInfo.getString("message");
    updateMessage = updateMessage.replace("%currentVersion%", str(version));
    updateMessage = updateMessage.replace("%key%", downloadKey.toUpperCase());
    String downloadUrl = updateInfo.getString("url");
    if (latestVersion == version) {
      println("You are running the latest version.");
    } else {
      println(updateMessage);
      humanReadableChars = splitChars(updateMessage);
      particles[0].makeHumanReadable();
      downloadLink = downloadUrl;
    }
  }
}

char[] splitChars(String in) {
  char[] out = new char[in.length()];
  for (int i = 0; i < out.length; i++) {
    out[i] = in.charAt(i);
  }
  return out;
}

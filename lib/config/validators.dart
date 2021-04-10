class StringValidators {
  ///Checks if a string is a valid youtube url =
  static String isValidYoutubeURL(String url) {
    if (!url.contains("youtube.com")) {
      return 'Please enter a valid youtube url';
    } else {
      return null;
    }
  }

  ///Cheks if string is not null or empty
  static String isNotNullorEmpty(String string) {
    if (string.isEmpty || string == null) {
      return 'This field cannot be empty';
    } else {
      return null;
    }
  }
}

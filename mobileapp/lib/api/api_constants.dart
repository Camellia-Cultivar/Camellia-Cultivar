class APIConstants {
  static String baseUrl = "http://localhost:8085/api";
  static String quizEndpoint = "/quizzes";
  static String loginEndpoint = "/users/login";
  static String registerEndpoint = "/users/signup";
  static String profileEndpoint = "/users";
  static String editProfileEndpoint = "/users";
  static String cultivarEdpoint = "/public/cultivars";
  static String uploadedSpecimensEndpoint =
      "/requests/identification"; /*doing*/
  static String recentlyUploadedSpecimensEndpoint = "/public/specimen/recent";
  static String mapSpecimensEndpoint = "/public/specimen/reference";
  static String upovCharacteristicsEndpoint = "/public/upov";
  static String createSpecimenEndpoint = "/requests/identification";
  static String autocompleteEndpoint = "/public/autocomplete";
}

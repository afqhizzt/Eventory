class API {
  static const hostConnect = "http://192.168.56.1/api_eventory";
  static const hostConnectStudents = "$hostConnect/students";

  //sigup student
  static const signUp = "$hostConnect/students/signup.php";
  static const validateEmail = "$hostConnect/students/validate_email.php";
  static const login = "$hostConnect/students/login.php";
  static const post = "$hostConnect/students/post.php";
  static const events = "$hostConnect/clubs/events.php";
  static const createPost = "$hostConnect/clubs/create_post.php";
}

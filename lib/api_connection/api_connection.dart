class API {
  static const hostConnect = "http:// 192.168.56.1/api_eventory";
  static const hostConnectStudents = "$hostConnect/students";

  //student
  static const signUp = "$hostConnect/students/signup.php";
  static const validateEmail = "$hostConnect/students/validate_email.php";
  static const login = "$hostConnect/students/login.php";
  static const post = "$hostConnect/students/post.php";
  static const registerEvent = "$hostConnect/students/register_event.php";

  //club
  static const signUpClub = "$hostConnect/clubs/signup.php";
  static const validateEmailClub = "$hostConnect/clubs/validate_email.php";
  static const loginClub = "$hostConnect/clubs/login.php";
  static const events = "$hostConnect/clubs/events.php";
  static const createPost = "$hostConnect/clubs/create_post.php";
  static const eventDetail = "$hostConnect/clubs/event_details.php";

  //HEP
  static const signUpHEP = "$hostConnect/hep/signup.php";
  static const validateEmailHEP = "$hostConnect/hep/validate_email.php";
  static const loginHEP = "$hostConnect/hep/login.php";
  static const eventStatus = "$hostConnect/hep/event_status.php";
  static const eventList = "$hostConnect/hep/event_list.php";
  static const getId = "$hostConnect/hep/get_id.php";
}

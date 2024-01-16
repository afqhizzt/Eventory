class API {
  static const hostConnect = "http://10.205.97.97/api_eventory";
  static const hostConnectStudents = "$hostConnect/students";

  //student
  static const signUp = "$hostConnect/students/signup.php";
  static const validateEmail = "$hostConnect/students/validate_email.php";
  static const login = "$hostConnect/students/login.php";
  static const post = "$hostConnect/students/post.php";
  static const registerEvent = "$hostConnect/students/register_event.php";
  static const StudentEditInfoPage =
      "$hostConnect/students/studentEditInfoPage.php";
  static const activities = "$hostConnect/students/add_activities.php";
  static const getFollowersCount =
      "$hostConnect/students/getFollowersCount.php";
  static const getFollowingCount =
      "$hostConnect/students/getFollowingCount.php";
  static const getPostCount = "$hostConnect/students/getPostsCount.php";
  static const feedback = "$hostConnect/students/save_feedback.php";

  //club
  static const signUpClub = "$hostConnect/clubs/signup.php";
  static const validateEmailClub = "$hostConnect/clubs/validate_email.php";
  static const loginClub = "$hostConnect/clubs/login.php";
  static const events = "$hostConnect/clubs/events.php";
  static const createPost = "$hostConnect/clubs/create_post.php";
  static const eventDetail = "$hostConnect/clubs/event_details.php";
  static const clubEditInfoPage = "$hostConnect/clubs/ClubEditInfoPage.php";

  //HEP
  static const signUpHEP = "$hostConnect/hep/signup.php";
  static const validateEmailHEP = "$hostConnect/hep/validate_email.php";
  static const loginHEP = "$hostConnect/hep/login.php";
  static const eventStatus = "$hostConnect/hep/event_status.php";
  static const eventList = "$hostConnect/hep/event_list.php";
  static const getId = "$hostConnect/hep/get_id.php";
  static const displayEvents = "$hostConnect/hep/display_events.php";
}

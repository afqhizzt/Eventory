import 'package:get/get.dart';
import 'student_preferences.dart';
import 'model.dart';

class CurrentUser extends GetxController {
  Rx<Userr> _currentUser = Userr(0, '', '', '', '', '').obs;

  Userr get user => _currentUser.value;

  // Use async/await for asynchronous operations
  Future<void> getUserInfo() async {
    // Use try/catch to handle potential exceptions
    try {
      // Retrieve user information from local storage
      Userr? getUserInfoFromLocalStorage =
          await RememberUserPrefs.readUserInfo();

      // Update the _currentUser value with the retrieved information
      if (getUserInfoFromLocalStorage != null) {
        _currentUser.value = getUserInfoFromLocalStorage;
      }
    } catch (error) {
      // Handle errors, log, or take appropriate action
      print('Error fetching user information: $error');
    }
  }
}

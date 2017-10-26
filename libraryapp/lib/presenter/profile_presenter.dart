import 'package:libraryapp/data/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
 * The contract is the interface between the view and the presenter.
 * Here, we couple together the view and the presenter, to listen
 * to events that occur in the view and take action.
 */
abstract class ProfileViewContract {
  void onLoadUserComplete(User user);
  void onLoadUserError();
  void saveUser(User user);
}

/*
 * The Profile presenter is used to couple the profile view
 * view to the local user profile data.
 * Couple things together here to store user data.
 */

class ProfilePresenter {
  ProfileViewContract _view;
  SharedPreferences _prefs;
  User user;

  ProfilePresenter(this._view) {
    //TODO: Store data and stuff.
  }

  loadUser() async {
    assert(_view != null);
    _prefs = await SharedPreferences.getInstance();
    String name = _prefs.getString(UserKey.name);
    String occupation = _prefs.getString(UserKey.occupation);
    String year = _prefs.getString(UserKey.year);
    String description = _prefs.getString(UserKey.description);
    List<String> eventThemes = _prefs.getStringList(UserKey.eventThemes);
    //TODO: Make the image file load somehow.
    //File imageFile = new Uri.file(_prefs.getString(UserKey.imageFile))}
  }
}
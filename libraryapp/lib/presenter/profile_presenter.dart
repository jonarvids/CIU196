import 'package:libraryapp/data/user_data.dart';

/*
 * The contract is the interface between the view and the presenter.
 * Here, we couple together the view and the presenter, to listen
 * to events that occur in the view and take action.
 */
abstract class ProfileViewContract {
  void onLoadProfileComplete(User user);
  void onLoadProfileError();
}

/*
 * The Profile presenter is used to couple the profile view
 * view to the local user profile data.
 * Couple things together here to store user data.
 */

class ProfilePresenter {
  ProfileViewContract _view;
  User user;

  ProfilePresenter(this._view) {
    //TODO: Store data and stuff.
  }
}
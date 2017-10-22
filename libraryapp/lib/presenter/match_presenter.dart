import 'package:libraryapp/data/event_data_mock.dart';
import 'package:libraryapp/data/event_data.dart';
import 'package:libraryapp/data/user_data.dart';

/*
 * The contract is the interface between the view and the presenter.
 * Here, we couple together the view and the presenter, to listen
 * to events that occur in the view and take action.
 */
abstract class MatchViewContract {
  void onLoadMatchedEventsComplete(List<EventItem> items);
  void onLoadMatchedEventsError();
}

/*
 * The 'Match' presenter is used to couple the 'tinder'
 * matching view to the events repository.
 * Couple things together here to decide what events to show the user
 * based on the user's preference.
 */

class MatchPresenter {
  MatchViewContract _view;
  EventRepository _repository;
  User user;

  MatchPresenter(this._view) {
    _repository = new MockEventRepository();
  }
}
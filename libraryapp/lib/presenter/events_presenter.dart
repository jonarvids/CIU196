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
 * The 'Events' presenter is used to couple the following:
 * -Upcoming events
 * -Interested events
 * -Past events
 * -Created events
 * to the user.
 */

class MatchPresenter {
  MatchViewContract _view;
  EventRepository _repository;
  User user;

  MatchPresenter(this._view) {
    _repository = new MockEventRepository();
  }

  //This is how the view will as for the user's matches.
  void loadMatches(){
    assert(_view != null);

    _repository.fetch()
        .then((events) => _view.onLoadMatchedEventsComplete(events))
        .catchError((onError) {
      print(onError);
      _view.onLoadMatchedEventsError();
    });
  }
}
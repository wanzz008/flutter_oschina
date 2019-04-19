import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class LoginEvent{}
class LogoutEvent{}

//eventBus是通过Dart Streams来实现的，那么我们可以通过对Dart Stream的控制，来实现对eventBus的控制

//StreamSubscription subscription = eventBus.on<UserLoggedInEvent>().listen((event) {
//  print(event.user);
//});
//subscription.resume();  //  开
//subscription.pause();    //  暂停
//subscription.cancel();   //  取消
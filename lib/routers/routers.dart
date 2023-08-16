import 'package:fluro/fluro.dart';
import 'package:scanner/calculator/calculator_home.dart';
import 'package:scanner/email_sender/email_sender_home.dart';
import 'package:scanner/routers/route_init.dart';

import '../homepage.dart';

class Routers {
  static const String home = '/';
  static const String calculator = '/calculator';
  static const String email_sender = '/email_sender';
  static final List<IRouterProvider> _routers = [];
  static void configureRoutes(FluroRouter router) {
    // router.notFoundHandler = notFoundHandler;
    router.define(home,
        handler: Handler(handlerFunc: (_, params) => Homepage()));
    router.define(calculator,
        handler: Handler(handlerFunc: (_, params) => CalculatorHome()));
    router.define(email_sender, handler: Handler(handlerFunc: (_, params) {
      return Email_Sender_Home();
    }));
    _routers.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}

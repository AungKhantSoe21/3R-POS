import 'package:r_pos/screens/home_screen.dart';
import 'package:r_pos/screens/splash_screen.dart';

getRoutes() {
  return {
    SplashScreen.route: (context) => const SplashScreen(),
    HomeScreen.route: (context) => const HomeScreen(),
  };
}
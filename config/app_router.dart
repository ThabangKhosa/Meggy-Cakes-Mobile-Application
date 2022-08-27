import 'package:flutter/material.dart';
import 'package:meggycakes/models/category_models.dart';
import 'package:meggycakes/models/models.dart';
import 'package:meggycakes/screens/complete_profile/complete_profile_screen.dart';
import 'package:meggycakes/screens/contact/contact_screen.dart';
import 'package:meggycakes/screens/delivery/delivery_screen.dart';
import 'package:meggycakes/screens/forgot_password/forgot_password_screen.dart';
import 'package:meggycakes/screens/login_success/login_success_screen.dart';
import 'package:meggycakes/screens/order_confirmation/order_confirmation_screen.dart';
import 'package:meggycakes/screens/otp/otp_screen.dart';
import 'package:meggycakes/screens/payment_selection/payment_selection_screen.dart';
import 'package:meggycakes/screens/profile/profile_screen.dart';
import 'package:meggycakes/screens/register/register.dart';
import 'package:meggycakes/screens/sign_in/sign_in_screen.dart';
import 'package:meggycakes/screens/sign_up/sign_up_screen.dart';
import 'package:meggycakes/screens/splash/spalsh_screen.dart';
import 'package:meggycakes/screens/splash/splash_screen2.dart';
import 'package:meggycakes/screens/splash/splash_screen3.dart';
import 'package:meggycakes/screens/splash2/splash_screen.dart';
import '../screens/screens.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    // ignore: avoid_print
    print('This is route: ${settings.name}');

    switch (settings.name) {
      case '/home':
        return HomeScreen.route();
      // ignore: no_duplicate_case_values
      case HomeScreen.routeName:
        return HomeScreen.route();

      case SplashScreenOne.routeName:
        return SplashScreenOne.route();

      case SplashScreen.routeName:
        return SplashScreen.route();

      case SplashScreen2.routeName:
        return SplashScreen2.route();

      case SplashScreen3.routeName:
        return SplashScreen3.route();

      case CartScreen.routeName:
        return CartScreen.route();

      case CatalogScreen.routeName:
        return CatalogScreen.route(category: settings.arguments as Category);

      case ContactScreen.routeName:
        return ContactScreen.route();

      case DeliveryScreen.routeName:
        return DeliveryScreen.route();

      // ignore: no_duplicate_case_values
      case ProductScreen.routeName:
        return ProductScreen.route(product: settings.arguments as Product);

      case ProfileScreen.routeName:
        return ProfileScreen.route();

      case WishlistScreen.routeName:
        return WishlistScreen.route();

      case CheckoutScreen.routeName:
        return CheckoutScreen.route();

      case OrderConfirmation.routeName:
        return OrderConfirmation.route();

      case PaymentSelection.routeName:
        return PaymentSelection.route();

      case SignInScreen.routeName:
        return SignInScreen.route();

      case ForgotPasswordScreen.routeName:
        return ForgotPasswordScreen.route();

      case LoginSuccessScreen.routeName:
        return LoginSuccessScreen.route();

      case SignUpScreen.routeName:
        return SignUpScreen.route();

      case OtpScreen.routeName:
        return OtpScreen.route();

      case CompleteProfileScreen.routeName:
        return CompleteProfileScreen.route();

      case MyRegister.routeName:
        return MyRegister.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
          appBar: AppBar(
        title: const Text('Error'),
      )),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pro_mobile/app/core/di/service_locator.dart';
import 'package:pro_mobile/app/core/integrations/firebase_service.dart';
import 'package:pro_mobile/app/core/integrations/local_notification_service.dart';
import 'package:pro_mobile/app/routes/app_router.dart';
import 'package:pro_mobile/providers/goal_provider.dart';
import 'package:pro_mobile/providers/notification_provider.dart';
import 'package:pro_mobile/providers/user_provider.dart';
import 'package:pro_mobile/ui/onboarding_screen/onboarding_screens.dart';
import 'package:pro_mobile/ui/onboarding_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpServiceLocator();
  await Firebase.initializeApp();

  // background handler
  FirebaseMessaging.onBackgroundMessage(
    FirebaseService().firebaseMessagingBackgroundHandler,
  );

  // init once
  await LocalNotificationService().init();
  await FirebaseService().listenForNotification();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => GoalProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProCircle',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(userProvider: userProvider),
      initialRoute: AppRouter.onboarding,
      routes: AppRouter().generateRoutes(context),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: OnboardingScreen());
  }
}

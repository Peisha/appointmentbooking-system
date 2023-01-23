import 'package:chatapp/pages/home_page.dart';
import 'package:chatapp/responsive/doctor_drawer.dart';
import 'package:chatapp/responsive/patient_drawer.dart';
import 'package:chatapp/screens/AddCategory.dart';
import 'package:chatapp/screens/AddDoctor.dart';
import 'package:chatapp/screens/AddDonation.dart';
import 'package:chatapp/screens/AddLabTest.dart';
import 'package:chatapp/screens/AddScedule.dart';
import 'package:chatapp/screens/Admin_Screen.dart';
import 'package:chatapp/screens/AllAppointment.dart';
import 'package:chatapp/screens/AllDoctor.dart';
import 'package:chatapp/screens/AllPatient.dart';
import 'package:chatapp/screens/AllTest.dart';
import 'package:chatapp/screens/DoctorAppointment.dart';
import 'package:chatapp/screens/Donations.dart';
import 'package:chatapp/screens/ListofCat.dart';
import 'package:chatapp/screens/Profile_Screen.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:chatapp/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/screens/welcome_screen.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:chatapp/screens/registration_screen.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:chatapp/providers/user_provider.dart';
import 'package:chatapp/responsive/mobile_screen_layout.dart';
import 'package:chatapp/responsive/responsive_layout.dart';
import 'package:chatapp/responsive/web_screen_layout.dart';
import 'package:chatapp/responsive/navigation_drawer.dart';
import 'package:chatapp/screens/AllCategory.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: OnboardingScreen.id,
      routes: {
        WelcomeScreen.id: (contenxt) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        Admin_Screen.id: (context) => Admin_Screen(),
        Profile_Screen.id: (context) => const Profile_Screen(),
        DrawerNavigation.id: (context) => DrawerNavigation(),
        AllPatient.id: (context) => AllPatient(
            usertype: ModalRoute.of(context)!.settings.arguments as String),
        AllDoctor.id: (context) => AllDoctor(
            usertype: ModalRoute.of(context)!.settings.arguments as String),
        AllCategory.id: (context) => AllCategory(),
        AddCategory.id: (context) => const AddCategory(),
        AddDoctor.id: (context) => AddDoctor(
              desc: ModalRoute.of(context)!.settings.arguments as dynamic,
            ),
        ListofCat.id: (context) => ListofCat(),
        HomePage.id: (context) => HomePage(),
        PatientNavigation.id: (context) => PatientNavigation(),
        OnboardingScreen.id: (context) => const OnboardingScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        AddScedule.id: (context) => AddScedule(
            category: ModalRoute.of(context)!.settings.arguments as dynamic),
        AllAppointment.id: (context) => AllAppointment(),
        DoctorAppointment.id: (context) => DoctorAppointment(),
        DoctorNavigation.id: (context) => DoctorNavigation(),
        Donation.id: (context) => Donation(),
        AddDonation.id: (context) => AddDonation(),
        AddLabTest.id: (context) => AddLabTest(
            emails: ModalRoute.of(context)!.settings.arguments as dynamic),
        AllTest.id: (context) => AllTest()
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (contenxt) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          ChatScreen.id: (context) => ChatScreen(),
          Admin_Screen.id: (context) => Admin_Screen(),
          Profile_Screen.id: (context) => Profile_Screen(),
          DrawerNavigation.id: (context) => DrawerNavigation(),
          AllPatient.id: (context) => AllPatient(
              usertype: ModalRoute.of(context)!.settings.arguments as String),
          AllDoctor.id: (context) => AllDoctor(
              usertype: ModalRoute.of(context)!.settings.arguments as String),
          AllCategory.id: (context) => AllCategory(),
          AddCategory.id: (context) => const AddCategory(),
          AllAppointment.id: (context) => AllAppointment()
        },
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        // theme: ThemeData.dark().copyWith(
        //   scaffoldBackgroundColor: mobileBackgroundColor,
        // ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return WelcomeScreen();
          },
        ),
      ),
    );
  }
}

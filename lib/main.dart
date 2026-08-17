

import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:studypress_new/services/notification_services.dart';
import 'package:studypress_new/views/pages/assessment_test_page.dart';
import 'package:studypress_new/views/pages/chapter_details_page.dart';
import 'package:studypress_new/views/pages/chapters_page.dart';
import 'package:studypress_new/views/pages/contact_us_page.dart';
import 'package:studypress_new/views/pages/course_details_page.dart';
import 'package:studypress_new/views/pages/current_affairs_page.dart';
import 'package:studypress_new/views/pages/enrollment_list_page.dart';
import 'package:studypress_new/views/pages/home_page.dart';
import 'package:studypress_new/views/pages/live_test_list_page.dart';
import 'package:studypress_new/views/pages/login_page.dart';
import 'package:studypress_new/views/pages/mcq_report_page.dart';
import 'package:studypress_new/views/pages/mcq_test_page.dart';
import 'package:studypress_new/views/pages/membership_plan_page.dart';
import 'package:studypress_new/views/pages/merit_list_page.dart';
import 'package:studypress_new/views/pages/mistake_review_list_item_page.dart';
import 'package:studypress_new/views/pages/model_test_list_page.dart';
import 'package:studypress_new/views/pages/model_test_result_list_page.dart';
import 'package:studypress_new/views/pages/my_subscriptions_page.dart';
import 'package:studypress_new/views/pages/otp_page.dart';
import 'package:studypress_new/views/pages/practise_page.dart';
import 'package:studypress_new/views/pages/quiz_result_list_page.dart';
import 'package:studypress_new/views/pages/registration_page.dart';
import 'package:studypress_new/views/pages/reset_password_page.dart';
import 'package:studypress_new/views/pages/ssl_commerz_page.dart';
import 'package:studypress_new/views/pages/subject_list_page.dart';
import 'package:studypress_new/views/pages/user_profile_page.dart';
import 'package:studypress_new/views/pages/vocabulary_app_page.dart';
import 'package:studypress_new/views/pages/vocabulary_practise_page.dart';
import 'package:studypress_new/views/screens/splash_screen.dart';
import 'constraints/app_colors.dart';
import 'controllers/iap_service_controller.dart';

void main() async{


  WidgetsFlutterBinding.ensureInitialized();
  Get.put(IAPService(), permanent: true);
  await Firebase.initializeApp(
   // name: "StudyPress", // Consider removing this if you don't need a named instance
    options: (Platform.isIOS || Platform.isMacOS)
        ? FirebaseOptions(
      apiKey: 'AIzaSyCjJAS74AQ3lUBorCz_VUmw-j4l_nEeUDM',
      appId: '1:979357280789:ios:9986432c5a6246a9317c1c',
      messagingSenderId: '979357280789',
      projectId: 'studypress-83bdf',
      storageBucket: 'studypress-83bdf.firebasestorage.app',
      //iosClientId: '154691716657-b89ulbosoh2h27fn00eeo2su7o2iv3e6.apps.googleusercontent.com',
      iosBundleId: 'org.studypress.learn',
    )
        :FirebaseOptions(
      apiKey: 'AIzaSyDOoUmCh0FStJT1vdDw8cWFZDyCJ746hj0',
      appId: '1:154691716657:android:811fba872f6ae36c58b710',
      messagingSenderId: '154691716657',
      projectId: 'studypress-87af8',
      storageBucket: 'studypress-87af8.firebasestorage.app',
    )
  );


  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.appPrimaryColor, // navigation bar color
      statusBarColor: AppColors.appPrimaryColor, // status bar color
      statusBarIconBrightness: Brightness.light,   // Only honored in Android M and above
      statusBarBrightness: Brightness.light,      // Only honored in iOS
    ),
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessagingHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key}) ;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  FirebaseMessaging messaging=FirebaseMessaging.instance;
  NotificationServices notificationServices=NotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messaging.subscribeToTopic("general_push_notification");
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit();
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print("FCM token: $value");
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(384, 784),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
              title: 'StudyPress',
              debugShowCheckedModeBanner: false,
              getPages: [
                // Hone Page
                GetPage(
                  name: '/home_page',
                  page: () => HomePage(),
                ),
                GetPage(
                  name: '/registration_page',
                  page: () => RegistrationPage(),
                ),
                GetPage(
                  name: '/login_email_page',
                  page: () => LoginPage(),
                ),
                GetPage(
                  name: '/enrollment_list_page',
                  page: () => EnrollmentListPage(),
                ),
                GetPage(
                  name: '/member_ship_page',
                  page: () => const MemberShipPlanPage(),
                ),
                GetPage(
                  name: '/subject_list_page',
                  page: () => SubjectListPage(),
                ),
                GetPage(
                  name: '/chapters_page',
                  page: () => const ChaptersPage(),
                ),
                GetPage(
                  name: '/chapter_details_page',
                  page: () => ChapterDetailsPage(),
                ),
                GetPage(
                  name: '/practise_page',
                  page: () => const PractiseChapterPage(),
                ),
                GetPage(
                  name: '/my_subscriptions_page',
                  page: () => MySubscriptionsPage(),
                ),
                GetPage(
                  name: '/mcq_test_page',
                  page: () => MCQTestPage(),
                ),
                GetPage(
                  name: '/mcq_report_page',
                  page: () => MCQReportPage(),
                ),
                GetPage(
                  name: '/current_affairs_page',
                  page: () => CurrentAffairsPage(),
                ),
                GetPage(
                  name: '/model_test_list_page',
                  page: () => ModelTestListPage(),
                ),

                GetPage(
                  name: '/result_list_page',
                  page: () => QuizResultListPage(),
                ),
                GetPage(
                  name: '/model_test_result_list_page',
                  page: () => ModelTestResultListPage(),
                ),

                GetPage(
                  name: '/basic_list_items_page',
                  page: () => MistakeAndReviewListItemPage(),
                ),

                GetPage(
                  name: '/merit_list_page',
                  page: () => MeritListPage(),
                ),
                GetPage(
                  name: '/vocabulary_app_page',
                  page: () => VocabularyAppPage(),
                ),

                GetPage(
                  name: '/vocabulary_practice_page',
                  page: () => VocabularyPractisePage(),
                ),
                GetPage(
                  name: '/assessment_test_page',
                  page: () => AssessmentTestPage(),
                ),
                GetPage(
                  name: '/user_profile_page',
                  page: () => UserProfilePage(),
                ),

                GetPage(
                  name: '/splash_screen',
                  page: () => SplashScreen(),
                ),

                GetPage(
                  name: '/assessment_test_page',
                  page: () => AssessmentTestPage(),
                ),
                GetPage(
                  name: '/course_details_page',
                  page: () => CourseDetailsPage(),
                ),
                GetPage(
                  name: '/live_test_list_page',
                  page: () => LiveTestListPage(),
                ),

                GetPage(
                  name: '/contact_us_page',
                  page: () => ContactUsPage(),
                ),
                GetPage(
                  name: '/ssl_commerz_page',
                  page: () => SSLCommerzPage(),
                ),
                GetPage(
                  name: '/otp_page',
                  page: () => OtpPage(),
                ),
                GetPage(
                  name: '/reset_password_page',
                  page: () => ResetPasswordPage(),
                ),
              ],
          home: SplashScreen(),
              builder: (context, widget) {
            widget = EasyLoading.init()(context, widget);
            return widget;
          },
          );
        });
  }
}
@pragma('vm:entry-point')
Future<void>_firebaseBackgroundMessagingHandler(RemoteMessage message)async{
  await Firebase.initializeApp(
      options: (Platform.isIOS || Platform.isMacOS)
          ? FirebaseOptions(
        apiKey: 'AIzaSyCA9SNLiFyc7PR64xx_L8Rkdi6RCKEkPGM',
        appId: '1:154691716657:ios:1a14c03d288e38af58b710',
        messagingSenderId: '154691716657',
        projectId: 'studypress-87af8',
        storageBucket: 'studypress-87af8.firebasestorage.app',
        iosClientId: '154691716657-b89ulbosoh2h27fn00eeo2su7o2iv3e6.apps.googleusercontent.com',
        iosBundleId: 'com.revinr.studyPressApp',
      )
          :FirebaseOptions(
        apiKey: 'AIzaSyDOoUmCh0FStJT1vdDw8cWFZDyCJ746hj0',
        appId: '1:154691716657:android:811fba872f6ae36c58b710',
        messagingSenderId: '154691716657',
        projectId: 'studypress-87af8',
        storageBucket: 'studypress-87af8.firebasestorage.app',
      )
  );
  if (kDebugMode) {
    print(message.notification?.title.toString());
  }
}
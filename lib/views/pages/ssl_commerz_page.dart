/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../../constraints/app_colors.dart';
import '../../constraints/header_text.dart';
import '../../controllers/my_subscription_controller.dart';
import '../screens/loading_screen.dart';

class SSLCommerzPage extends StatelessWidget {
  String url = Get.arguments[0];
  var total = Get.arguments[1];

  SSLCommerzPage({Key? key}) : super(key: key);
  late WebViewController _webViewController;

  final MySubscriptionController controller =
      Get.put(MySubscriptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: AppColors.appHeaderTextColor),
        title: HeaderText(
          text: "Payment",
          color: Colors.white,
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              gestureNavigationEnabled: true,
              onWebViewCreated: (WebViewController webViewController) {
                _webViewController = webViewController;
                _webViewController.clearCache();
              },
              onPageFinished: (_) async {
                //_webViewController.runJavascriptReturningResult(javaScriptString)

                _webViewController.currentUrl().then(
                  (url) {
                    if (url!.contains("cancel")) {
                      Get.back();
                      // print(msg);
                    }
                  },
                );
                //_webViewController.runJavascript("javascript:clickPayButton()");
              },
              javascriptChannels: <JavascriptChannel>{
                JavascriptChannel(
                    name: 'MessageInvoker',
                    onMessageReceived: (s) async {
                      var data=json.decode(s.message);



                      if (s.message.contains("order_id")) {
                        //Get.offAllNamed("/home_page");

                        controller.isUpdating.value=true;
                        controller.getSubscriptionDetails(orderId: data["order_id"]);
                      }
                      if (s.message.contains("Failed")) {
                        Get.back();
                      }
                    }),
              },
            ),
            if(controller.isUpdating.value)const LoadingScreen()
          ],
        ),
      ),
    );
  }



// Future<void> readJS() async {}
}
*/

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constraints/app_colors.dart';
import '../../constraints/header_text.dart';
import '../../controllers/my_subscription_controller.dart';
import '../screens/loading_screen.dart';

class SSLCommerzPage extends StatelessWidget {
  final String url = Get.arguments[0];
  final total = Get.arguments[1];

  SSLCommerzPage({super.key});

  final MySubscriptionController controller = Get.put(
    MySubscriptionController(),
  );

  final WebViewController webViewController = WebViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: AppColors.appHeaderTextColor),
        title: HeaderText(text: "Payment", color: AppColors.appHeaderTextColor),
      ),
      body: Obx(
        () => Stack(
          children: [
            WebViewWidget(
              controller: webViewController
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..addJavaScriptChannel(
                  'MessageInvoker',
                  onMessageReceived: (JavaScriptMessage message) async {
                    final data = json.decode(message.message);
                    if (message.message.contains("order_id")) {
                      controller.isUpdating.value = true;
                      controller.getSubscriptionDetails(
                        orderId: data["order_id"],
                      );
                    }
                    if (message.message.contains("Failed")) {
                      Get.back();
                    }
                  },
                )
                ..setNavigationDelegate(
                  NavigationDelegate(
                    onPageFinished: (String url) async {
                      final currentUrl = await webViewController.currentUrl();
                      if (currentUrl != null && currentUrl.contains("cancel")) {
                        Get.back();
                      }
                    },
                  ),
                )
                ..loadRequest(Uri.parse(url)),
            ),
            if (controller.isUpdating.value) const LoadingScreen(),
          ],
        ),
      ),
    );
  }
}

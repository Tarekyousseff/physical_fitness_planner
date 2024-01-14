// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

Future<void> _launchUrl(String url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

void startWebView(BuildContext context, String url, String title) async {
  // Launch ERP on Android (Webview)
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        // onNavigationRequest: (NavigationRequest request) {
        //   if (request.url.startsWith('${context.read<PreferencesProvider>().apiUrl}/')) {
        //     return NavigationDecision.navigate;
        //   }
        //   return NavigationDecision.prevent;
        // },
      ),
    )
    ..loadRequest(Uri.parse(url));

  // show webview
  // open a new screen
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text(title),
            centerTitle: true,
          ),
          body: WebViewWidget(controller: controller)),
    ),
  );

  return;
}

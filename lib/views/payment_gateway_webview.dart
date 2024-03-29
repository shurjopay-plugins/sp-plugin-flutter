import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class PaymentGatewayWebview extends StatefulWidget {
  final String checkoutURL;
  final String returnURL;
  final String cancelURL;

  const PaymentGatewayWebview({
    super.key,
    required this.checkoutURL,
    required this.returnURL,
    required this.cancelURL,
  });

  @override
  State<PaymentGatewayWebview> createState() => _PaymentGatewayWebviewState();
}

class _PaymentGatewayWebviewState extends State<PaymentGatewayWebview> {
  late PlatformWebViewControllerCreationParams params;
  late WebViewController webViewController;

  String? currentUrl;
  int progress = 0;
  bool firstLaunchDone = false;

  @override
  Widget build(BuildContext context) {
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else if (WebViewPlatform.instance is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (webViewController.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    webViewController = WebViewController.fromPlatformCreationParams(params);
    return WillPopScope(
      onWillPop: () async {
        if (currentUrl != null &&
            currentUrl!.contains(widget.returnURL) &&
            currentUrl!.contains("order_id")) {
          Navigator.pop(context, true);
        } else {
          Navigator.pop(context, false);
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: const Text(
            "shurjoPay",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
           /* WebView(
              initialUrl: widget.checkoutURL,
              javascriptMode: JavascriptMode.unrestricted,
              onProgress: ((prog) {
                if (firstLaunchDone != true) {
                  setState(() {
                    progress = prog;
                  });
                }
                if (prog == 100) {
                  firstLaunchDone = true;
                }
              }),
              navigationDelegate: (navigation) {
                // print("URL==");
                // print(navigation.url);
                if (navigation.url.contains(widget.returnURL) &&
                    navigation.url.contains('order_id')) {
                  currentUrl = navigation.url;
                  Navigator.pop(context, true);
                  return NavigationDecision.prevent;
                } else if (navigation.url.contains(widget.cancelURL)) {
                  Navigator.pop(context, false);
                  return NavigationDecision.prevent;
                } else {
                  return NavigationDecision.navigate;
                }
              },
              onWebViewCreated: (controller) => webViewController = controller,
              // onPageStarted: (String? url) {
              //   print("URL");
              //   print(url);
              //   currentUrl = url;
              //   if (url != null &&
              //       url.contains(widget.returnURL) &&
              //       url.contains("order_id")) {
              //     Navigator.pop(context, true);
              //   } else if (url != null && url.contains(widget.cancelURL)) {
              //     Navigator.pop(context, false);
              //   }
              // },
            ),*/
            WebViewWidget(
              controller: webViewController
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setNavigationDelegate(
                  NavigationDelegate(
                    onProgress: (int prog) {
                      if (firstLaunchDone != true) {
                        setState(() {
                          progress = prog;
                        });
                      }
                      if (prog == 100) {
                        firstLaunchDone = true;
                      }
                    },
                    onNavigationRequest: (NavigationRequest navigation) {
                      /*print("URL==");
                      print(navigation.url);*/
                      if (navigation.url.contains(widget.returnURL) &&
                          navigation.url.contains('order_id')) {
                        currentUrl = navigation.url;
                        Navigator.pop(context, true);
                        return NavigationDecision.prevent;
                      } else if (navigation.url.contains(widget.cancelURL)) {
                        Navigator.pop(context, false);
                        return NavigationDecision.prevent;
                      } else {
                        return NavigationDecision.navigate;
                      }
                    },
                  ),
                )
                ..loadRequest(Uri.parse(widget.checkoutURL)),
            ),
            progress == 100
                ? const SizedBox.shrink()
                : Text(
                    'Loading $progress%',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

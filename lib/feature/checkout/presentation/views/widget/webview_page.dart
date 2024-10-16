import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/feature/checkout/presentation/views/failed_checkout_page.dart';
import 'package:sahab_project/feature/checkout/presentation/views/success_checkout_page.dart';
// Import for Android features.
// Import for iOS features.
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../generated/l10n.dart';

// import 'dart:async';

class WebViewScreen extends StatefulWidget {
  final String url;
  final TypeToggle typeToggle;
  final String categoryTitle;
  final String? address;
  const WebViewScreen(
      {super.key,
      required this.url,
      required this.typeToggle,
      required this.categoryTitle,
      this.address});

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  // final flutterWebviewPlugin = new FlutterWebviewPlugin();
  // bool showButton = false;
  // bool showFailButton = false;
  // List<String> result = [];
  // String url = "";

  // int id = 0;
  // TextEditingController test = TextEditingController();
  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();
  WebViewController? controller;
  @override
  void initState() {
    // final cart = BlocProvider.of<ShowCartCubit>(context).cart;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            // print("onProgress **************************************");
          },
          onUrlChange: (change) {
            // print("onUrlChange **************************************");
            if (kDebugMode) {
              print(
                  "${change.url} ..................................//////.............................");
            }
            String? url2 = change.url;
            Uri url = Uri.parse(change.url!);
            print("webView url: $url");
            // print(url.queryParameters["IsSuccess"]);
            // if (change.url?.contains("true") ?? false) {
            if (url.queryParameters["IsSuccess"] == "true") {
              // Uri url = Uri.parse(change.url!);
              Map<String, dynamic> queryParams = url.queryParameters;
              // String invoiceId = queryParams['Data[InvoiceId]'];
              // print("invoid id isc: $invoiceId");
              String bookingId = queryParams['bookingId'];
              print("booking id : $bookingId");
              String status = queryParams['status'];
              print("status : $status");
              String category = queryParams['category'];
              print("category : $category");
              String amount = queryParams['amount'];
              print("amount : $amount");
              String name = queryParams['name'];
              print("name : $name");
              String phone = queryParams['phone'];
              print("phone : $phone");
              String start = queryParams['start'];
              print("start : $start");
              String end = queryParams['end'];
              print("end : $end");
              String method = queryParams['method'];
              print("method : $method");
              String transaction_id = queryParams['transaction_id'];
              print("transaction_id : $transaction_id");
              String reference_id = queryParams['reference_id'];
              print("reference_id : $reference_id");
              String invoice_reference = queryParams['invoice_reference'];
              print("invoice_reference : $invoice_reference");
              String discount = queryParams['discount'];
              print("discount : $discount");
              String total = queryParams['total'];
              print("total : $total");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SuccessCheckoutPage(
                    typeToggle: widget.typeToggle,
                    categoryTitle: widget.categoryTitle,
                    amount: num.tryParse(amount),
                    paymentMethod: method,
                    referenceId: reference_id,
                    total: total,
                    transactionId: transaction_id,
                    discount: discount,
                    id: int.tryParse(bookingId),
                    name: name,
                    phone: phone,
                    startDate: start,
                    address: widget.address,
                    endDate: end,
                    invoiceReference: invoice_reference,
                    status: status,
                  ),
                ),
              );
              // String invoiceStatus = queryParams['Data[InvoiceStatus]'];
              // print("invoiceStatus : $invoiceStatus");
              // String invoiceReference = queryParams['Data[InvoiceReference]'];
              // print("invoiceReference : $invoiceReference");
              // //? booking id
              // //? -------------
              // String createdDate = queryParams['Data[CreatedDate]'];
              // print("createdDate: $createdDate");
              // String expiryDate = queryParams['Data[ExpiryDate]'];
              // print("expiryDate: $expiryDate");
              // String invoiceValue = queryParams['Data[InvoiceValue]'];
              // print("invoiceValue: $invoiceValue");
              // String customerName = queryParams['Data[CustomerName]'];
              // print("customerName: $customerName");
              // String customerMobile = queryParams['Data[CustomerMobile]'];
              // print("customerMobile: $customerMobile");
              // String customerEmail = queryParams['Data[customerEmail]'];
              // print("customerEmail: $customerEmail");
              // //? booking price
              // String invoiceDisplayValue =
              //     queryParams['Data[InvoiceDisplayValue]'];
              // print("invoiceDisplayValue: $invoiceDisplayValue");
              // //? -------------
              // // String invoiceTransactions =
              // //     queryParams['Data[InvoiceTransactions]'];
              // String paymentGateway =
              //     queryParams['Data[InvoiceTransactions[PaymentGateway]]'];
              // print("PaymentGateway : $paymentGateway");
              // String transactionId =
              //     queryParams['Data[InvoiceTransactions[TransactionId]]'];
              // print("transactionId : $transactionId");
              /*
              print(
                  "${url.queryParameters["IsSuccess"]} 554546456453454 546464 6465454 4565645 ");
              print(url.queryParameters['order_id'].toString());

              var payment_refrence =
                  int.parse(url.queryParameters['payment_refrence'].toString());
              print(payment_refrence);
              var date = url.queryParameters['date'].toString();
              print(date);
              var transaction_id =
                  url.queryParameters['transaction_id'].toString();
              print(transaction_id);
              var payment_method =
                  url.queryParameters['payment_method'].toString();
              print(payment_method);
              */
              print("allllllllllllllllllllll things done");
              // if (kDebugMode) {
              //   print(cart?.payment?.transactionId);
              //   print(url.queryParameters['transaction_id'].toString());
              //   print(cart?.paymentId);
              //   print(cart?.orderId);
              //   print(cart?.payment?.transactionType);
              //   print(cart?.payment?.date);
              // }

              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => OrderSuccessScreen(
              //               value: 1,
              //               restaurantName: watiOrderName(context, cart!),
              //             )));
            } else if (url.queryParameters["IsSuccess"] == "false") {
              print(change.url);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const FailedCheckoutPage(
                    isBeforeMyFatorah: true,
                  ),
                ),
              );
            }
          },
          onPageStarted: (String url) {
            // print("onPageStarted ************************");
          },
          onPageFinished: (String url) {
            // print("onPageFinished ************************");
          },
          onWebResourceError: (WebResourceError error) {
            print("errrror");
          },
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            print("errrooooooooooooooooooor");
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(widget.url),
      );
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  void dispose() {
    // flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: AppColor.white,
      //   title: Row(
      //     children: [
      //       icon(context, 'arrowback', () {
      //         Navigator.of(context).pop();
      //       }),
      //       const SizedBox(
      //         width: 15,
      //       ),
      //       Padding(
      //           padding: const EdgeInsets.only(left: 0, right: 0),
      //           child: textWidget('payment'.tr(context),
      //               color: ColorManager.font)),
      //     ],
      //   ),
      // ),

      body: Column(
        children: [
          CustomSimpleAppBarWidget(appBarTitle: S.of(context).checkout),
          Expanded(
            child: WebViewWidget(
              controller: controller!,
            ),
          ),
        ],
      ),
    );
  }
}

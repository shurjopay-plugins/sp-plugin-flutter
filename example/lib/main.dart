// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:pro_widgets/pro_widgets.dart';
import 'package:shurjopay/models/config.dart';
import 'package:shurjopay/models/payment_verification_model.dart';
import 'package:shurjopay/models/shurjopay_request_model.dart';
import 'package:shurjopay/models/shurjopay_response_model.dart';
import 'package:shurjopay/shurjopay.dart';
import 'package:shurjopay/utilities/functions.dart';

void main() {
  initializeShurjopay(environment: "sandbox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'shurjoPay Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ShurjoPay shurjoPay = ShurjoPay();

  ShurjopayConfigs shurjopayConfigs = ShurjopayConfigs(
    prefix: "sp",
    userName: "sp_sandbox",
    password: "pyyk97hu&6u6",
    clientIP: "127.0.0.1",
  );

  ShurjopayResponseModel shurjopayResponseModel = ShurjopayResponseModel();
  ShurjopayVerificationModel shurjopayVerificationModel =
      ShurjopayVerificationModel();

  TextEditingController nameFieldController = TextEditingController();
  TextEditingController amountFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('shurjoPay Demo'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProTextField(
                hint: "Enter Name",
                controller: nameFieldController,
                height: 45,
              ),
              const ProGap(y: 16),
              ProTextField(
                hint: "Enter Amount",
                controller: amountFieldController,
                height: 45,
              ),
              const ProGap(y: 16),
              ProButtonBasic(
                text: "Pay",
                fontSize: 18,
                backgroundColor: Colors.green,
                height: 45,
                width: double.infinity,
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  ShurjopayRequestModel shurjopayRequestModel =
                      ShurjopayRequestModel(
                    configs: shurjopayConfigs,
                    currency: "BDT",
                    amount: double.parse(amountFieldController.text),
                    orderID: "sp1ab2c3d4",
                    discountAmount: 0,
                    discountPercentage: 0,
                    customerName: nameFieldController.text,
                    customerPhoneNumber: "01711486915",
                    customerAddress: "customer address",
                    customerCity: "customer city",
                    customerPostcode: "1212",
                    returnURL: "https://www.sandbox.shurjopayment.com/response",
                    cancelURL: "https://www.engine.shurjopayment.com/response",
                  );
                  shurjopayResponseModel = await shurjoPay.makePayment(
                    context: context,
                    shurjopayRequestModel: shurjopayRequestModel,
                  );
                  if (shurjopayResponseModel.status == true) {
                    try {
                      shurjopayVerificationModel =
                          await shurjoPay.verifyPayment(
                        orderID: shurjopayResponseModel.shurjopayOrderID!,
                      );
                      if (shurjopayVerificationModel.spCode == "1000") {
                        print("Payment Varified");
                      }
                    } catch (error) {
                      print(error.toString());
                    }
                  }
                  nameFieldController.clear();
                  amountFieldController.clear();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: avoid_print

import 'package:example/widgets/payment_failed_screen.dart';
import 'package:example/widgets/payment_success_screen.dart';
import 'package:example/widgets/shurjo_button.dart';
import 'package:example/widgets/shurjopay_input_field.dart';
import 'package:flutter/material.dart';
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
      debugShowCheckedModeBanner: false,
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
    prefix: "NOK",
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/gif1.gif", height: size.height * 0.2, fit: BoxFit.cover),
                const SizedBox(height: 10),
                const Text("ShurjoPay Demo", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.green)),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: nameFieldController,
                  hintText: "Enter Name",
                  icon: Icons.person,
                  borderRadius: 30.0, // Rounded corners
                  activeColor: const Color.fromARGB(255, 44, 205, 49), // Custom active color
                  borderColor: Colors.grey,
                ),
                 const SizedBox(height: 15),
                CustomTextField(
                  controller: amountFieldController,
                  hintText: "Enter Amount",
                  icon: Icons.attach_money,
                  borderRadius: 30.0, // Rounded corners
                  activeColor: const Color.fromARGB(255, 44, 205, 49), // Custom active color
                  borderColor: Colors.grey,
                  keyboardType: TextInputType.number,
                ),
                 const SizedBox(height: 30),
                 CustomButton(
                  text: "PAY NOW",
                  onTap: ()async {
                    if(nameFieldController.text.isEmpty || amountFieldController.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please fill all the fields"))
                      );
                      return;
                    }
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
                      // Live: https://www.engine.shurjopayment.com/return_url
                      returnURL:
                          "https://www.sandbox.shurjopayment.com/return_url",
                      // Live: https://www.engine.shurjopayment.com/cancel_url
                      cancelURL:
                          "https://www.sandbox.shurjopayment.com/cancel_url",
                    );
                    shurjopayResponseModel = await shurjoPay.makePayment(
                      context: context,
                      shurjopayRequestModel: shurjopayRequestModel,
                    );
                    nameFieldController.clear();
                    amountFieldController.clear();
                    if (!context.mounted) return;

                    // Push a verifying screen immediately so the home screen
                    // never flashes between the webview closing and the result.
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        opaque: true,
                        pageBuilder: (_, __, ___) => const _VerifyingScreen(),
                        transitionDuration: Duration.zero,
                      ),
                    );

                    if (shurjopayResponseModel.status == true) {
                      try {
                        shurjopayVerificationModel =
                            await shurjoPay.verifyPayment(
                          orderID: shurjopayResponseModel.shurjopayOrderID!,
                        );
                        print(shurjopayVerificationModel.spCode);
                        print(shurjopayVerificationModel.spMessage);
                        if (!context.mounted) return;
                        if (shurjopayVerificationModel.spCode == "1000") {
                          print("Payment Verified");
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PaymentSuccessScreen(
                                verification: shurjopayVerificationModel,
                              ),
                            ),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PaymentFailedScreen(
                                response: shurjopayResponseModel,
                                verification: shurjopayVerificationModel,
                              ),
                            ),
                          );
                        }
                      } catch (error) {
                        print(error.toString());
                        if (!context.mounted) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PaymentFailedScreen(
                              response: shurjopayResponseModel,
                            ),
                          ),
                        );
                      }
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PaymentFailedScreen(
                            response: shurjopayResponseModel,
                          ),
                        ),
                      );
                    }
                  },
                  backgroundColor: Colors.green, // You can override the color
                  borderRadius: 30,              // You can change the shape
                ),
                  const SizedBox(height: 50),  
                Image.asset("assets/images/gif2.gif", height: size.height * 0.1, fit: BoxFit.contain)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VerifyingScreen extends StatelessWidget {
  const _VerifyingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Colors.green),
            SizedBox(height: 16),
            Text("Verifying payment...", style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

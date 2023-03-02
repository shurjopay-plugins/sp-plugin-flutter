## shurjoPay flutter package

This is the official **shurjoPay** flutter package for merchants or service providers to integrate our payment system with their Flutter applications. For now, it only supports **Android and iOS**.

**shurjoPay** flutter package makes the payment system easier for you with just two method calls:

- `makePayment()`
- `verifyPayment()`

And that's all! To know more about its usage please check the details below.

## Adding a package dependency to an app

1. Open the  ``dart pubspec.yaml ``` file located inside the app folder, and add ```dart shurjopay: ^2.0.3 ``` under dependencies.
2. Install it
   * From the terminal: Run ``dart flutter pub get ```.

## Usage

- First, you must initialize shurjoPay before using it by calling `initializeShurjopay()` and passing the environment type as a parameter.

  **Example:**

  ```dart
  void main() {
    initializeShurjopay(environment: "sandbox");
    runApp(const  MyApp());
  }
  ```

- After that, you can start using our package the way you want based on your application. Here we are providing a basic example code snip for you.

  **Example**

  ```dart
  //Create a shurjoPay object.
  ShurjoPay shurjoPay = ShurjoPay();

  //Create payment request model and initialize values.
  ShurjopayRequestModel shurjopayRequestModel = ShurjopayRequestModel(
    // Create ShurjopayConfigs object somewhere and set values in it, so that you can pass it here.
    configs: shurjopayConfigs,
    currency: "BDT",
    amount: 1000,
    //Remember to use prefix before order id. Ex: if prefix is 'test' then order id should be test123456
    orderID: "sp1ab2c3d4",
    discountAmount: 0,
    discountPercentage: 0,
    customerName: "Shajedul Islam",
    customerPhoneNumber: "01628734916",
    customerAddress: "customer address",
    customerCity: "customer city",
    customerPostcode: "1212",
    returnURL: "return_url",
    cancelURL: "cancel_url",
  );

  //Create a payment response model object to store the makePayment() method results.
  ShurjopayResponseModel shurjopayResponseModel = ShurjopayResponseModel();

  //Calling makePayment() method to initiate payment process.
  shurjopayResponseModel = await shurjoPay.makePayment(
    context: context,
    shurjopayRequestModel: shurjopayRequestModel,
  );

  //Create a verification response model object to store the verifyPayment() method results
  ShurjopayVerificationModel shurjopayVerificationModel = ShurjopayVerificationModel();

  //If the status is true from makePayment() method result then, verify the payment by calling verifyPayment() method whenever you want.
  if (shurjopayResponseModel.status == true) {
    try {
      shurjopayVerificationModel = await shurjoPay.verifyPayment(
        orderID: shurjopayResponseModel.shurjopayOrderID!,
      );
      if (shurjopayVerificationModel.spCode == "1000") {
        print("Payment Varified");
      }
    } catch (error) {
      print(error.toString());
    }
  }
  ```

<br>
That's all! Now you are ready to use our shurjoPay flutter package to make your payment system easy and smooth.

<br>
<br>
<center>Author - <a href ="https://shajedul.com">Shajedul Islam<a></center>

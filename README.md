## shurjoPay flutter package

This is the official **shurjoPay** flutter package for merchants or service providers to integrate our payment system with their Flutter applications. For now, it only supports **Android and iOS**.

**shurjoPay** flutter package makes the payment system easier for you with just two method calls:

- `makePayment()`
- `verifyPayment()`

And that's all! To know more about its usage please check the details below.

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
    userName: "sp_sandbox",
    password: "pyyk97hu&6u6",
    prefix: "sp",
    currency: "BDT",
    amount: 1000,
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
    clientIP: "127.0.0.1",
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
    shurjopayVerificationModel = await shurjoPay.verifyPayment(
      orderID: shurjopayResponseModel.shurjopayOrderID!,
    );
  }
  ```

<br>
That's all! Now you are ready to use our shurjoPay flutter package to make your payment system easy and smooth.

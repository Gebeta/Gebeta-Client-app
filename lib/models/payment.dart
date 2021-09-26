import 'package:http/http.dart' as http;

import '../mapapi.dart';
// import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponse {
  final String messsage;
  final bool success;

  StripeTransactionResponse({required this.messsage, required this.success});
}

class StripeService {
  static String apiBase = "https://api.stripe.com/v1";
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
   static Uri paymentApiUri =  Uri.parse(StripeService.paymentApiUrl);
  
  static Map<String, String> headers = {
    'Authorization': "Bearer $secret",
    'content-type': 'application/x-www-form-urlencoded'
  };

  static init() {
    // StripePayment.setOptions(StripeOptions(
    //   publishableKey:publishableKey,
    //   merchantId: 'test',
    //   androidPayMode: 'test',
    // ));
  }

  // static Future<Map<String, dynamic>> CreatePaymentIntent(
  //     String amount, String currency) {
  //       try {
          
  //         Map<String, dynamic> body = {
  //           "amount":amount,
  //           "currency":currency
  //         };
          
  //       http.post(paymentApiUri,);

  //       // return{"bb":"jefn "};
  //       } catch (error) {
  //       }
  //     }
}

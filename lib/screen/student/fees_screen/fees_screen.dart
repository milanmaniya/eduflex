import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class FeesScreen extends StatefulWidget {
  const FeesScreen({super.key});

  @override
  State<FeesScreen> createState() => _FeesScreenState();
}

class _FeesScreenState extends State<FeesScreen> {
  Stream<QuerySnapshot<Map<String, dynamic>>> getData() {
    return FirebaseFirestore.instance.collection('Student').snapshots();
  }

  String paymentId = '';

  final _razorpay = Razorpay();

  @override
  initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Student Fees',
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = {};

          if (snapshot.hasData) {
            for (var element in snapshot.data!.docs) {
              if (element.data()['id'] ==
                  FirebaseAuth.instance.currentUser!.uid) {
                data.addAll(element.data());
                log(element.id.toString());
              }
            }
          }

          return Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 3,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Fees Summery',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Column(
                              children: [
                                Text(
                                  'Total \nAmount',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "₹14,235",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Paid \nAmount',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  data['fees'] == true ? "₹14,235" : "₹0",
                                  style: const TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Remaining \nAmount',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  data['fees'] == false ? "₹14,235" : "₹0",
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Payment Id :   ${data['paymentId']}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: data['fees'] == false
                      ? ElevatedButton(
                          onPressed: () {
                            var options = {
                              'key': 'rzp_test_PPC0qcP98CxuXa',
                              'amount': 100,
                              'name':
                                  'S.V. Patel collge Of Computer Science And Business Management',
                              'description': 'Student Fees',
                              'prefill': {
                                'contact': '8888888888',
                                'email': 'svpatelcsbm@gmail.com'
                              }
                            };

                            _razorpay.open(options);
                          },
                          child: const Text('Pay Fees'),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    log("Payment Id:  ${response.paymentId}");

    setState(() {
      paymentId = response.paymentId!;
    });

    FirebaseFirestore.instance
        .collection('Student')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'fees': true,
      'paymentId': paymentId,
    });

    TLoader.successSnackBar(
        title: 'Student Fees', message: 'Fees Payment Successfully');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    TLoader.errorSnackBar(title: 'Student Fees', message: 'Fees not done');
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }
}

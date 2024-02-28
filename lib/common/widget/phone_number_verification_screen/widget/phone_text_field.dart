import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:eduflex/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:logger/logger.dart';

Widget commonPhoneField({
  required BuildContext context,
  required TextEditingController controller,
  required Function()? onTap,
}) =>
    Card(
      margin: const EdgeInsets.only(top: 10),
      elevation: 5,
      shadowColor: Colors.grey,
      child: Container(
        margin: const EdgeInsets.only(
          top: 5,
          right: 5,
        ),
        height: THelperFunction.screenHeight() * 0.26,
        width: THelperFunction.screenWidth() * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IntlPhoneField(
                controller: controller,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                initialCountryCode: 'IN',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  TTexts.phoneNumberValue = value.number;

                  Logger().i(value.number);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  height: THelperFunction.screenHeight() * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "GET OTP",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

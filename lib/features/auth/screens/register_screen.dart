import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piethostel/common/constants.dart';
import 'package:piethostel/common/custom_text_field.dart';
import 'package:piethostel/common/spacing.dart';
import 'package:piethostel/features/auth/functions/auth_functions.dart';
import 'package:piethostel/features/auth/widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();

  final gmailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');

  String? selectBlock;
  String? selectRoom;

  List<String> blockOptions = ["A", "B"];
  List<String> roomOptionsA = ["101", "102", "103"];
  List<String> roomOptionsB = ["201", "202", "203"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 10.h,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightSpacer(40),
                Center(
                  child: Image.asset(
                    AppConstants.logo,
                    height: 170.h,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                heightSpacer(30),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Register your Account",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                heightSpacer(25),
                const Text(
                  "Username",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                CustomTextField(
                  controller: username,
                  inputKeyBoardType: TextInputType.name,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  inputHint: "Enter your Username",
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Username is required";
                    } else {
                      return null;
                    }
                  },
                ),
                heightSpacer(15),
                const Text(
                  "First Name",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                CustomTextField(
                  controller: firstName,
                  inputKeyBoardType: TextInputType.name,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  inputHint: "Enter your First Name",
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "First Name is required";
                    } else {
                      return null;
                    }
                  },
                ),
                heightSpacer(15),
                const Text(
                  "Last Name",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                CustomTextField(
                  controller: lastName,
                  inputKeyBoardType: TextInputType.name,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  inputHint: "Enter your Last Name",
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Last Name is required";
                    } else {
                      return null;
                    }
                  },
                ),
                heightSpacer(15),
                const Text(
                  "Email",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                CustomTextField(
                  controller: email,
                  inputKeyBoardType: TextInputType.emailAddress,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  inputHint: "Enter your Email",
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Email is required";
                    } else if (!gmailRegex.hasMatch(value.trim())) {
                      return "Invalid Email Address";
                    } else {
                      return null;
                    }
                  },
                ),
                heightSpacer(15),
                const Text(
                  "Password",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                CustomTextField(
                  controller: password,
                  inputKeyBoardType: TextInputType.visiblePassword,
                  obscureText: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  inputHint: "Enter your password",
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Password is required";
                    } else {
                      return null;
                    }
                  },
                ),
                heightSpacer(15),
                const Text(
                  "Phone Number",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                CustomTextField(
                    controller: phone,
                    inputKeyBoardType: TextInputType.phone,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    inputHint: "Enter your phone number",
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Phone Number is required";
                      } else if (value.trim().length < 10) {
                        return "Phone Number must be 10 digits";
                      } else if (value.trim().length > 10) {
                        return "Phone Number must be 10 digits";
                      } else {
                        return null;
                      }
                    }),
                heightSpacer(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50.h,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: const BorderSide(
                            width: 1,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          widthSpacer(20),
                          const Text("Block No."),
                          widthSpacer(8),
                          DropdownButton(
                            underline: const SizedBox(),
                            value: selectBlock,
                            onChanged: (String? newValue) {
                              setState(
                                () {
                                  selectBlock = newValue;
                                  selectRoom = null;
                                },
                              );
                            },
                            items: blockOptions.map((String block) {
                              return DropdownMenuItem(
                                value: block,
                                child: Text(block),
                              );
                            }).toList(),
                          ),
                          widthSpacer(20),
                        ],
                      ),
                    ),
                    Container(
                      height: 50.h,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: const BorderSide(width: 1, color: Colors.green),
                        ),
                      ),
                      child: Row(
                        children: [
                          widthSpacer(20),
                          const Text("Room No."),
                          widthSpacer(8),
                          DropdownButton<String>(
                            underline: const SizedBox(),
                            value: selectRoom,
                            onChanged: (String? newValue) {
                              setState(
                                () {
                                  selectRoom = newValue;
                                },
                              );
                            },
                            items: (selectBlock == "A"
                                    ? roomOptionsA
                                    : roomOptionsB)
                                .map(
                              (String room) {
                                return DropdownMenuItem<String>(
                                  value: room,
                                  child: Text(room),
                                );
                              },
                            ).toList(),
                          ),
                          widthSpacer(20),
                        ],
                      ),
                    ),
                  ],
                ),
                heightSpacer(25),
                CustomButton(
                    buttonText: "Register",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (selectBlock == null || selectRoom == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Please select both Block No. and Room No."),
                            ),
                          );
                          return;
                        }
                        registerUser(
                          context,
                          email.text.trim(),
                          password.text.trim(),
                          username.text.trim(),
                          firstName.text.trim(),
                          lastName.text.trim(),
                          phone.text.trim(),
                          selectBlock!.trim(),
                          selectRoom!.trim(),
                          "student",
                          DateTime.now(),
                        );
                      }
                    }),
                heightSpacer(10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    username.dispose();
    firstName.dispose();
    lastName.dispose();
    phone.dispose();
    super.dispose();
  }
}

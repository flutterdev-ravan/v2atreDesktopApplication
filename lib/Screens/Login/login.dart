// ignore_for_file: unused_local_variable, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, avoid_unnecessary_containers

import 'dart:convert';

import 'package:atre_windows/API%20Services/login_Service.dart';
import 'package:atre_windows/Constants/localStorage.dart';
import 'package:atre_windows/Constants/myColors.dart';
import 'package:atre_windows/Constants/myWidgets.dart';
import 'package:atre_windows/Controller/login_controller.dart';
import 'package:atre_windows/Screens/Menu/sideBarx.dart';
import 'package:atre_windows/Screens/Login/login_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
// This is used as a global form key for all text field
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final _loginApi = Provider.of<LoginApi>(context, listen: false);
    final _loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _loginProvider.emailController.text = "velmurugan1211r@gmail.com";
    _loginProvider.passwordTextController.text = "1211";

    super.initState();
  }

  @override
  void dispose() {
    final _loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _loginProvider.emailController.text = "velmurugan1211r@gmail.com";
    _loginProvider.passwordTextController.text = "1211";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _loginApi = Provider.of<LoginApi>(context);
    final _loginProvider = Provider.of<LoginApi>(context);

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Consumer<LoginProvider>(
      builder: (context, snapshot, child) => Stack(children: [
        SvgPicture.asset(
          'assets/images/bg.svg',
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 1,
          fit: BoxFit.cover,
        ),
        Row(
          children: [
            Expanded(
                child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      //********************Lottie Image******************//
                      child: Lottie.asset('assets/Doctor1.json',
                          width: _width / 3.5),
                    ))
              ],
            )),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 180),
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  decoration: loginWidgets.ContainerDecoration(),
                  width: 420,
                  child: snapshot.isPassword
                      ?
                      // *********************************** LOGIN PAGE *********************************************

                      Column(
                          children: [
                            SizedBox(
                                child: Column(
                              children: [
                                loginWidgets.loginText(title: "Login"),
                                const SizedBox(
                                  height: 30,
                                ),
                                //********************Textfield******************//
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      loginWidgets.loginTextfield(
                                        controller: snapshot.emailController,
                                        validator: snapshot.validateEmail,
                                        label: 'Enter email',
                                        hintText: '',
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            loginWidgets.passwordTextfield(
                                                obscureText: !snapshot.isHidden,
                                                validator:
                                                    snapshot.validatePassword,
                                                onTap:
                                                    snapshot.togglePasswordView,
                                                controller: snapshot
                                                    .passwordTextController,
                                                label: 'password',
                                                icon: snapshot.isHidden
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: myColors.greenColor),
                                            const SizedBox(height: 10),
                                            InkWell(
                                              onTap: () {
                                                snapshot.isPasswordFalse();
                                              },
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 30),
                                                  child: myWidgets.greenText(
                                                      title:
                                                          "Forget Password?")),
                                            )
                                          ]),
                                      const SizedBox(height: 20.0),
                                    ],
                                  ),
                                ),

                                //******************** LoginButton ******************//
                                loginWidgets.customButton(
                                    context: context,
                                    height: 22,
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        _loginApi
                                            .loginPost(
                                                snapshot.emailController.text,
                                                snapshot.passwordTextController
                                                    .text)
                                            .then((value) async {
                                          if (value!.status == true) {
                                            //================== Local Storage ===========
                                            await CommonLocalStorage()
                                                .saveLocalStorageToken(json
                                                    .encode(value.data.jwt));
                                            await CommonLocalStorage()
                                                .saveLocalStorageUserID(json
                                                    .encode(value.data.userId));
                                            // =======================================flutter =======
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return const SideBar();
                                            }));
                                            print(
                                                "Access Token: $globalAccessToken");
                                            print("User ID: $globalUserID");
                                          } else {
                                            myWidgets.toastMsg(
                                                context: context,
                                                msg:
                                                    "user email or password is incorrect!");
                                            print(
                                                "user email or password is incorrect");
                                          }
                                        });
                                      } else {
                                        print("Not A Valid User");
                                      }
                                    },
                                    title: 'Login'),
                              ],
                            )),
                          ],
                        )
                      :
                      // *********************************** FORGET PASSWORD *********************************************

                      snapshot.isPassword == false
                          ? snapshot.isOtp == true
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    loginWidgets.loginText(
                                        title: "Forget Password"),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    myWidgets.greyText(
                                        title:
                                            "Enter your email and we’ll send OTP"),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: loginWidgets.loginTextfield(
                                        controller: snapshot.emailController,
                                        validator: snapshot.validateEmail,
                                        label: 'Enter email',
                                        hintText: '',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    loginWidgets.loadingButton(
                                        isLoading: snapshot.isLoading,
                                        context: context,
                                        height: 22,
                                        title: "Send OTP",
                                        onTap: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            print("Send OTP was clicked");
                                            snapshot.isLoadingFalse();
                                            _loginApi
                                                .otpGet(snapshot
                                                    .emailController.text)
                                                .then((value) {
                                              // print(value!.status);
                                              if (value!.status == true) {
                                                snapshot.isOTPLoading();
                                              } else if (value.data != "{}") {
                                                snapshot.loadingView();
                                                myWidgets.toastMsg(
                                                    context: context,
                                                    msg:
                                                        "otp details already exists!");
                                                print(
                                                    "otp details already exists !");
                                              } else {
                                                snapshot.loadingView();
                                                myWidgets.toastMsg(
                                                    context: context,
                                                    msg:
                                                        "This is not an Authorized Mail Id");
                                                print(
                                                    "This is not an Authorized Mail Id");
                                              }
                                            });
                                          }
                                        }),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          snapshot.isPasswordTrue();
                                        },
                                        child: myWidgets.greenText(
                                            title: "Back to Login")),
                                  ],
                                )
                              :
                              // *********************************** OTP PAGE *********************************************

                              snapshot.isConfirmPassword
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        loginWidgets.loginText(
                                            title: "Enter OTP"),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40),
                                          child: Form(
                                              key: _formKey,
                                              child: loginWidgets.otpTextfield(
                                                  controller:
                                                      snapshot.otpController,
                                                  validator:
                                                      snapshot.validateOTP,
                                                  context: context)),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        loginWidgets.customButton(
                                            context: context,
                                            height: 22,
                                            title: "Verify OTP",
                                            onTap: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                print("OTP was verified");

                                                _loginApi
                                                    .otpVerify(
                                                        snapshot.emailController
                                                            .text,
                                                        snapshot
                                                            .otpController.text)
                                                    .then((value) {
                                                  if (value!.message ==
                                                      "Otp matches...") {
                                                    snapshot
                                                        .isConfirmPasswordFalse();
                                                  } else {
                                                    myWidgets.toastMsg(
                                                        context: context,
                                                        msg:
                                                            "OTP was not correct");
                                                  }
                                                });
                                              }
                                            }),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    )
                                  :
                                  // *********************************** SET PASSWORD *********************************************
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        loginWidgets.loginText(
                                            title: "Set Password"),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Form(
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                loginWidgets.passwordTextfield(
                                                    obscureText:
                                                        !snapshot.isNewHidden,
                                                    validator: snapshot
                                                        .validatePassword,
                                                    onTap: snapshot
                                                        .newPasswordView,
                                                    controller:
                                                        snapshot.newPassword,
                                                    label: 'New password',
                                                    icon: snapshot.isNewHidden
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                    color: myColors.greenColor),
                                                const SizedBox(height: 30),
                                                loginWidgets.passwordTextfield(
                                                    obscureText: !snapshot
                                                        .isConfirmHidden,
                                                    validator: snapshot
                                                        .validatePassword,
                                                    onTap: snapshot
                                                        .confirmPasswordView,
                                                    controller: snapshot
                                                        .confirmPassword,
                                                    label: 'Confirm password',
                                                    icon: snapshot
                                                            .isConfirmHidden
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                    color: myColors.greenColor),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                loginWidgets.customButton(
                                                    context: context,
                                                    height: 22,
                                                    title: "Submit",
                                                    onTap: () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        if (snapshot.newPassword
                                                                .text ==
                                                            snapshot
                                                                .confirmPassword
                                                                .text) {
                                                          print(
                                                              "Password was set");
                                                          _loginApi
                                                              .updatePassword(
                                                                  snapshot
                                                                      .emailController
                                                                      .text,
                                                                  snapshot
                                                                      .newPassword
                                                                      .text)
                                                              .then(
                                                            (value) {
                                                              if (value!
                                                                      .status ==
                                                                  true) {
                                                                snapshot
                                                                    .isPasswordTrue();
                                                              } else {
                                                                print(
                                                                    "Record is not updated");
                                                              }
                                                            },
                                                          );
                                                        } else {
                                                          print(
                                                              "Password not same");
                                                          myWidgets.toastMsg(
                                                              context: context,
                                                              msg:
                                                                  "Both password should be same!");
                                                        }
                                                      }
                                                    }),
                                              ],
                                            )),
                                      ],
                                    )
                          : Container(),
                ),
              ],
            ))
          ],
        ),
      ]),
    ));
  }
}

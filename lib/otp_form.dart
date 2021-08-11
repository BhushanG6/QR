import 'dart:convert';

import 'package:flutproj/enter_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'size_config.dart';
import 'package:flutter_otp/flutter_otp.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class OtpForm extends StatefulWidget {
  //const OtpForm({
  // Key key,
  // }) : super(key: key);
  final String phone;
  OtpForm(this.phone);
  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  @override
  @override
  String _verificationCode;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  FormScreenState obj = FormScreenState();
  @override
  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 60.0, end: 0.0),
          duration: Duration(seconds: 60),
          builder: (_, value, child) => Text(
            "00:${value.toInt()}",
            //style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: getProportionateScreenHeight(370),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          getProportionateScreenWidth(30),
                          getProportionateScreenHeight(30),
                          0.0,
                          0.0),
                      child: Text('Verification Details',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'SF Pro Display',
                          )),
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    Container(
                      alignment: Alignment.center,
                      child: Text('Enter verification code',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'SF Pro Display',
                          )),
                    ),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    buildTimer(),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                Padding(
                  padding: EdgeInsets.only(
                    left: getProportionateScreenHeight(30),
                    right: getProportionateScreenHeight(30),
                  ),
                  child: PinPut(
                    fieldsCount: 6,
                    textStyle:
                        const TextStyle(fontSize: 20, fontFamily: 'Roboto'),
                    eachFieldWidth: getProportionateScreenHeight(40),
                    eachFieldHeight: getProportionateScreenHeight(40),
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration: BoxDecoration(
                      color: Color.fromRGBO(246, 246, 246, 1),
                      borderRadius: BorderRadius.circular(14.0),
                      border: null,
                    ),
                    selectedFieldDecoration: BoxDecoration(
                      color: Color.fromRGBO(246, 246, 246, 1),
                      borderRadius: BorderRadius.circular(14.0),
                      border: null,
                    ),
                    followingFieldDecoration: BoxDecoration(
                      color: Color.fromRGBO(246, 246, 246, 1),
                      borderRadius: BorderRadius.circular(14.0),
                      border: null,
                    ),
                    pinAnimationType: PinAnimationType.fade,
                    onSubmit: (pin) async {
                      try {
                        dynamic role = await FlutterSession().get('role');
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: _verificationCode,
                                smsCode: pin))
                            .then((value) async {
                          if (value.user != null) {
                            print('${widget.phone}');

                            print("success");
                            if (role == 'myself')
                              obj.getdatapatient();
                            else
                              obj.getdatarelative();
                          }
                        });
                      } catch (e) {
                        FocusScope.of(context).unfocus();
                        print('Invalid Otp');
                      }
                    },
                  ),
                )
              ],
            ),
            SizedBox(height:getProportionateScreenHeight(15)),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(40),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => FormScreen()),
                        (route) => false);
                  },
                  child: Text(
                    "Resend verification code",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(50)),
              Container(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () async {
                    dynamic role = await FlutterSession().get('role');

                    print("success");

                    if (role == 'myself')
                      obj.getdatapatient();
                    else
                      obj.getdatarelative();
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          left: getProportionateScreenWidth(210)),
                      height: getProportionateScreenHeight(46),
                      width: getProportionateScreenWidth(108),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(74, 144, 226, 1),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Next',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'SF Pro Display',
                                      fontSize: 20),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ],
                            ),
                          ])),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20))
            ])
          ],
        ),
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              print("success");
              dynamic role = await FlutterSession().get('role');

              if (role == 'myself')
                obj.getdatapatient();
              else
                obj.getdatarelative();
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 60));
  }

  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    _verifyPhone();
  }
}

import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutproj/bottomNavigation.dart';
import 'package:flutproj/date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'enter_mobile.dart';
import 'size_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  String _firstname;
  String _lastname;
  String _mobileno;
  String _password;
  bool _checkbox1 = true;
  bool _checkbox2 = false;
  var gender = ' ';
  var tempdate;
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Color.fromRGBO(246, 246, 246, 1),
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(14)),
    border: null,
  );

     
  getdata()async
  {
          await FlutterSession().set('firstname', _firstname.toString());
          await FlutterSession().set('lastname', _lastname.toString());
          await FlutterSession().set('gender', gender.toString());
          await FlutterSession().set('dob', tempdate.toString());
          if(_checkbox1==true)
          await FlutterSession().set('role', 'myself');
          else
          await FlutterSession().set('role', 'relative');

  }
  Future<void> getdatapatient() async {
      dynamic dob=await FlutterSession().get('dob');
       dynamic gender1=await FlutterSession().get('gender');
       dynamic role=await FlutterSession().get('role');
       dynamic firstname=await FlutterSession().get('firstname');
       dynamic lastname=await FlutterSession().get('lastname');
       print(role);
    var urlpatient = Uri.parse('https://project31-heroku.herokuapp.com/api/v11/user/qrCreatePatientProfile/');

    var headers = {'content-type': 'application/json'};
    // Store all data with Param Name.

    var data = {
      '_id': 'xyzEntryQRId',
      'dateOfBirth': dob,
      'name': '$firstname $lastname',
      'gender': gender1,
    };
    print(data);
    var response = await http.post(
      urlpatient,
      headers: headers,
      body: jsonEncode(data),
    );

    //   // Getting Server response into variable.
    var message = jsonDecode(response.body);
    print(message);
    
    if (message['status'] == "success") {
     
      Fluttertoast.showToast(
          msg: 'Successfully Logged In',
          //backgroundColor: Colors.red,
          fontSize: 15,
          gravity: ToastGravity.TOP,
          textColor: Colors.green);
     
    } else {
      Fluttertoast.showToast(
          msg: message['message'],
          toastLength: Toast.LENGTH_LONG,
          //backgroundColor: Colors.grey,
          fontSize: 15,
          gravity: ToastGravity.TOP,
          textColor: Colors.red);
    }
    // If Web call Success than Hide the CircularProgressIndicator.
  
  }

  Future<void> getdatarelative() async {
    var urlrelative = Uri.parse(
        'https://project31-heroku.herokuapp.com/api/v11/user/qrCreatePatientRelativeProfile/');

    var headers = {'content-type': 'application/json'};

    // Store all data with Param Name.

    var data = {
    "patientId": "bhushanEntryQRId",
    "relativeId": "xyzEntryQRId",
    "relationship": "Brother",
    "status": "Employed",
    "gender": "General Manager"
};
    print(data);
    var response = await http.post(
      urlrelative,
      headers: headers,
      body: jsonEncode(data),
    );

    //   // Getting Server response into variable.
    var message = jsonDecode(response.body);
    print(message);
       
    if (message['status'] == "success") {
     
      Fluttertoast.showToast(
          msg: 'Successfully Logged In',
          //backgroundColor: Colors.red,
          fontSize: 15,
          gravity: ToastGravity.TOP,
          textColor: Colors.green);
     
    } else {
      Fluttertoast.showToast(
          msg: message['message'],
          toastLength: Toast.LENGTH_LONG,
          //backgroundColor: Colors.grey,
          fontSize: 15,
          gravity: ToastGravity.TOP,
          textColor: Colors.red);
    }
  }

  TextEditingController genderPicked = new TextEditingController();
  TextEditingController datePicked = new TextEditingController();

  DateTime dateTime = DateTime.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var containerheight = getProportionateScreenHeight(470);
  //Body:

  Widget _buildfirstName() {
    return Container(
      width: getProportionateScreenWidth(315),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,

        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.only(left: getProportionateScreenWidth(10)),
            labelText: 'First Name',
            labelStyle: TextStyle(
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Color.fromARGB(255, 69, 69, 69)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 69, 69, 69),
                width: 3,
              ),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0)),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              width: 3,
              color: Color.fromARGB(255, 69, 69, 69),
            ))),
        //maxLength: 8,
        validator: (String value) {
          if (value.isEmpty) {
            return 'First name is Required';
          }
          final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
          if (!nameExp.hasMatch(value))
            return 'Please enter only alphabetical characters and spaces.';
          return null;
        },
        onSaved: (String value) {
          _firstname = value;
        },
      ),
    );
  }

  Widget _buildlastName() {
    return Container(
      width: getProportionateScreenWidth(315),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,

        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.only(left: getProportionateScreenWidth(10)),
            labelText: 'Last Name',
            labelStyle: TextStyle(
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Color.fromARGB(255, 69, 69, 69)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 69, 69, 69),
                width: 3,
              ),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0)),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              width: 3,
              color: Color.fromARGB(255, 69, 69, 69),
            ))),
        //maxLength: 8,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Last name is Required';
          }
          final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
          if (!nameExp.hasMatch(value))
            return 'Please enter only alphabetical characters and spaces.';
          return null;
        },
        onSaved: (String value) {
          _lastname = value;
        },
      ),
    );
  }

  Widget _buildcheckbox() {
    return Container(
      width: getProportionateScreenWidth(315),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: getProportionateScreenWidth(140),
            child: CheckboxListTile(
              contentPadding:
                  EdgeInsets.only(left: getProportionateScreenWidth(0)),
              selectedTileColor: Color.fromRGBO(246, 246, 246, 1),
              controlAffinity: ListTileControlAffinity.leading,
              title: AutoSizeText('Myself'),
              value: _checkbox1,
              onChanged: (value) {
                setState(() {
                  _checkbox1 = !_checkbox1;
                });
              },
            ),
          ),
          Container(
            // padding: EdgeInsets.only(
            //     left: getProportionateScreenWidth(10)),
            width: getProportionateScreenWidth(170),
            child: CheckboxListTile(
              contentPadding:
                  EdgeInsets.only(left: getProportionateScreenWidth(55)),
              selectedTileColor: Color.fromRGBO(246, 246, 246, 1),
              controlAffinity: ListTileControlAffinity.leading,
              title: AutoSizeText(
                'Relative',
                softWrap: true,
              ),
              value: !_checkbox1,
              onChanged: (value) {
                setState(() {
                  _checkbox1 = !_checkbox1;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getGender() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align(
//alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(top: getProportionateScreenHeight(510)),
              height: getProportionateScreenHeight(300),
              width: double.infinity, //getProportionateScreenWidth(350),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //SizedBox(height: getProportionateScreenHeight(24)),
                  Center(
                    child: AutoSizeText(
                      'Select Gender',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 18),
                    ),
                  ),

                  new Divider(
                    color: Colors.black,
                  ),
                  //SizedBox(height: getProportionateScreenHeight(11)),
                  Center(
                    child: Container(
                      height: getProportionateScreenHeight(110),
                      child: CupertinoPicker(
                        useMagnifier: true,
                        children: <Widget>[
                          AutoSizeText(
                            'Male',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w500),
                          ),
                          AutoSizeText(
                            'Female',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w500),
                          ),
                          AutoSizeText(
                            'Other',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                        itemExtent: getProportionateScreenHeight(50),
                        onSelectedItemChanged: (value) {
                          print(value);

                          if (value == 0) gender = 'male';
                          if (value == 1) gender = 'female';
                          if (value == 2) gender = 'other';
                         setState(() => {genderPicked.text = gender});

                        },
                      ),
                    ),
                  ),
                  new Divider(
                    color: Colors.black,
                  ),
                  //SizedBox(height: getProportionateScreenHeight(11)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //SizedBox(width:getProportionateScreenWidth(10)),

                      Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            gender = ' ';
                            Navigator.pop(context);
                          },
                          child: AutoSizeText(
                            'Cancel',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      // SizedBox(width:getProportionateScreenWidth(250)),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: AutoSizeText(
                            'Confirm',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Color.fromRGBO(54, 137, 212, 1),
                                fontSize: 18,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildgender() {
    return Container(
      width: getProportionateScreenWidth(142),
      child: TextFormField(

        controller: genderPicked,
                textCapitalization: TextCapitalization.sentences,

        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.only(left: getProportionateScreenWidth(10)),
            labelText: 'Gender',
            labelStyle: TextStyle(
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Color.fromARGB(255, 69, 69, 69)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 69, 69, 69),
                width: 3,
              ),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0)),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              width: 3,
              color: Color.fromARGB(255, 69, 69, 69),
            ))),
        //maxLength: 8,
        // controller: dateCtl,
        onTap: () async {
          FocusScope.of(context).requestFocus(new FocusNode());

          showModalBottomSheet(
              isScrollControlled: true,
              clipBehavior: Clip.none,
              enableDrag: true,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return getGender();
              });

        },
        
        validator: (String value) {
          if (value.isEmpty) {
            return 'Gender is Required';
          }

          return null;
        },
      ),
    );
  }

  Widget _buildDob() {
    return Container(
      width: getProportionateScreenWidth(142),
      child: TextFormField(
        controller: datePicked,
        keyboardType: TextInputType.datetime,

        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.only(left: getProportionateScreenWidth(10)),
            labelText: 'Date of Birth',
            labelStyle: TextStyle(
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Color.fromARGB(255, 69, 69, 69)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 69, 69, 69),
                width: 3,
              ),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0)),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              width: 3,
              color: Color.fromARGB(255, 69, 69, 69),
            ))),
        //maxLength: 8,
        // controller: dateCtl,
        onTap: () async {
          FocusScope.of(context).requestFocus(new FocusNode());

          DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime(2010, 3, 5),
              maxTime: DateTime(2030, 6, 7),
              theme: DatePickerTheme(
                  headerColor: Color.fromRGBO(250, 250, 250, 1),
                  backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                  itemStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
              onChanged: (date) {}, onConfirm: (date) {
            print(date.day);
            print(date.month);
            print(date.year);
            tempdate = date.day.toString() +
                '/' +
                date.month.toString() +
                '/' +
                date.year.toString();
              setState(() => {datePicked.text = tempdate});

          }, currentTime: DateTime.now(), locale: LocaleType.en);
          
         // _buildDob();
        },
        validator: (String value) {
          if (value.isEmpty) {
            return 'Date of Birth is Required';
          }

          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      child: Container(
        //padding: EdgeInsets.only(bottom:getProportionateScreenHeight(20)),
        //elevation: 5,
        height: containerheight, //getProportionateScreenHeight(510),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: Colors.white),
        // margin: EdgeInsetsDirectional.only(
        //     top: getProportionateScreenHeight(310)),
        //color: Colors.white,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
                getProportionateScreenWidth(30),
                getProportionateScreenHeight(30),
                0.0,
                0.0),
            child: AutoSizeText('Enter Details',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'SF Pro Display',
                )),
          ),
        ],
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(25)),
              Container(
                //height: getProportionateScreenHeight(415),
                margin: EdgeInsets.only(left: getProportionateScreenWidth(30)),
                child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildfirstName(),
            SizedBox(height: getProportionateScreenHeight(30)),
            _buildlastName(),
            // SizedBox(height: getProportionateScreenHeight(30)),
            //_buildmobile(),
            SizedBox(height: getProportionateScreenHeight(30)),
            Row(
                //mainAxisAlignment:MainAxisAlignment.spaceAround,
                children: [
                  _buildgender(),
                  SizedBox(width: getProportionateScreenWidth(31)),
                  _buildDob(),
                ]),
            SizedBox(height: getProportionateScreenHeight(30)),
            _buildcheckbox(),
            SizedBox(height: getProportionateScreenHeight(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                                                  containerheight = getProportionateScreenHeight(520);

                    });
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    _formKey.currentState.save();
                   getdata();

                    showModalBottomSheet(
                        isScrollControlled: true,
                        clipBehavior: Clip.none,
                        enableDrag: true,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return EnterMobile();
                        });
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
                                AutoSizeText(
                                  'Next',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'SF Pro Display'),
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
              ],
            ),
            //SizedBox(height: 20),
          ],
        ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}

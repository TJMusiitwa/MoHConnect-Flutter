import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _firstName,
      _lastName,
      _emailController,
      _phoneNumberController;
  //_genderController;
  String _gender;
  final _registerFormKey = GlobalKey<FormState>();
  final _registerScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        key: _registerScaffoldKey,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/login_back.jpg'),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter)),
              ),
              Positioned(
                bottom: 0,
                left: 0.0,
                right: 0.0,
                height: MediaQuery.of(context).size.height - 250,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Register",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        Form(
                          key: _registerFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              TextFormField(
                                controller: _firstName,
                                decoration: InputDecoration(
                                    labelText: 'First name', hintText: 'Jane'),
                                keyboardType: TextInputType.text,
                                onSaved: (String value) {
                                  _firstName.text = value;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: _lastName,
                                decoration: InputDecoration(
                                    labelText: 'Last name', hintText: 'Jane'),
                                keyboardType: TextInputType.text,
                                onSaved: (String value) {
                                  _lastName.text = value;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: _phoneNumberController,
                                decoration: InputDecoration(
                                    labelText: 'Phone number',
                                    hintText: '07123456878'),
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                maxLengthEnforced: true,
                                onSaved: (String value) {
                                  _phoneNumberController.text = value;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                    labelText: 'Email',
                                    hintText: 'user.example@email.com'),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                onSaved: (String value) {
                                  _emailController.text = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Email field cannot be empty!';
                                  }
                                  // Regex for email validation
                                  String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                                      "\\@" +
                                      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                                      "(" +
                                      "\\." +
                                      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                                      ")+";
                                  RegExp regExp = new RegExp(p);
                                  if (regExp.hasMatch(value)) {
                                    return null;
                                  }
                                  return 'Email provided isn\'t valid.Try another email address';
                                },
                              ),
                              SizedBox(height: 20),
                              DropdownButtonFormField(
                                hint: Text('Gender'),
                                value: _gender,
                                items: [
                                  DropdownMenuItem(
                                    value: 'Male',
                                    child: Text('Male'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Female',
                                    child: Text('Female'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              PlatformButton(
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_registerFormKey.currentState
                                        .validate()) {
                                      _registerFormKey.currentState.save();
                                      Response response;
                                      Dio dio = Dio();
                                      dio.options.baseUrl =
                                          'http://15.188.180.73:8080/YCSR/webapi/requests/user';
                                      response =
                                          await dio.post('/register', data: {
                                        "firstName": _firstName.text,
                                        "lastName": _lastName.text,
                                        "phoneNumber":
                                            _phoneNumberController.text,
                                        "email": _emailController.text,
                                        "address": "Hawaii",
                                        "gender": _gender,
                                      });
                                      if (response.statusCode == 200 ||
                                          response.statusCode == 201) {
                                        print(response.data);
                                        _registerScaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                          content: Text(response.statusMessage),
                                          behavior: SnackBarBehavior.floating,
                                        ));
                                        Future.delayed(Duration(seconds: 3),
                                            () {
                                          setState(() {
                                            Navigator.of(context)
                                                .popAndPushNamed('HomePage');
                                          });
                                        });
                                      } else {
                                        SnackBar(
                                            content: Text('Error Registering'));
                                      }
                                    }
                                  })
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: PlatformButton(
                            androidFlat: (_) => MaterialFlatButtonData(),
                            onPressed: () =>
                                Navigator.pushNamed(context, 'LoginPage'),
                            child: Center(
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "Already have an account?",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      )),
                                  TextSpan(
                                      text: "  Login",
                                      style: TextStyle(
                                        color: Color.fromRGBO(242, 92, 5, 1),
                                        fontSize: 15,
                                      ))
                                ]),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  // @override
  // void dispose() {
  //   _firstName.dispose();
  //   _lastName.dispose();
  //   _emailController.dispose();
  //   _phoneNumberController.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
    _firstName = TextEditingController(text: "");
    _lastName = TextEditingController(text: "");
    _emailController = TextEditingController(text: "");
    _phoneNumberController = TextEditingController(text: "");
  }
}

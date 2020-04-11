import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginScaffoldKey = GlobalKey<ScaffoldState>();
  final _loginFormKey = GlobalKey<FormState>();

  TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      key: _loginScaffoldKey,
      appBar: PlatformAppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
      ),
      body: Stack(children: [
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
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Form(
                    key: _loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        TextFormField(
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: 'Phone Number',
                              hintText: '0712345678',
                              border: OutlineInputBorder()),
                          maxLength: 10,
                          maxLengthEnforced: true,
                          validator: (phone) {
                            if (phone.isEmpty) {
                              return 'Phone number cannot be empty';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _phoneNumberController.text = value;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Center(
                            child: MaterialButton(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                height: 50,
                                minWidth: 400,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                onPressed: () async {
                                  if (_loginFormKey.currentState.validate()) {
                                    _loginFormKey.currentState.save();
                                    Response response;
                                    Dio dio = Dio();
                                    dio.options.baseUrl =
                                        'http://15.188.180.73:8080/YCSR/webapi/requests/user';
                                    response = await dio.get(
                                        "/verify/${_phoneNumberController.text}");
                                    //TODO: Fix this backend logic that still logs in after status code 200 is passed.
                                    if (response.statusCode == 200 ||
                                        response.statusCode == 201) {
                                      print(response.statusMessage);
                                      Future.delayed(Duration(seconds: 3), () {
                                        setState(() {
                                          Navigator.of(context)
                                              .popAndPushNamed('HomePage');
                                        });
                                      });
                                    } else {
                                      _loginScaffoldKey.currentState
                                          .showSnackBar(SnackBar(
                                        content: Text(response.statusMessage),
                                        behavior: SnackBarBehavior.floating,
                                      ));
                                    }
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController(text: '');
  }
}

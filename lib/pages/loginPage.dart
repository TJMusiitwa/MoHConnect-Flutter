import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginScaffoldKey = GlobalKey<ScaffoldState>();

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
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter)),
        ),
        Positioned(
          bottom: 0,
          left: 0.0,
          right: 0.0,
          height: MediaQuery.of(context).size.height - 400,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(3, 10, 30, 3),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(3, 24, 89, 1),
                      ),
                    ),
                  ),
                  Form(
                    child: Column(
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
                                    color: Colors.white,
                                  ),
                                ),
                                height: 50,
                                minWidth: 400,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                onPressed: () {
                                  _loginScaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'The login will be added later on'),
                                    ),
                                  );
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

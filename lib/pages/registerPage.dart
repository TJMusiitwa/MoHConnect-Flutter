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
      _phoneNumberController,
      _genderController;
  String _gender;
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/login_back.jpg'),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter)),
        ),
        Container(
          height: MediaQuery.of(context).size.height - 400,
          //margin: EdgeInsets.only(top: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(3, 10, 30, 3),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(3, 24, 89, 1),
                    ),
                  ),
                ),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      TextFormField(
                        controller: _firstName,
                        decoration: InputDecoration(
                            labelText: 'First name', hintText: 'Jane'),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _lastName,
                        decoration: InputDecoration(
                            labelText: 'Last name', hintText: 'Jane'),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                            labelText: 'Phone number', hintText: '07123456878'),
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        maxLengthEnforced: true,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'user.example@email.com'),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (v) {
                          // FocusScope.of(context)
                          //     .requestFocus(focusAddress);
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
                          onPressed: () {})
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25),
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
                            text: "Login",
                            style: TextStyle(
                              color: Color.fromRGBO(242, 92, 5, 1),
                              fontSize: 15,
                            ))
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}

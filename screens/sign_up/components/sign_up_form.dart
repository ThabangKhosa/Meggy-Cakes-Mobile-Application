// ignore_for_file: unrelated_type_equality_checks, dead_code, avoid_returning_null_for_void, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meggycakes/Widgets/size_config.dart';
import 'package:meggycakes/components/custom_surfix_icon.dart';
import 'package:meggycakes/components/default_button.dart';
import 'package:meggycakes/components/form_error.dart';
import 'package:meggycakes/screens/complete_profile/complete_profile_screen.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meggycakes/screens/login_success/login_success_screen.dart';

import '../../../constants.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email1;
  String? password2;
  String? v_name;
  String? v_phone;
  String? v_address;
  String? v_city;
  String? v_state;
  String? v_zip;
  bool? isLogin;
  // ignore: non_constant_identifier_names
  String? conform_password;
  bool remember = false;
  final List<String?> errors = [];

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController zip = TextEditingController();
  TextEditingController password = TextEditingController();

  Future register() async {
    var url = "http://192.168.31.198/flutter-login-signup/register.php";
    var response = await http.post(Uri.parse(url), body: {
      "cust_name": name.text,
      "cust_email": email.text,
      "cust_phone": phone.text,
      "cust_address": address.text,
      "cust_city": city.text,
      "cust_state": state.text,
      "cust_zip": zip.text,
      "cust_password": password.text,
    });
    var encodeFirst = json.encode(response.body);
    var data = json.decode(encodeFirst);

    if (data == "Error") {
      Fluttertoast.showToast(
          msg: "This email/user already exists!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      isLogin = false;
      return isLogin;
    } else {
      Fluttertoast.showToast(
          msg: "Registration Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 53, 235, 62),
          textColor: Colors.white,
          fontSize: 16.0);
      isLogin = true;
      return isLogin;
    }
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildCityFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildStateFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildZipFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Register",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                register();
                // if all are valid then go to success screen
                Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password2 == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password2 != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      // ignore: prefer_const_constructors
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: password,
      obscureText: true,
      onSaved: (newValue) => password2 = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password2 = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kPassNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email1 = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      controller: name,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => v_name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        v_name == value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
        v_name == value;
      },
      // ignore: prefer_const_constructors
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter your name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      controller: address,
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => v_address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        v_address == value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
        v_address == value;
      },
      // ignore: prefer_const_constructors
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildCityFormField() {
    return TextFormField(
      controller: city,
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => v_city = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        v_city == value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
        v_city == value;
      },
      // ignore: prefer_const_constructors
      decoration: InputDecoration(
        labelText: "City",
        hintText: "Enter your city",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildStateFormField() {
    return TextFormField(
      controller: state,
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => v_state = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        v_state == value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
        v_state == value;
      },
      // ignore: prefer_const_constructors
      decoration: InputDecoration(
        labelText: "State/Provice",
        hintText: "Enter your state or province",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildZipFormField() {
    return TextFormField(
      controller: zip,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => v_zip = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        v_zip == value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
        v_zip == value;
      },
      // ignore: prefer_const_constructors
      decoration: InputDecoration(
        labelText: "ZIP Code",
        hintText: "Enter your ZIP code",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      controller: phone,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => v_phone = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        v_phone == value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        } else if (value.length < 10) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
        v_phone == value;
      },
      // ignore: prefer_const_constructors
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }
}

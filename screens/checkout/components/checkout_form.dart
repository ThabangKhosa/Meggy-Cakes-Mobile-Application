// ignore_for_file: unrelated_type_equality_checks, dead_code, avoid_returning_null_for_void, prefer_const_constructors

import 'dart:convert';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meggycakes/Widgets/size_config.dart';
import 'package:meggycakes/blocs/checkout/checkout_bloc.dart';
import 'package:meggycakes/components/custom_surfix_icon.dart';
import 'package:meggycakes/components/default_button.dart';
import 'package:meggycakes/components/form_error.dart';
import 'package:meggycakes/screens/complete_profile/complete_profile_screen.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meggycakes/screens/login_success/login_success_screen.dart';
import 'package:meggycakes/screens/order/order_success_screen.dart';
import 'package:meggycakes/blocs/cart/cart_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import '../../../constants.dart';

class ChekoutForm extends StatefulWidget {
  @override
  _ChekoutForm createState() => _ChekoutForm();
}

class _ChekoutForm extends State<ChekoutForm> {
  final _formKey = GlobalKey<FormState>();
  String? email1;
  String? v_name;
  String? v_phone;
  String? v_address;
  String? v_city;
  String? v_state;
  String? v_zip;
  int? getId;
  int? totalAmount;

  final List<String?> errors = [];

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController city = TextEditingController();
  final SingleValueDropDownController stateprov =
      SingleValueDropDownController();
  final TextEditingController zip = TextEditingController();
  final TextEditingController password = TextEditingController();

  void order() {
    var url = "http://192.168.31.198/flutter-login-signup/shipping.php";
    http.post(Uri.parse(url), body: {
      "cust_b_name": name.text,
      "cust_b_email": email.text,
      "cust_b_phone": phone.text,
      "cust_b_address": address.text,
      "cust_b_city": city.text,
      "cust_b_state": stateprov.dropDownValue!.value.toString(),
      "cust_b_zip": zip.text,
      "cust_s_name": name.text,
      "cust_s_email": email.text,
      "cust_s_phone": phone.text,
      "cust_s_address": address.text,
      "cust_s_city": city.text,
      "cust_s_state": stateprov.dropDownValue!.value.toString(),
      "cust_s_zip": zip.text,
    }).then((response) {
      print(response.body);
      var data = jsonDecode(response.body);
      if (data == "Error") {
        Fluttertoast.showToast(
            msg: "Shipping Address is deemed invalid!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Shipping Address Added Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 53, 235, 62),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  void payment() {
    var url = "http://192.168.31.198/flutter-login-signup/payment.php";
    http.post(Uri.parse(url), body: {
      "cust_name": name.text,
      "cust_email": email.text,
      "p_id": getId.toString(),
    }).then((response) {
      print(response.body);
      var data = jsonDecode(response.body);
      if (data == "Error") {
        Fluttertoast.showToast(
            msg: "Payment is deemed unsuccessful!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Payment Successful!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 53, 235, 62),
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pushNamed(context, OrderSuccessScreen.routeName);
      }
    });
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
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
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
              DefaultButton(
                text: "Pay with Cash",
                press: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    order();
                    if (state is CartLoaded) {
                      getId = int.parse(state.cart.productIdString);
                    }
                    payment();
                    // if all are valid then go to success screen
                  }
                },
              ),
            ],
          ),
        );
      },
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

  DropDownTextField buildStateFormField() {
    return DropDownTextField(
      controller: stateprov,
      clearOption: true,
      enableSearch: true,
      clearIconProperty: IconProperty(color: Colors.green),
      searchDecoration:
          const InputDecoration(hintText: "Search for your state here"),
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
        v_state == value;
      },
      // ignore: prefer_const_constructors
      dropDownList: const [
        DropDownValueModel(name: 'Arusha', value: "Arusha"),
        DropDownValueModel(name: 'Bagamoyo', value: "Bagamoyo"),
        DropDownValueModel(name: 'Bukoba', value: "Bukoba"),
        DropDownValueModel(name: 'Dar es Salaam', value: "Dar es Salaam"),
        DropDownValueModel(name: 'Dodoma', value: "Dodoma"),
        DropDownValueModel(name: 'Iringa', value: "Iringa"),
        DropDownValueModel(name: 'Kilwa', value: "Kilwa"),
        DropDownValueModel(name: 'Kondoa-Irangi', value: "Kondoa-Irangi"),
        DropDownValueModel(name: 'Lindi', value: "Lindi"),
        DropDownValueModel(name: 'Mahenge', value: "Mahenge"),
        DropDownValueModel(name: 'Morogoro', value: "Morogoro"),
        DropDownValueModel(name: 'Moshi', value: "Moshi"),
        DropDownValueModel(name: 'Mwanza', value: "Mwanza"),
        DropDownValueModel(name: 'Pangani', value: "Pangani"),
        DropDownValueModel(name: 'Rufiji', value: "Rufiji"),
        DropDownValueModel(name: 'Rungwe', value: "Rungwe"),
        DropDownValueModel(name: 'Songea', value: "Songea"),
        DropDownValueModel(name: 'Tabora', value: "Tabora"),
        DropDownValueModel(name: 'Tanga', value: "Tanga"),
        DropDownValueModel(name: 'Ufipa', value: "Ufipa"),
        DropDownValueModel(name: 'Ujiji', value: "Ujiji"),
        DropDownValueModel(name: 'Usambara', value: "Usambara"),
        DropDownValueModel(name: 'Other', value: "Other"),
      ],
      textFieldDecoration: InputDecoration(
        labelText: "State",
        hintText: "Enter your state",
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

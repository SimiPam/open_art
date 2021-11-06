import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_art/core/services/auth/auth_service.dart';
import 'package:open_art/core/services/auth/validator.dart';
import 'package:open_art/modules/auth/widgets/InputTextField.dart';
import 'package:open_art/modules/auth/widgets/decoration_functions.dart';
import 'package:open_art/modules/auth/widgets/sign_in_up_bar.dart';
import 'package:open_art/modules/home_module/home.dart';
import 'package:open_art/shared/utils/auth/constants.dart';
import 'package:open_art/shared/utils/palette.dart';
import 'package:open_art/shared/utils/themes/theme.dart';
import 'package:open_art/shared/widgets/space.dart';
import 'package:provider/provider.dart';
import 'package:open_art/shared/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth.dart';

class SignIn extends StatefulWidget {
  final VoidCallback onRegisterClicked;

  const SignIn({Key key, @required this.onRegisterClicked}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Color _buttonColor = amTheme.black;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Validator validator = Validator();

  void submit(String value, int tog) {
    setState(() {
      if (tog == 1) {
        if (validator.emailValidation(value)) {
          kCorrectEmail = true;
        } else {
          kCorrectEmail = false;
        }
      } else if (tog == 2) {
        if (validator.numberValidation(value)) {
          kCorrectPass = true;
        } else {
          kCorrectPass = false;
        }
      }
    });
  }

  void _buttonChange() {
    // _controller.forward(from: 0);
    setState(() {
      _buttonColor = amTheme.green;
    });
  }

  AuthServices loginProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginProvider = Provider.of<AuthServices>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    // final
    return Padding(
      padding: EdgeInsets.all(32.0.sp),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Styles.semiBold(
                'Welcome \nBack',
                fontSize: 34.sp,
                color: amTheme.white,
                align: TextAlign.left,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: InputTextField(
                      fieldController: emailController,
                      fieldValidator: (val) =>
                          val.isNotEmpty ? null : "Please Enter Your Email",
                      inputDecoration:
                          signInInputDecoration(hintText: "Email Address"),
                      onDiff: (value) {
                        kCorrectEmail = false;
                        submit(value, 1);
                        print(value);
                      },
                      hideText: false,
                      checkIcon: (kCorrectEmail)
                          ? inputCheck(amTheme.green)
                          : inputCheck(amTheme.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: InputTextField(
                        fieldController: passwordController,
                        fieldValidator: (val) => val.length < 8
                            ? "Please enter more than 8 chars"
                            : null,
                        inputDecoration:
                            signInInputDecoration(hintText: "Password"),
                        onDiff: (value) {
                          submit(value, 2);
                          print(value);
                        },
                        hideText: true,
                        checkIcon: (kCorrectPass)
                            ? inputCheck(amTheme.green)
                            : inputCheck(amTheme.white)),
                  ),
                  SignInBar(
                    label: 'Sign in',
                    isLoading: loginProvider.isLoading,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        print("Email: ${emailController.text}");
                        print("Password: ${passwordController.text}");

                        await loginProvider.login(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                        loginProvider.setMessage(null);
                        Navigator.of(context).pushReplacement(
                          new MaterialPageRoute(
                            builder: (BuildContext context) {
                              return Home();
                            },
                          ),
                        );
                      }
                      // _buttonChange();
                      // context.signInWithEmailAndPassword();
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        loginProvider.setMessage(null);
                        widget.onRegisterClicked?.call();
                      },
                      child: Styles.regular('Sign up',
                          fontSize: 16.sp,
                          underline: true,
                          color: Palette.darkBlue),
                    ),
                  ),
                  HSpace(10.h),
                  if (loginProvider.errorMessage != null)
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                      color: Colors.amberAccent,
                      child: ListTile(
                        title: Center(
                          child: Text(
                            loginProvider.errorMessage,
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ),
                        leading: Icon(
                          Icons.error,
                          size: 12.sp,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 12.sp,
                          ),
                          onPressed: () => loginProvider.setMessage(null),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

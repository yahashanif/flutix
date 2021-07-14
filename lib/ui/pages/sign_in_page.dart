part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigningIn = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToSplashPage());
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 70,
                      child: Image.asset("assets/logo.png"),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 70, bottom: 40),
                      child: Text(
                        "Welcome Back,\nExplorer!",
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                    ),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          isEmailValid = EmailValidator.validate(text);
                        });
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Email Address",
                          hintText: "Email Address"),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          isPasswordValid = text.length >= 6;
                        });
                      },
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Password",
                          hintText: "Password"),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Forgot Password? ",
                          style: greyTextFont.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "Get Now",
                          style: purpleTextFont.copyWith(fontSize: 12),
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.only(top: 40, bottom: 30),
                        child: isSigningIn
                            ? SpinKitFadingCircle(
                                color: mainColor,
                              )
                            : FloatingActionButton(
                                elevation: 0,
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: isEmailValid && isPasswordValid
                                      ? Colors.white
                                      : Color(0xFFBEBEBE),
                                ),
                                backgroundColor: isEmailValid && isPasswordValid
                                    ? mainColor
                                    : Color(0xFFE4E4E4),
                                onPressed: isEmailValid && isPasswordValid
                                    ? () async {
                                        setState(() {
                                          isSigningIn = true;
                                        });
                                        SigninSignUpResult result =
                                            await AuthServices.signIn(
                                                emailController.text,
                                                passwordController.text);

                                        if (result.user == null) {
                                          setState(() {
                                            isSigningIn = false;
                                          });

                                          Get.snackbar("", "",
                                              backgroundColor:
                                                  Color(0xFFFF5C83),
                                              icon: Icon(
                                                Icons.info_outline,
                                                color: Colors.white,
                                              ),
                                              titleText: Text(
                                                "Failed",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              messageText: Text(
                                                result.message,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white),
                                              ));
                                        }
                                      }
                                    : null,
                              ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Start Fresh Now?",
                          style: greyTextFont.copyWith(
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "Sign In",
                          style: purpleTextFont,
                        )
                      ],
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

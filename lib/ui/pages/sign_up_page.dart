part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;
  SignUpPage(this.registrationData);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSplashPage());
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 22),
                    height: 56,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(GoToSplashPage());
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Create New\nAccount",
                            style: blackTextFont.copyWith(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 90,
                    height: 104,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image:
                                      (widget.registrationData.profileImage ==
                                              null
                                          ? AssetImage("assets/user_pict.png")
                                          : FileImage(widget
                                              .registrationData.profileImage)),
                                  fit: BoxFit.cover)),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () async {
                              if (widget.registrationData.profileImage ==
                                  null) {
                                widget.registrationData.profileImage =
                                    await getImage();
                              } else {
                                widget.registrationData.profileImage = null;
                              }
                              setState(() {});
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage((widget.registrationData
                                                  .profileImage ==
                                              null)
                                          ? "assets/btn_add_photo.png"
                                          : "assets/btn_remove_photo.png"))),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Full Name",
                        hintText: "Full Name"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
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
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Password",
                        hintText: "Password"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: retypePasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Confirm Password",
                        hintText: "Confirm Password"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FloatingActionButton(
                      elevation: 0,
                      backgroundColor: mainColor,
                      child: Icon(Icons.arrow_forward),
                      onPressed: () {
                        if (!(nameController.text.trim() != "" &&
                            emailController.text.trim() != "" &&
                            passwordController.text.trim() != "" &&
                            retypePasswordController.text.trim != "")) {
                          Get.snackbar("", "",
                              backgroundColor: Color(0xFFFF5C83),
                              icon: Icon(
                                Icons.info_outline,
                                color: Colors.white,
                              ),
                              titleText: Text(
                                "Failed",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              messageText: Text(
                                "Please fill all the fields",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ));
                        } else if (passwordController.text.trim() !=
                            retypePasswordController.text.trim()) {
                          Get.snackbar("", "",
                              backgroundColor: Color(0xFFFF5C83),
                              icon: Icon(
                                Icons.info_outline,
                                color: Colors.white,
                              ),
                              titleText: Text(
                                "Failed",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              messageText: Text(
                                "Mismatch password and confirmed password",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ));
                        } else if (passwordController.text.length < 6) {
                          Get.snackbar("", "",
                              backgroundColor: Color(0xFFFF5C83),
                              icon: Icon(
                                Icons.info_outline,
                                color: Colors.white,
                              ),
                              titleText: Text(
                                "Failed",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              messageText: Text(
                                "Password's length min 6 characters",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ));
                        } else if (!EmailValidator.validate(
                            emailController.text)) {
                          Get.snackbar("", "",
                              backgroundColor: Color(0xFFFF5C83),
                              icon: Icon(
                                Icons.info_outline,
                                color: Colors.white,
                              ),
                              titleText: Text(
                                "Failed",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              messageText: Text(
                                "Wrong formatted email address",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ));
                        } else {
                          widget.registrationData.name = nameController.text;
                          widget.registrationData.email = emailController.text;
                          widget.registrationData.password =
                              passwordController.text;

                          context
                              .bloc<PageBloc>()
                              .add(GoToPreferencePage(widget.registrationData));
                        }
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:infinits_v1/screens/Homepage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color myColor = Color.fromARGB(255, 246, 198, 127);
  bool isRemember = false;
  bool isObscure = true;
  //define primary
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: myColor,
          image: DecorationImage(
            image: const AssetImage("assets/back1.png"),
            fit: BoxFit.cover,
            // colorFilter:
            //     ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.dstATop),
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
                top: 80,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/im_sq_black.png",
                        scale: 2,
                        filterQuality: FilterQuality.high,
                      )
                    ],
                  ),
                )),
            Positioned(
              bottom: 0,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Color.fromARGB(218, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Column(children: [
                        Text(
                          "Login Here",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 60),
                        TextField(
                          controller: TextEditingController(),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_3),
                              hintText: 'Username'),
                        ),
                        const SizedBox(height: 40),
                        TextField(
                          obscureText: isObscure,
                          controller: TextEditingController(),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password_rounded),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    if (isObscure == true) {
                                      setState(() {
                                        isObscure = false;
                                      });
                                    } else {
                                      setState(() {
                                        isObscure = true;
                                      });
                                    }
                                  },
                                  child: Icon(Icons.remove_red_eye)),
                              hintText: 'Password'),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Checkbox(
                                  value: isRemember,
                                  onChanged: (value) {
                                    setState(() {
                                      isRemember = value!;
                                    });
                                  }),
                              Text(
                                "Remember Me",
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ]),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot password ?",
                                style: const TextStyle(color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Homepage(),
                                  ));
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            elevation: 20,
                            shadowColor: myColor,
                            backgroundColor: Colors.green[700],
                            minimumSize: const Size.fromHeight(60),
                          ),
                          child: const Text(
                            "LOGIN",
                            style:
                                TextStyle(color: Colors.yellow, fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ]),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

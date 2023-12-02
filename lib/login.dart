import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyPage());
  }
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            height: Get.height * 0.6,
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: Get.height * 0.5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                border: Border.all(
                  color: Colors.red,
                  width: 1.0,
                ),
                color: Colors.red,
              ),
              height: Get.height,
              // color:
            ),
          ),
        ],
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Card(
                margin: EdgeInsets.zero,
                child: Container(
                  color: Colors.grey,
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 50,
              right: 50,
              child: Image.asset(
                "assest/images/polytokLogoImg.png",
                height: 50,
                width: 100,
              ),
            ),
            Positioned(
              bottom: 0,
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    border: Border.all(
                      color: const Color(0xff0099cc),
                      width: 1.0,
                    ),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff0099cc),
                        Colors.white,
                      ],
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Sign In",
                          style: TextStyle(color:Colors.white,fontSize: 28,fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          decoration: buildInputDecorationTheme(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: buildInputDecorationTheme(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "Forget Password",
                              style: TextStyle(
                                  fontSize: 16, decoration: TextDecoration.underline),
                            )),

                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: ElevatedButton(
                                onPressed: () {}, child: const Text("Submit"))),
                        // Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  InputDecoration buildInputDecorationTheme() {
    return const InputDecoration(
      filled: true,
      fillColor: Color(0xffE9EFFF),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(7),
        ),
      ),
      hintStyle: TextStyle(
          color: Color(0xff8A8686), fontWeight: FontWeight.w500, fontSize: 16),
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
    );
  }
}

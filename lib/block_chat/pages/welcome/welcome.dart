import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learn_test/block_chat/pages/welcome/bloc/welcome_blocks.dart';
import 'package:learn_test/block_chat/pages/welcome/bloc/welcome_events.dart';
import 'package:learn_test/block_chat/pages/welcome/bloc/welcome_state.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: BlocBuilder<WelcomeBloc, WelcomeState>(
          builder: (context, state) => SizedBox(
            width: 375.w,
            child: Stack(
              children: [
                PageView(
                  controller: pageController,
                  onPageChanged: (int index) {
                    state.page = index;
                    BlocProvider.of<WelcomeBloc>(context).add(WelcomeEvent());
                  },
                  children: [
                    _page(
                        1,
                        context,
                        "Next",
                        "First See Learning",
                        "Forget about a for of paper all knowledge in one learning",
                        "assets/images/reading.png"),
                    _page(
                        1,
                        context,
                        "Next",
                        "Connect with Every one",
                        "Always keep in with your tutor & friend.Let,s get connect it ",
                        "assets/images/boy.png"),
                    _page(
                        1,
                        context,
                        "Get Started",
                        "Always Fascinated Learning",
                        "Anywhere, anytime. The time is at your discretion so study whenever you want.",
                        "assets/images/man.png"),
                  ],
                ),
                Positioned(
                  bottom: 100.h,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => InkWell(
                        onTap: () {
                          state.page = index;
                          pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.ease,
                          );
                           // setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Container(
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: Colors.black,
                                width: 1, // Specify the width of the border
                              ),
                              color: state.page == index
                                  ? Colors.green
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _page(int index, BuildContext context, String buttonName, String title,
      String subTitle, String imageUrl) {
    return Column(
      children: [
        SizedBox(
          width: 345.w,
          height: 345.w,
          child: Image.asset(imageUrl,fit: BoxFit.cover,),
        ),
        Container(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.normal),
          ),
        ),
        Container(
          width: 375.w,
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: Text(
            subTitle,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        GestureDetector(
          onTap: (){
            if(index<3){
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.decelerate,
              );
            }else{

            }
            },
          child: Container(
            margin: EdgeInsets.only(top: 100.h, left: 25.w, right: 25.w),
            width: 325.w,
            height: 50.h,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15.w),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(10, 10),
                  )
                ]),
            child: Center(
              child: Text(
                buttonName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        )
      ],
    );
  }
}

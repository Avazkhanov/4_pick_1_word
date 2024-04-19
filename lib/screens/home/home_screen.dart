// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:words_game/cubits/home_cubit/home_cubit.dart';
import 'package:words_game/cubits/home_cubit/home_state.dart';
import 'package:words_game/screens/home/widgets/letter_item.dart';
import 'package:words_game/utils/app_images/app_images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(builder: (context, state) {
        return Center(
            child: Stack(
          children: [
            Image.asset(
              AppImages.background,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Expanded(
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.image.length,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.w,
                        mainAxisSpacing: 15.h),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: Image.asset(state.image[index], height: 50.h),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    ...List.generate(
                      state.currentQuestion.length,
                      (index) => GestureDetector(
                        onTap: () {
                          context.read<HomeCubit>().removeLastLetter();
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10, bottom: 10),
                          width: 50,
                          height: 60,
                          decoration: BoxDecoration(
                            color: index < state.inputAnswer.length
                                ? Colors.blue
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 3,
                              color: Colors.blue,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              index < state.inputAnswer.length
                                  ? state.inputAnswer[index]
                                  : "",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: List.generate(
                    state.shuffledLetters.length,
                    (index) => LetterItem(
                      title: state.shuffledLetters[index],
                      onPressed: () {
                        context
                            .read<HomeCubit>()
                            .addLetter(state.shuffledLetters[index]);
                        context
                            .read<HomeCubit>()
                            .removeLetter(state.shuffledLetters[index]);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 40.h)
              ],
            ),
          ],
        ));
      }, listener: (BuildContext context, HomeState state) {
        var cubit = context.read<HomeCubit>().isEnded;
        if(cubit){
          showDialog(context: context, builder: (context){
            return AlertDialog(
              backgroundColor: Colors.blueGrey,
              title: Text("Congratulations!"),
              content: Text("You won!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    context.read<HomeCubit>().restartGame();
                  },
                  child: Text("Restart"),
                )
              ],
            );
          });
        }
      },),
    );
  }
}

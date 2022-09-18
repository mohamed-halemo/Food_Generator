import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<MealsBloc, MealsState>(builder: (context, state) {
      checkLiked();
      if (state is MealsLoadedState) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    color: Color(0xffFBCEDC),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //LikeButton
                            LikeButton(
                              size: 30,
                              isLiked: state.meals.liked,
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  Icons.favorite,
                                  color: isLiked
                                      ? Color(0xffFF5F99)
                                      : Colors.white,
                                  size: 30,
                                );
                              },
                              onTap: (isLiked) {
                                return onLikeButtonTapped(
                                    isLiked, state.meals.id);
                              },
                            ),
                          ],
                        ),
                        Image.network(
                          state.meals.image,
                          width: 400,
                          height: 500,
                          fit:BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          state.meals.name,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25, bottom: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffFF5F99),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () => {
                context.read<MealsBloc>().add(LoadMealsEvent()),
              },
              child: Icon(
                Icons.refresh_rounded,
                size: 45,
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xffFF5F99),
                padding: EdgeInsets.all(25),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                textStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 25,
                ),
              ),
            ),
          ),
        );
      } else if (state is MealsLoadErrorState) {
        // context.read<MealsBloc>().add(LoadMealsEvent());
        return Scaffold(
            body: SafeArea(
          child: Center(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
          Container(
            // padding: EdgeInsets.all(16.0),
            child: Text(
              'Error...',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 17,
                color: Color(0xffFF5F99),
              ),
            ),
          ),
          Container(
            // padding: EdgeInsets.all(16.0),
            child: TextButton(
              child: Icon(
                Icons.refresh_rounded,
                color: Color(0xffFF5F99),
                size: 30,
              ),
              onPressed: () => {
                context.read<MealsBloc>().add(LoadMealsEvent()),
              },
            ),
          ),
        ]))));
      } else {
        return const Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              color: Color(0xffFF5F99),
            ),
          ),
        );
      }
    }));
  }
}

Future<bool> onLikeButtonTapped(bool isLiked, String id) async {
  final prefs = await SharedPreferences.getInstance();
  List<String>? currentList = prefs.getStringList("favourites") ?? [];
  if (!isLiked) {
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    currentList.add("$id;$time");
    await prefs.setStringList("favourites", currentList);
  } else {
    currentList.removeWhere((item) => item.split(';')[0] == id);
    await prefs.setStringList("favourites", currentList);
  }
  return !isLiked;
}

void checkLiked() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> currentList = prefs.getStringList("favourites") ?? [];
  if (currentList.isNotEmpty) {
    currentList.removeWhere((item) =>
        DateTime.now().millisecondsSinceEpoch - int.parse(item.split(';')[1]) >=
        1000 * 60 * 60 * 24 * 30);
    await prefs.setStringList("favourites", currentList);
  } else {
    await prefs.setStringList("favourites", []);
  }
}

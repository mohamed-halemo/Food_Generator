import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:image_loader/image_helper.dart';
import 'package:myapp/repository/repository.dart';
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
  Widget build(BuildContext context){
    return Scaffold(
      body: BlocBuilder<MealsBloc, MealsState>(
          builder: (context, state) {
              checkLiked();
            if (state is MealsLoadedState){
            return Column(children: [
        Expanded(
          child: ImageHelper(
            imageType: ImageType.network,
            imageShape: ImageShape.rectangle,
            width: MediaQuery.of(context).size.width-300,
            height: MediaQuery.of(context).size.height-300,
            boxFit: BoxFit.fill,
            // scale: 1.0,
            // imagePath: 'assets/images/image.png',
            image: state.meals.image,
            defaultLoaderColor: Colors.red,
            defaultErrorBuilderColor: Colors.blueGrey,
          ),
        ),
        Row(
          children: [
            Text(
              state.meals.name,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500, // light
              ),
            ),
            TextButton(child: Text('Retry',style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500, // light
              ),),onPressed: () => {context.read<MealsBloc>().add(LoadMealsEvent()),},),
            LikeButton(
              size: 30,isLiked: state.meals.liked,
               onTap: (isLiked) {
                    return onLikeButtonTapped(isLiked,state.meals.id);
                  },
            ),
          ],
        )
      ]);
      }else if(state is MealsLoadErrorState){
        // context.read<MealsBloc>().add(LoadMealsEvent());
        return Center(child: Text('Error...'),);
      }
      else{
        return Center(child: Text('Loading...'),);
      }
          })
    );
  }
}
Future<bool> onLikeButtonTapped(bool isLiked,String id) async{
    final prefs = await SharedPreferences.getInstance();
    List<String>? currentList = prefs.getStringList("favourites") ?? [];
    print(currentList);
    if(!isLiked){
      currentList.add(id);
      await prefs.setStringList("favourites", currentList);
    }
    else{
      currentList.remove(id);
      await prefs.setStringList("favourites", currentList);
    }
    return !isLiked;
}
void checkLiked() async{
  final prefs = await SharedPreferences.getInstance();
  List<String>? currentList = prefs.getStringList("favourites");
  print(currentList);
  // await prefs.setStringList("favourites", []);
}
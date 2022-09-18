import 'package:flutter/material.dart';
import 'package:myapp/blocs/meals/meals_bloc.dart';
import 'package:myapp/repository/repository.dart';
import 'package:myapp/screens/Home_screen.dart';
import 'package:myapp/screens/Start_screen.dart';
import 'package:myapp/services/services.dart';
import 'home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => MealsRepository(mealsService: MealsService()),
      child: BlocProvider<MealsBloc>(
        create: (context) =>
            MealsBloc(RepositoryProvider.of<MealsRepository>(context))
              ..add(LoadMealsEvent()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Meals',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home:  StarterScreen(),
        ),
      ),
    );
  }
}


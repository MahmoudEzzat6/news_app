import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/shared/cubit/blocObserver.dart';
import 'package:udemy/shared/cubit/cubit.dart';
import 'package:udemy/shared/cubit/states.dart';
import 'package:udemy/shared/dio_helper.dart';
import 'package:udemy/shared/local.dart';

import 'layout/home_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();
  bool? isDark = CashHelper.getBool(key: 'isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
            ..getSports()
            ..getScience()
          ,
        ),
        BlocProvider(
            create: (context) => AppCubit()
              ..getBusniess()
              ..changeMode(shared: isDark))
      ],
      child: BlocConsumer<AppCubit, NewsStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark),
                  color: Colors.white,
                  elevation: 0.0,
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.red,
                ),
              ),
              darkTheme: ThemeData(
                scaffoldBackgroundColor: Colors.grey[900],
                appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.grey[900],
                      statusBarIconBrightness: Brightness.light),
                  color: Colors.grey[900],
                  elevation: 0.0,
                  textTheme: TextTheme(
                    bodyText1: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.red,
                  backgroundColor: Colors.grey[900],
                  unselectedItemColor: Colors.grey,
                ),
              ),
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: HomeLayout(),
            );
          }),
    );
  }
}

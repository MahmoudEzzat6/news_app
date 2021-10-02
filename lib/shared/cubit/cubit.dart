import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/moduols/busniess_news.dart';
import 'package:udemy/moduols/science_news.dart';
import 'package:udemy/moduols/sports_news.dart';
import 'package:udemy/shared/cubit/states.dart';
import 'package:udemy/shared/local.dart';

import '../dio_helper.dart';

class AppCubit extends Cubit<NewsStates> {
  AppCubit() : super(InitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
  ];
  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business_rounded),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_football),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: 'Science',
    ),
  ];

  void ChangeBottomItem(int index) {
    if (index == 1) getSports();
    if (index == 2) getScience();
    currentIndex = index;
    emit(BottomSheetStates());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  void getBusniess() {
    emit(BusinessLoadingStates());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '51ae57c82ada474cb2376f3c6f3d43de'
    }).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(BusinessSuccessGetStates());
    }).catchError((error) {
      print(error.toString());
      emit(BusinessErrorStates(error.toString()));
    });
  }

  void getSports() {
    emit(SportsLoadingStates());
    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '51ae57c82ada474cb2376f3c6f3d43de'
      }).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(SportsSuccessGetStates());
      }).catchError((error) {
        print(error.toString());
        emit(SportsErrorStates(error.toString()));
      });
    } else {
      emit(SportsSuccessGetStates());
    }
  }

  void getScience() {
    if (science.length == 0) {
      emit(BusinessLoadingStates());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '51ae57c82ada474cb2376f3c6f3d43de'
      }).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(ScienceSuccessStates());
      }).catchError((error) {
        print(error.toString());
        emit(ScienceErrorStates(error.toString()));
      });
    } else {
      emit(ScienceSuccessStates());
    }
  }

  void getSearch(String value) {
    emit(SearchLoadingStates());

    search = [];

    DioHelper.getData(
        url: 'v2/everything',
        query: {
      'q': '$value',
      'apiKey': '51ae57c82ada474cb2376f3c6f3d43de'
    }).then((value) {
      search = value.data['articles'];
      emit(SearchSuccessStates());
    }).catchError((error) {
      emit(SearchErrorStates(error));
      print(error.toString());
    });
  }

  bool isDark = true;
  ThemeMode? appMode;

  void changeMode({bool? shared}) {
    if (shared != null) {
      isDark = shared;
      emit(ChangeModeState());
    } else {
      isDark = !isDark;
      CashHelper.putBool(key: 'isDark', value: isDark).then((value) {
        emit(ChangeModeState());
      });
    }
  }
}

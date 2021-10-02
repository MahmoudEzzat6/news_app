

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/componanes/componanes.dart';
import 'package:udemy/main.dart';
import 'package:udemy/moduols/search/search_screen.dart';
import 'package:udemy/shared/cubit/cubit.dart';
import 'package:udemy/shared/cubit/states.dart';
import 'package:udemy/shared/dio_helper.dart';

class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,NewsStates>(
      listener: (BuildContext context, state) {
      },
      builder: (BuildContext context,  state) {
        Center(child: CircularProgressIndicator());
        var cubit= AppCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          appBar: AppBar(
            title: Text(
              'NewsApp',
              style: Theme.of(context).textTheme.bodyText1
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6.0
                ),
                child: IconButton(
                    onPressed:(){
                       navigateTo(context, SearchScreen());
                    },
                    icon: Icon(Icons.search),
                ),
              ),
              IconButton(
                onPressed:(){
                 AppCubit.get(context).changeMode();

                 },
                icon: Icon(Icons.brightness_4_sharp),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
             items: cubit.bottomItem,
            onTap: (index){
               cubit.ChangeBottomItem(index);
            },
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );


  }
}


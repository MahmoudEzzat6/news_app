import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:udemy/componanes/componanes.dart';
import 'package:udemy/shared/cubit/cubit.dart';
import 'package:udemy/shared/cubit/states.dart';

class SportScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var news= AppCubit.get(context).sports;
        return  articaleBuilder(news,context);
      },
    );

  }
}

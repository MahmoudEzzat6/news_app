import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:udemy/componanes/componanes.dart';
import 'package:udemy/shared/cubit/cubit.dart';
import 'package:udemy/shared/cubit/states.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var news= AppCubit.get(context).business;
        return articaleBuilder(news,context);
      },
    );
  }
}

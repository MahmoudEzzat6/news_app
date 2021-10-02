import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/componanes/componanes.dart';
import 'package:udemy/shared/cubit/cubit.dart';
import 'package:udemy/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {

  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var news=AppCubit.get(context).search;
    return BlocConsumer<AppCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextField(
                  label: 'Search',
                  prefix: Icons.search,
                  controller: searchController,
                  onValidate: (String? value ) {
                    if(value!.isEmpty){
                      print(value);
                      return 'Search Cannot be Empty';
                    }
                  },
                  onChange: (String value){
                    AppCubit.get(context).getSearch(value);
                    print(value);
                  }
                ),
              ),
              articaleBuilder(news, context),
            ],
          ),
        );
      } ,
    );
  }
}

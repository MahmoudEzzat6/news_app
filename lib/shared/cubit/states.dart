import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:udemy/shared/cubit/cubit.dart';

abstract class NewsStates {}

class InitialStates extends NewsStates{}

class BottomSheetStates extends NewsStates{}

class BusinessLoadingStates extends NewsStates{

}

class BusinessErrorStates extends NewsStates{
  final String error;
  BusinessErrorStates(this.error);
}

class BusinessSuccessGetStates extends NewsStates{}

class SportsLoadingStates extends NewsStates{}

class SportsSuccessGetStates extends NewsStates{}

class SportsErrorStates extends NewsStates{
  final String error;

  SportsErrorStates(this.error);
}

class ScienceLoadingStates extends NewsStates{}

class ScienceSuccessStates extends NewsStates{}

class ScienceErrorStates extends NewsStates{
  final String error;

  ScienceErrorStates(this.error);

}

class SearchLoadingStates extends NewsStates{}

class SearchSuccessStates extends NewsStates{}

class SearchErrorStates extends NewsStates{
  final String error;

  SearchErrorStates(this.error);

}
class ChangeModeState extends NewsStates{}

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
class SimpleBlocObserver  extends BlocObserver{

@override
void onCreate(BlocBase bloc){
  super.onCreate(bloc);
  log("on create -- bloc: ${bloc.runtimeType}");
}

@override
void onEvent(Bloc bloc , Object? event){
  super.onEvent(bloc,event);
  log("on Event -- bloc: ${bloc.runtimeType} , event: $event");
}
@override
void onChange(BlocBase bloc , Change change){
  super.onChange(bloc, change);
  log("on Change -- bloc: ${bloc.runtimeType}, change: $change");
  log( change.toString());
}
@override
void onTransition(Bloc bloc, Transition transition){
  super.onTransition(bloc,transition);
  log("onTransition -- bloc: ${bloc.runtimeType}, transition: $transition");
}

@override
void onError(BlocBase bloc, Object error ,StackTrace stackTrace){
  super.onError(bloc,error,stackTrace);
  log("onError -- bloc: ${bloc.runtimeType}, error: $error");
}

@override
void onClose(BlocBase bloc){
  super.onClose(bloc);
  log("onClose -- bloc: ${bloc.runtimeType},");
}

}
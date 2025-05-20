import 'package:brain_rivals/bloc_observer.dart';
import 'package:brain_rivals/blocs/auth_bloc/auth_bloc.dart';
import 'package:brain_rivals/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:brain_rivals/blocs/update_bloc/update_user_info_bloc.dart';
import 'package:brain_rivals/constant.dart';
import 'package:brain_rivals/screens/login_screen.dart';
import 'package:brain_rivals/screens/mobile_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:user_repository/user_repository.dart';

void main() async {

WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
Gemini.init(apiKey: geminiApiKey,);

  // Bloc Observer
Bloc.observer = SimpleBlocObserver();
runApp( MyApp());
}


class MyApp extends StatelessWidget {
  final FirebaseUserRepository userRepository = FirebaseUserRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (_) => userRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (_) => AuthBloc(myUserRepository: userRepository),
          ),

          BlocProvider(
              create: (context) => UpdateUserInfoBloc(userRepository: context.read<AuthBloc>().userRepository)),

          BlocProvider(
            create: (context) {
              final authBloc = context.read<AuthBloc>();
              
              if (authBloc.state is AuthAuthenticated) {
                final authenticatedState = authBloc.state as AuthAuthenticated;
                return MyUserBloc(myUserRepository: authBloc.userRepository)
                  ..add(GetMyUser(myUserId: authenticatedState.user.uid));
                            }
              
              return MyUserBloc(myUserRepository: authBloc.userRepository);
            },
          ),
            
        ],
        child: MaterialApp(
          title: "Twitter Clone",
          // Aşağıya bir tema tanımlayabilirsiniz
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
             if (state is  AuthAuthenticated){
              context.read<MyUserBloc>().add(GetMyUser(myUserId: state.user.uid));
             }
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthAuthenticated) {
                  
                  return const MobileLayout()  ;
                } else {
                  return const LoginScreen();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
} 


/* class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: LoginScreen()
    );
  }
} */
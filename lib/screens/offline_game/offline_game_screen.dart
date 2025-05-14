import 'package:brain_rivals/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:brain_rivals/constant.dart';

import 'package:brain_rivals/widgets/soru_cevap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lottie/lottie.dart';

class OfflineGameScreen extends StatefulWidget {
    final String text;
  
  final String categoryName;
  final IconData icon;
  const OfflineGameScreen({super.key, required this.text, required this.categoryName, required this.icon});

  @override
  State<OfflineGameScreen> createState() => _OfflineGameScreenState();
}

class _OfflineGameScreenState extends State<OfflineGameScreen> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color.fromARGB(255, 234, 254, 218),
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            
            backgroundColor: kPrimaryLightColor,
            content: const Text("Ayrılmak istediğinize emin misiniz?" , style: TextStyle(fontWeight: FontWeight.bold),),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),
                onPressed: () {
                  Navigator.of(context).pop(); // Dialog'u kapat
                },
                child: const Text("Hayır" , style: TextStyle(color: Colors.white),),
              ),
              ElevatedButton(
                 style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text("Evet"  , style: TextStyle(color: Colors.white)),
              ),
                ],
              )
         
            ],
          );
        },
      );
        }, icon: const Icon(Icons.exit_to_app_outlined)),
        backgroundColor: const Color.fromARGB(255, 234, 254, 218),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<MyUserBloc, MyUserState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     SizedBox(height: 100, width: 100,child: Image.asset("assets/images/gaga.png")),
                    Column(
                      children: [
                        CircleAvatar(
                                      radius: 40,
                                      backgroundImage: state.user?.picture != null
                      ? AssetImage(state.user!.picture!)
                      : const AssetImage('assets/bilim.png') as ImageProvider,
                                    ),
                                    Container(decoration:const BoxDecoration(
                                      color: Colors.white , borderRadius: BorderRadius.all(Radius.circular(12))
                                    ) , child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 40),
                                      child: Text(state.user!.name , style: const TextStyle(fontSize: 16 , fontWeight: FontWeight.bold),),
                                    ))
                      ],
                    ), 

                     SizedBox(height: 100, width: 100,child: Lottie.asset("assets/lottie/lot02.json"),)
                  ],
                );
              },
            ),
        
           
            Container(
              
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child:  QuizQuestionWidget(
                
                    text: widget.text,
    categoryName:widget.categoryName,
    icon:widget.icon
              )
            ),
          ],
        ),
      )
    );
  }
}




 /* Column(
          children: [
            QuestionWidget(question: _question[index].title, indexAction: index, totalQuestions: _question.length), 
            const Divider(color: Colors.grey,), 
            const SizedBox(height: 30,),
            
            for (int i = 0; i < _question[index].options.length; i++)
  OptionCard(
    press: () {
      changePress(_question[index].options.keys.toList()[i]);
    },
    option: _question[index].options.keys.toList()[i],
    color: !isPressed
        ? Colors.white
        : _question[index].options.keys.toList()[i] == selectedAnswer
            ? _question[index].options.values.toList()[i] == true
                ? correct // Doğru seçilen kart yeşil
                : incorrect // Yanlış seçilen kart kırmızı
            : _question[index].options.values.toList()[i] == true
                ? correct // Doğru cevap yeşil gösterilir
                : Colors.white, // Diğer kartlar beyaz kalır
    isSelected: isPressed &&
        _question[index].options.keys.toList()[i] == selectedAnswer,
  )

          ],
        ), */


/* import 'package:brain_rivals/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:brain_rivals/constant.dart';

import 'package:brain_rivals/widgets/soru_cevap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lottie/lottie.dart';
import 'package:user_repository/user_repository.dart';

class OfflineGameScreen extends StatefulWidget {
    final String text;
  final MyUser? friend;
  final String categoryName;
  final IconData icon;
  const OfflineGameScreen({super.key, required this.text, required this.categoryName, required this.icon, this.friend});

  @override
  State<OfflineGameScreen> createState() => _OfflineGameScreenState();
}

class _OfflineGameScreenState extends State<OfflineGameScreen> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color.fromARGB(255, 234, 254, 218),
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            
            backgroundColor: kPrimaryLightColor,
            content: const Text("Ayrılmak istediğinize emin misiniz?" , style: TextStyle(fontWeight: FontWeight.bold),),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),
                onPressed: () {
                  Navigator.of(context).pop(); // Dialog'u kapat
                },
                child: const Text("Hayır" , style: TextStyle(color: Colors.white),),
              ),
              ElevatedButton(
                 style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text("Evet"  , style: TextStyle(color: Colors.white)),
              ),
                ],
              )
         
            ],
          );
        },
      );
        }, icon: const Icon(Icons.exit_to_app_outlined)),
        backgroundColor: const Color.fromARGB(255, 234, 254, 218),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<MyUserBloc, MyUserState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     SizedBox(height: 100, width: 100,child: Image.asset("assets/images/gaga.png")),
                    Column(
                      children: [
                        CircleAvatar(
                                      radius: 40,
                                      backgroundImage: state.user?.picture != null
                      ? AssetImage(state.user!.picture!)
                      : const AssetImage('assets/bilim.png') as ImageProvider,
                                    ),
                                    Container(decoration:const BoxDecoration(
                                      color: Colors.white , borderRadius: BorderRadius.all(Radius.circular(12))
                                    ) , child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 40),
                                      child: Text(state.user!.name , style: const TextStyle(fontSize: 16 , fontWeight: FontWeight.bold),),
                                    ))
                      ],
                    ), 

                     SizedBox(height: 100, width: 100,child: Lottie.asset("assets/lottie/lot02.json"),)
                  ],
                );
              },
            ),
        
           
            Container(
              
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child:  QuizQuestionWidget(
                friend: widget.friend,
                    text: widget.text,
    categoryName:widget.categoryName,
    icon:widget.icon
              )
            ),
          ],
        ),
      )
    );
  }
}
 */



 /* Column(
          children: [
            QuestionWidget(question: _question[index].title, indexAction: index, totalQuestions: _question.length), 
            const Divider(color: Colors.grey,), 
            const SizedBox(height: 30,),
            
            for (int i = 0; i < _question[index].options.length; i++)
  OptionCard(
    press: () {
      changePress(_question[index].options.keys.toList()[i]);
    },
    option: _question[index].options.keys.toList()[i],
    color: !isPressed
        ? Colors.white
        : _question[index].options.keys.toList()[i] == selectedAnswer
            ? _question[index].options.values.toList()[i] == true
                ? correct // Doğru seçilen kart yeşil
                : incorrect // Yanlış seçilen kart kırmızı
            : _question[index].options.values.toList()[i] == true
                ? correct // Doğru cevap yeşil gösterilir
                : Colors.white, // Diğer kartlar beyaz kalır
    isSelected: isPressed &&
        _question[index].options.keys.toList()[i] == selectedAnswer,
  )

          ],
        ), */


import 'package:brain_rivals/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:brain_rivals/constant.dart';
import 'package:brain_rivals/screens/ai_screens/ui.dart';
import 'package:brain_rivals/screens/mobile_layout.dart';


import 'package:brain_rivals/widgets/soru_cevap_widget_online.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:user_repository/user_repository.dart';

class OnlineGameScreen extends StatefulWidget {
    final String text;
    final String challengeID;
    final bool isChallenger;
  final MyUser? friend;
  final String categoryName;
  final IconData icon;
  const OnlineGameScreen({super.key, required this.text, required this.categoryName, required this.icon, this.friend, required this.challengeID, required this.isChallenger});

  @override
  State<OnlineGameScreen> createState() => _OfflineGameScreenState();
}

class _OfflineGameScreenState extends State<OnlineGameScreen> {


 late final FirebaseUserRepository userRepo;
Future<void> _handleChallengeCompletion(String challengeID) async {
try {
    final challengeDoc = await FirebaseFirestore.instance
        .collection('challenges')
        .doc(challengeID)
        .get();

    final data = challengeDoc.data()!;
    final challengerScore = data['challengerScore'] as int;
    final challengedScore = data['challengedScore'] as int;

    if (challengerScore == challengedScore) return;

    final winnerID = challengerScore > challengedScore 
        ? data['challengerID'] 
        : data['challengedID'];
    final loserID = winnerID == data['challengerID'] 
        ? data['challengedID'] 
        : data['challengerID'];

    // İstatistikleri transaction dışında güncelle
    await Provider.of<UserRepository>(context, listen: false)
        .updateUserStats(winnerID, loserID);
  } catch (e) {
    print("Hata: $e");
  }
  
}
  @override
  void initState() {
    super.initState();

    // FirebaseAuth'ten current user ID alınıyor
    

    // UserRepository örneği oluşturuluyor ve instance değişkene atılıyor
    userRepo = FirebaseUserRepository();
  }
bool _hasNavigatedToYapayZeka = false;

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
                onPressed: () async {
                      // Skoru sıfırla ve çık
            await  userRepo.updateChallengeScore(
                widget.challengeID,
                widget.isChallenger,
                0
              );
               if (!widget.isChallenger){
    await  _handleChallengeCompletion( widget.challengeID);

   }
    if (!widget.isChallenger) {
     
  try {
    await userRepo.completeChallenge(widget.challengeID);
    // Güncelleme başarılıysa burası çalışır
    // Sonraki işlemleriniz burada olabilir
  } catch (e) {
    // Hata yönetimi
  }
}

 
                  Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => const MobileLayout()),
  (Route<dynamic> route) => false,
);
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

                     GestureDetector(
                      onTap: () {
                        if (!_hasNavigatedToYapayZeka) {
                          setState(() {
                            _hasNavigatedToYapayZeka = true;
                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const YapayZekaUi();
                          }));
                        }
                      },
                      child: SizedBox(height: 100, width: 100,child: Lottie.asset("assets/lottie/lot02.json"),))
                  ],
                );
              },
            ),
        
           
            Container(
              
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child:  QuizQuestionOnlineWidget(
                challengeID:widget.challengeID,
                isChallenger:widget.isChallenger,
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


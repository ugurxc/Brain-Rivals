/* // ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brain_rivals/models/question_model.dart';
import 'package:brain_rivals/widgets/next_button.dart';
import 'package:brain_rivals/widgets/option._card.dart';
import 'package:flutter/material.dart';

import 'package:brain_rivals/constant.dart';

class QuizQuestionWidget extends StatefulWidget {
  const QuizQuestionWidget({
    super.key,

    
  });
  


  @override
  State<QuizQuestionWidget> createState() => _QuizQuestionWidgetState();
}

class _QuizQuestionWidgetState extends State<QuizQuestionWidget> {
   Future<void> nextQuestion() async {
    if(index==_question.length -1 && isPressed)
    {
      await  Future.delayed(Durations.medium1);
      showDialog(context: context,  barrierDismissible: false, builder: (context)  {
        
          String message;
          if (score == 0) {
            message = "Tekrar denemelisin";
          } else if (score == 1) {
            message = "Daha çok çalışmalısın" ;
          } else if (score == 2) {
            message = "Fena değil, daha iyisini yapabilirsin!";
          } else if (score == 3) {
            message = "Güzel iş çıkardın, devam et!";
          } else if (score == 4) {
            message = "Harika! Bir adım daha at!";
          } else if (score == 5) {
            message = "Mükemmel! Tüm soruları doğru bildin!";
          } else {
            message = "Sonuç bulunamadı.";
          }
        return  AlertDialog(
          
          backgroundColor: kPrimaryLightColor,
          content: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Yarışma Sona Erdi" , style: TextStyle(fontWeight: FontWeight.bold),), 
                const SizedBox(height: 8,),
                CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  radius: 60,
                  child: Text('$score/5' , style: const TextStyle(color: Colors.white ,fontWeight: FontWeight.bold ),),
                ),
                 const SizedBox(height: 16),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton( style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(kPrimaryColor)), onPressed: () {
                       Navigator.of(context).popUntil((route) => route.isFirst); 
                    
                  }, child: const Text("Çıkış" , style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold )) )

                
              ],
            ),
          ),
        );
      },);
    }
    else {
      if(isPressed){
          setState(() {
      index++;
      isPressed=false;
      isAlreadySelected=false;
    });
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          
          content:Text("lütfen bir cevap seçiniz"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20), 
          
          ));
      }
    
    }
    
    
  }
  void changePress(String selectedOption , bool value ){
 
    
         if(value &&  !isPressed){
       setState(() {
          score++;
          isAlreadySelected=true;
       });

    
      }
      
     
          setState(() {
      isPressed = true;
       selectedAnswer = selectedOption;
       
    });
    
    
    
  }
  final List<Question> _question= [


    Question(id: "10", title: "Fatih Terim galatasary futbol kulübü ile kaç lig şampiyonluğu yaşamıştır? ", options: {"8":true , "7":false ,"9":false ,"10":false }),
     Question(id: "11", title: "Monica Seles ve Steffi Graf hangi spor dalında tanınan ısımlerdir ", options: {"Buz hokeyi":false , "Tenis":true ,"Voleybol":false ,"Hentbol":false }),
      Question(id: "12", title: "Gol çizgisi Teknolojisi hangi spor dalında kullanılmaktadır", options: {"Voleybol":false , "Basketbol":false ,"Su topu":false ,"Futbol":true }),
       Question(id: "13", title: "Formula 1'de en düşük galibiyet farkı kaç saniyedir ", options: {"2.5":false , "0.8":false ,"0.01":true ,"1.2":false }),
       Question(id: "14", title: " 'Akrep Vuruşu' ile ünlenen kaleci hangisidir? ", options: {"Olivar Kahn":false , "Lev Yaşin":false ,"Rene Higuita":true ,"Zoran Simoviç":false }),

  ];
  bool isAlreadySelected = false ;
  int score=0;
  String? selectedAnswer;
  int index=0;
  bool  isPressed= false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 620,
        
      decoration: const BoxDecoration(color: kPrimaryColor  , borderRadius: BorderRadius.only( topLeft: Radius.circular(22) , topRight: Radius.circular(22)))              ,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        
        children: [
          // Üst kısım
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  '${index+1}.',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(Icons.sports_soccer, color: Colors.white, size: 50),
               const Row(
                children: [
                  
                  SizedBox(width: 4),
                  Text(
                    'Spor',
                    style: TextStyle(color: Colors.white, fontSize: 24 , fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Soru
          Container(
            height: 120,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10 ),
            decoration: BoxDecoration(
              
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child:  Text(
              _question[index].title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Cevap seçenekleri
          Column(
            children: [
              for(int i =0 ; i<_question[index].options.length; i++ )
                GestureDetector(
                  onTap: () => changePress(_question[index].options.keys.toList()[i],_question[index].options.values.toList()[i] ),
                  child: OptionCard(
                     /*  press: () {
                        changePress(_question[index].options.keys.toList()[i]);
                      }, */
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
                    ),
                )
             
             
            ],
          ),
          const SizedBox(height: 16),
          // Yardımcı seçenekler
          NextButton(text: "Sıradaki Soru" , press: nextQuestion,)
        ],
      ),
    );
  }

/*   Widget _buildAnswerOption(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          print("object");
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: Colors.white ,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  } */
}
 */

import 'package:brain_rivals/models/question_model.dart';
import 'package:brain_rivals/screens/mobile_layout.dart';
import 'package:brain_rivals/widgets/next_button.dart';
import 'package:brain_rivals/widgets/option._card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:brain_rivals/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:user_repository/user_repository.dart';

class QuizQuestionOnlineWidget extends StatefulWidget {
  const QuizQuestionOnlineWidget({super.key, required this.text, required this.categoryName, required this.icon, this.friend, required this.isChallenger, required this.challengeID});
      final String text;
  final MyUser? friend;
  final String categoryName;
  final IconData icon;
  final bool isChallenger;
  final String challengeID;
   

  @override
  State<QuizQuestionOnlineWidget> createState() => _QuizQuestionWidgetState();
}

class _QuizQuestionWidgetState extends State<QuizQuestionOnlineWidget> {
  List<Question> _questions = [];
  int index = 0;
  bool isAlreadySelected = false;
  int score = 0;
  String? selectedAnswer;
  bool isPressed = false;
  bool isLoading = true; // Sorular yükleniyor göstergesi


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


  Future<void> fetchRandomQuestions() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('categories')
          .doc(widget.categoryName)
          .collection('questions')
          .get();

      List<Question> allQuestions = querySnapshot.docs
          .map((doc) => Question.fromFirestore(doc))
          .toList();

      allQuestions.shuffle();
      List<Question> selectedQuestions = allQuestions.take(5).toList();
      await Future.delayed(const Duration(seconds: 4));
      setState(() {
        _questions = selectedQuestions;
        isLoading = false;
      });
    } catch (e) {
      print('Sorular alınamadı: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

Future<void> _handleChallenger() async {
    // 1. Rastgele 5 soru çek
    await fetchRandomQuestions();
    
    // 2. Soru ID'lerini challenge'a kaydet
    final questionIDs = _questions.map((q) => q.id).toList();
    await Provider.of<UserRepository>(context, listen: false)
      .updateChallengeQuestions(widget.challengeID, questionIDs);
  }

  Future<void> _handleChallenged() async {
    setState(() => isLoading = true);
    
    try {
      // 1. Challenge dokümanını getir
      final challengeDoc = await FirebaseFirestore.instance
        .collection('challenges')
        .doc(widget.challengeID)
        .get();

      // 2. Soru ID'lerini al
      final questionIDs = (challengeDoc.data()!['questionIDs'] as List).cast<String>();
      
      // 3. Soruları ID'lerle çek
      final questions = await Future.wait(
        questionIDs.map((id) => FirebaseFirestore.instance
          .collection('categories')
          .doc(widget.categoryName)
          .collection('questions')
          .doc(id)
          .get()
          .then((doc) => Question.fromFirestore(doc))
      ));

      setState(() {
        _questions = questions;
        isLoading = false;
      });
    } catch (e) {
      print('Hata: $e');
      setState(() => isLoading = false);
    }
  }


  @override
  void initState() {
    super.initState();
    widget.isChallenger ? _handleChallenger() : _handleChallenged();
  }

  Future<void> nextQuestion() async {
    if (index == _questions.length - 1 && isPressed) {
      await Future.delayed(Durations.medium1);
      showEndDialog();
    } else if (isPressed) {
      setState(() {
        index++;
        isPressed = false;
        isAlreadySelected = false;
        selectedAnswer = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Lütfen bir cevap seçiniz"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20),
        ),
      );
    }
  }

  void changePress(String selectedOption, bool value) {
    if (value && !isPressed) {
      setState(() {
        score++;
        isAlreadySelected = true;
      });
    }

    setState(() {
      isPressed = true;
      selectedAnswer = selectedOption;
    });
  }

  void showEndDialog()  async{
    final userRepo = Provider.of<UserRepository>(context, listen: false);
  userRepo.updateChallengeScore(
    widget.challengeID,
    widget.isChallenger,
    score
  );
   if (!widget.isChallenger){
     await _handleChallengeCompletion( widget.challengeID);
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
    String message;
    if (score == 0) {
      message = "Tekrar denemelisin";
    } else if (score == 1) {
      message = "Daha çok çalışmalısın";
    } else if (score == 2) {
      message = "Fena değil, daha iyisini yapabilirsin!";
    } else if (score == 3) {
      message = "Güzel iş çıkardın, devam et!";
    } else if (score == 4) {
      message = "Harika! Bir adım daha at!";
    } else {
      message = "Mükemmel! Tüm soruları doğru bildin!";
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: kPrimaryLightColor,
          content: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Yarışma Sona Erdi",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  radius: 60,
                  child: Text(
                    '$score/5',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(kPrimaryColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => const MobileLayout()),
  (Route<dynamic> route) => false,
);
                  },
                  child: const Text(
                    "Çıkış",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Column( 
      
      
        children: [
       /*    const SizedBox(height: 20,),
         widget.friend != null?  Container(
          decoration:  BoxDecoration(
             borderRadius: BorderRadius.circular(20),
            boxShadow: [
      BoxShadow(
        color: Colors.green.withOpacity(0.5), // gölge rengi
        spreadRadius: 2,                     // gölgenin yayılma miktarı
        blurRadius: 5,                       // bulanıklık miktarı
        offset: const Offset(0, 3),                // x ve y yönünde kaydırma
      ),
    ],
            shape: BoxShape.rectangle
          ),
           child: Text(
             // friend null değilse ekrana “Rakibiniz <isim>” yaz, yoksa boş string
            'Rakibiniz ${widget.friend!.name}',
               
             style: const TextStyle(
               fontSize: 40,
               color: Colors.black,
             ),
           ),
         ): const SizedBox.shrink() , */
          SizedBox( height: 500, width: 300,child: Center(child: Lottie.asset("assets/lottie/lot_loading02.json")),),
        ],
      ); 
    }

    if (_questions.isEmpty) {
      return const Column(
       
        children:[ 
          SizedBox(height: 200,),
          Text("Beklenmedik bir sorun oluştu." , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold, fontSize: 24),)] ,
      );
    }

    return Container(
      height: 620,
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  '${index + 1}.',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
                FaIcon(widget.icon ,color: Colors.white, size: 40),
               Text(
                widget.text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 120,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _questions[index].title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: _questions[index].options.entries.map((entry) {
              return GestureDetector(
                onTap: () => changePress(entry.key, entry.value),
                child: OptionCard(
                  option: entry.key,
                  color: !isPressed
                      ? Colors.white
                      : entry.key == selectedAnswer
                          ? entry.value
                              ? correct
                              : incorrect
                          : entry.value
                              ? correct
                              : Colors.white,
                  isSelected: isPressed && entry.key == selectedAnswer,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          NextButton(
            text: "Sıradaki Soru",
            press: nextQuestion,
          ),
        ],
      ),
    );
  }
}

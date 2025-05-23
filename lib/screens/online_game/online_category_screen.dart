import 'package:brain_rivals/constant.dart';

import 'package:brain_rivals/screens/online_game/category_detail_screen_online.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_repository/user_repository.dart';

class OnlineCategoryScreen extends StatefulWidget {
  final MyUser? friend;
  const OnlineCategoryScreen({super.key, this.friend});

  @override
  State<OnlineCategoryScreen> createState() => _OfflineCategoryScreenState();
}

class _OfflineCategoryScreenState extends State<OnlineCategoryScreen> {
  Future<void> addQuestionToFirestore(

  
) async {
  try {

       const  String  categoryName  ="bleach01"; 
   const String title ="Menos kategorisinde en üst sınıf hangisidir?";
   const String  id="05";
     Map<String, bool> options = {
    'Adhucha': false,
    'Vasto Lordes': true,
    "Gillian": false,
    'Hiçbirisi': false,
  };
 
    // Firestore referansı
    CollectionReference questionsRef = FirebaseFirestore.instance
        .collection('categories')
        .doc(categoryName)
        .collection('questions');

    // Veriyi ekle
    await questionsRef.doc().set({
      'title': title,
      'id': id,
      'options': options,
    });

    print('Soru başarıyla eklendi: $title');
  } catch (e) {
    print('Soru eklenirken hata oluştu: $e');
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        addQuestionToFirestore();
      },),
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text("kategoriler", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body:   SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                //
                children: [
                  Column(
                    children: [
                      CategoryOnline(
                        iconData: FontAwesomeIcons.futbol,
                        categoryName: 'sport01',
                        text: "Spor",
                        imageUrl: "assets/images/sporKulubu.jpg",
                        friend: widget.friend, 
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                       CategoryOnline(
                        iconData: FontAwesomeIcons.earthAmericas,
                        categoryName: "geography01",
                        text: "Coğrafya",
                        imageUrl: "assets/images/cografya.jpg",
                        friend: widget.friend,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                   Column(
                    children: [
                      CategoryOnline(
                        iconData: FontAwesomeIcons.landmark,
                        categoryName: "history01",
                        text: "Tarih",
                        imageUrl: "assets/images/tarih.jpg",
                        friend: widget.friend,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                       CategoryOnline(
                        iconData: FontAwesomeIcons.palette,
                        categoryName: "art01",
                        text: "Sanat",
                        imageUrl: "assets/images/sanat.jpg",
                        friend: widget.friend,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                   Column(
                    children: [
                      CategoryOnline(
                        iconData: FontAwesomeIcons.vials,
                        categoryName: "science01",
                        text: "Bilim",
                        imageUrl: "assets/images/bilim.png",
                        friend: widget.friend,
                      ),
                      const SizedBox(height: 10,),
                       CategoryOnline(
                        iconData: FontAwesomeIcons.mixer,
                        categoryName: "mixed01",
                        text: "Karışık",
                        imageUrl: "assets/images/karisik.jpg",
                        friend: widget.friend,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: kPrimaryLightColor,),
            const SizedBox(height: 20,),
            const Text("Dizi ve Animasyon" ,  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 22),),
            const SizedBox(height: 10),
             SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryOnline(
                    iconData: FontAwesomeIcons.film,
                    categoryName: "gibi01",
                        text: "Gibi",
                        imageUrl: "assets/images/gibi.jpg",
                        friend: widget.friend,
                      ),
                      const SizedBox(width: 10,),
                       CategoryOnline(
                        iconData: FontAwesomeIcons.film,
                        categoryName: "prens01",
                        text: "Prens",
                        imageUrl: "assets/images/prens.jpg",
                        friend: widget.friend,
                      ),
                       const SizedBox(width: 10,),
                       CategoryOnline(
                        iconData: FontAwesomeIcons.film,
                        categoryName: "piece01",
                        text: "One-Piece",
                        imageUrl: "assets/images/onepiece.webp",
                        friend: widget.friend,
                      ),
                      const SizedBox(width: 10,),
                       CategoryOnline(
                        iconData: FontAwesomeIcons.film,
                        categoryName: "arcane01",
                        text: "Arcane",
                        imageUrl: "assets/images/arcane.webp",
                        friend: widget.friend,
                      ),
                       const SizedBox(width: 10,),
                         CategoryOnline(
                          iconData: FontAwesomeIcons.film,
                          categoryName: "bleach01",
                        text: "Bleach",
                        imageUrl: "assets/images/bleach.webp",
                        friend: widget.friend,
                      ),
                      
                ],
              ),
            ), 
            const Divider(color: kPrimaryLightColor,),
             const SizedBox(height: 20,),
            const Text("Hayat" ,  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 22),),
            const SizedBox(height: 10,),
                         SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryOnline(
                    iconData: FontAwesomeIcons.utensils,
                    categoryName: "food01",
                        text: "Beslenme",
                        imageUrl: "assets/images/beslenme.jpg",
                        friend: widget.friend,
                      ),
                      const SizedBox(width: 10,),
                       CategoryOnline(  
                        iconData: FontAwesomeIcons.brain,
                        categoryName: "philosophy01",
                        text: "Felsefe",
                        imageUrl: "assets/images/felsefe.jpg",
                        friend: widget.friend,
                      ),
                       const SizedBox(width: 10,),
                       CategoryOnline(
                        iconData: FontAwesomeIcons.personFalling,
                        categoryName: "culture01",
                        text: "Genel kültür",
                        imageUrl: "assets/images/genelkültür.jpeg",
                        friend: widget.friend,
                      ),
                      const SizedBox(width: 10,),
                       CategoryOnline(
                        iconData: FontAwesomeIcons.headSideCough,
                        categoryName: "communication01",
                        text: "İletişim",
                        imageUrl: "assets/images/iletisim.avif",
                        friend: widget.friend,
                      ),
                      
                      
                ],
              ),
            ), 

            const Divider(color: kPrimaryLightColor,),
             const SizedBox(height: 20,),
            const Text("Popüler" ,  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 22),),
            const SizedBox(height: 10,),
              SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryOnline(
                    iconData: FontAwesomeIcons.music,
                    categoryName: "turkishRap01",
                        text: "Türkçe Rap",
                        imageUrl: "assets/images/rap.jpg",
                        friend: widget.friend,
                      ),
                      const SizedBox(width: 10,),
                      CategoryOnline( 
                        iconData: FontAwesomeIcons.futbol,
                        categoryName: "galatasaray01", 
                        text: "Galatasaray",
                        imageUrl: "assets/images/gs.jpg",
                        friend: widget.friend,
                      ),
                       const SizedBox(width: 10,),
                      CategoryOnline(
                        iconData: FontAwesomeIcons.music,
                        categoryName: "pop01",
                        text: "90'lar pop",
                        imageUrl: "assets/images/pop.jpg",
                        friend: widget.friend,
                      ),
                     
                      
                      
                ],
              ),
            ), 
            const SizedBox(height: 20,)

          ],
        ),
      ),
    );
  }
}

class CategoryOnline extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String categoryName;
  
  final  IconData iconData;
  final MyUser? friend;
  const CategoryOnline({
    super.key,
    
    required this.text,
    required this.imageUrl,
    required this.categoryName, required this.iconData, this.friend,
    
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailPageOnline(
              icon: iconData,
              text: text,
              imageUrl: imageUrl,
              categoryName:categoryName,
              friend: friend,

            ),
          ),
        );

      },
      child: SizedBox(
        child: Column(
          children: [
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                // Çerçevenin arka plan rengi
                border: Border.all(
                  color: kPrimaryLightColor, // Çerçeve rengi
                  width: 5, // Çerçeve kalınlığı
                ),
                borderRadius: BorderRadius.circular(15), // Yuvarlak köşe
              ),
              height: 100,
              width: 170,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.fill,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

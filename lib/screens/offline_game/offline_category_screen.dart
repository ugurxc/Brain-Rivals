import 'package:brain_rivals/constant.dart';

import 'package:brain_rivals/screens/offline_game/category_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OfflineCategoryScreen extends StatefulWidget {
  const OfflineCategoryScreen({super.key});

  @override
  State<OfflineCategoryScreen> createState() => _OfflineCategoryScreenState();
}

class _OfflineCategoryScreenState extends State<OfflineCategoryScreen> {
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
      body:  const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                //
                children: [
                  Column(
                    children: [
                      CategoryOffline(
                        iconData: FontAwesomeIcons.futbol,
                        categoryName: 'sport01',
                        text: "Spor",
                        imageUrl: "assets/images/sporKulubu.jpg",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CategoryOffline(
                        iconData: FontAwesomeIcons.earthAmericas,
                        categoryName: "geography01",
                        text: "Coğrafya",
                        imageUrl: "assets/images/cografya.jpg",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      CategoryOffline(
                        iconData: FontAwesomeIcons.landmark,
                        categoryName: "history01",
                        text: "Tarih",
                        imageUrl: "assets/images/tarih.jpg",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CategoryOffline(
                        iconData: FontAwesomeIcons.palette,
                        categoryName: "art01",
                        text: "Sanat",
                        imageUrl: "assets/images/sanat.jpg",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      CategoryOffline(
                        iconData: FontAwesomeIcons.vials,
                        categoryName: "science01",
                        text: "Bilim",
                        imageUrl: "assets/images/bilim.png",
                      ),
                      SizedBox(height: 10,),
                      CategoryOffline(
                        iconData: FontAwesomeIcons.mixer,
                        categoryName: "mixed01",
                        text: "Karışık",
                        imageUrl: "assets/images/karisik.jpg",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: kPrimaryLightColor,),
            SizedBox(height: 20,),
            Text("Dizi ve Animasyon" ,  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 22),),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryOffline(
                    iconData: FontAwesomeIcons.film,
                    categoryName: "gibi01",
                        text: "Gibi",
                        imageUrl: "assets/images/gibi.jpg",
                      ),
                      SizedBox(width: 10,),
                      CategoryOffline(
                        iconData: FontAwesomeIcons.film,
                        categoryName: "prens01",
                        text: "Prens",
                        imageUrl: "assets/images/prens.jpg",
                      ),
                       SizedBox(width: 10,),
                      CategoryOffline(
                        iconData: FontAwesomeIcons.film,
                        categoryName: "piece01",
                        text: "One-Piece",
                        imageUrl: "assets/images/onepiece.webp",
                      ),
                      SizedBox(width: 10,),
                      CategoryOffline(
                        iconData: FontAwesomeIcons.film,
                        categoryName: "arcane01",
                        text: "Arcane",
                        imageUrl: "assets/images/arcane.webp",
                      ),
                       SizedBox(width: 10,),
                        CategoryOffline(
                          iconData: FontAwesomeIcons.film,
                          categoryName: "bleach01",
                        text: "Bleach",
                        imageUrl: "assets/images/bleach.webp",
                      ),
                      
                ],
              ),
            ), 
            Divider(color: kPrimaryLightColor,),
             SizedBox(height: 20,),
            Text("Hayat" ,  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 22),),
            SizedBox(height: 10,),
                        SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryOffline(
                    iconData: FontAwesomeIcons.utensils,
                    categoryName: "food01",
                        text: "Beslenme",
                        imageUrl: "assets/images/beslenme.jpg",
                      ),
                      SizedBox(width: 10,),
                      CategoryOffline(  
                        iconData: FontAwesomeIcons.brain,
                        categoryName: "philosophy01",
                        text: "Felsefe",
                        imageUrl: "assets/images/felsefe.jpg",
                      ),
                       SizedBox(width: 10,),
                      CategoryOffline(
                        iconData: FontAwesomeIcons.personFalling,
                        categoryName: "culture01",
                        text: "Genel kültür",
                        imageUrl: "assets/images/genelkültür.jpeg",
                      ),
                      SizedBox(width: 10,),
                      CategoryOffline(
                        iconData: FontAwesomeIcons.headSideCough,
                        categoryName: "communication01",
                        text: "İletişim",
                        imageUrl: "assets/images/iletisim.avif",
                      ),
                      
                      
                ],
              ),
            ), 

            Divider(color: kPrimaryLightColor,),
             SizedBox(height: 20,),
            Text("Popüler" ,  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 22),),
            SizedBox(height: 10,),
             SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryOffline(
                    iconData: FontAwesomeIcons.music,
                    categoryName: "turkishRap01",
                        text: "Türkçe Rap",
                        imageUrl: "assets/images/rap.jpg",
                      ),
                      SizedBox(width: 10,),
                      CategoryOffline( 
                        iconData: FontAwesomeIcons.futbol,
                        categoryName: "galatasaray01", 
                        text: "Galatasaray",
                        imageUrl: "assets/images/gs.jpg",
                      ),
                       SizedBox(width: 10,),
                      CategoryOffline(
                        iconData: FontAwesomeIcons.music,
                        categoryName: "pop01",
                        text: "90'lar pop",
                        imageUrl: "assets/images/pop.jpg",
                      ),
                     
                      
                      
                ],
              ),
            ), 
            SizedBox(height: 20,)

          ],
        ),
      ),
    );
  }
}

class CategoryOffline extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String categoryName;
  
  final  IconData iconData;
  
  const CategoryOffline({
    super.key,
    
    required this.text,
    required this.imageUrl,
    required this.categoryName, required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailPage(
              icon: iconData,
              text: text,
              imageUrl: imageUrl,
              categoryName:categoryName,

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








/* import 'package:brain_rivals/constant.dart';
import 'package:brain_rivals/screens/offline_game/category_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_repository/user_repository.dart';

class OfflineCategoryScreen extends StatefulWidget {
  final MyUser? friend;
  const OfflineCategoryScreen({super.key, this.friend});

  @override
  State<OfflineCategoryScreen> createState() => _OfflineCategoryScreenState();
}

class _OfflineCategoryScreenState extends State<OfflineCategoryScreen> {
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
                      CategoryOffline(
                        iconData: FontAwesomeIcons.futbol,
                        categoryName: 'sport01',
                        text: "Spor",
                        imageUrl: "assets/images/sporKulubu.jpg",
                        friend: widget.friend, 
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const CategoryOffline(
                        iconData: FontAwesomeIcons.earthAmericas,
                        categoryName: "geography01",
                        text: "Coğrafya",
                        imageUrl: "assets/images/cografya.jpg",
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    children: [
                      CategoryOffline(
                        iconData: FontAwesomeIcons.landmark,
                        categoryName: "history01",
                        text: "Tarih",
                        imageUrl: "assets/images/tarih.jpg",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CategoryOffline(
                        iconData: FontAwesomeIcons.palette,
                        categoryName: "art01",
                        text: "Sanat",
                        imageUrl: "assets/images/sanat.jpg",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    children: [
                      CategoryOffline(
                        iconData: FontAwesomeIcons.vials,
                        categoryName: "science01",
                        text: "Bilim",
                        imageUrl: "assets/images/bilim.png",
                      ),
                      SizedBox(height: 10,),
                      CategoryOffline(
                        iconData: FontAwesomeIcons.mixer,
                        categoryName: "mixed01",
                        text: "Karışık",
                        imageUrl: "assets/images/karisik.jpg",
                      ),
                      SizedBox(
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
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryOffline(
                    iconData: FontAwesomeIcons.film,
                    categoryName: "gibi01",
                        text: "Gibi",
                        imageUrl: "assets/images/gibi.jpg",
                      ),
                      SizedBox(width: 10,),
                      CategoryOffline(
                        iconData: FontAwesomeIcons.film,
                        categoryName: "prens01",
                        text: "Prens",
                        imageUrl: "assets/images/prens.jpg",
                      ),
                       SizedBox(width: 10,),
                      CategoryOffline(
                        iconData: FontAwesomeIcons.film,
                        categoryName: "piece01",
                        text: "One-Piece",
                        imageUrl: "assets/images/onepiece.webp",
                      ),
                      SizedBox(width: 10,),
                      CategoryOffline(
                        iconData: FontAwesomeIcons.film,
                        categoryName: "arcane01",
                        text: "Arcane",
                        imageUrl: "assets/images/arcane.webp",
                      ),
                       SizedBox(width: 10,),
                        CategoryOffline(
                          iconData: FontAwesomeIcons.film,
                          categoryName: "bleach01",
                        text: "Bleach",
                        imageUrl: "assets/images/bleach.webp",
                      ),
                      
                ],
              ),
            ), 
            const Divider(color: kPrimaryLightColor,),
             const SizedBox(height: 20,),
            const Text("Hayat" ,  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 22),),
            const SizedBox(height: 10,),
                        const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryOffline(
                    iconData: FontAwesomeIcons.utensils,
                    categoryName: "food01",
                        text: "Beslenme",
                        imageUrl: "assets/images/beslenme.jpg",
                      ),
                      SizedBox(width: 10,),
                      CategoryOffline(  
                        iconData: FontAwesomeIcons.brain,
                        categoryName: "philosophy01",
                        text: "Felsefe",
                        imageUrl: "assets/images/felsefe.jpg",
                      ),
                       SizedBox(width: 10,),
                      CategoryOffline(
                        iconData: FontAwesomeIcons.personFalling,
                        categoryName: "culture01",
                        text: "Genel kültür",
                        imageUrl: "assets/images/genelkültür.jpeg",
                      ),
                      SizedBox(width: 10,),
                      CategoryOffline(
                        iconData: FontAwesomeIcons.headSideCough,
                        categoryName: "communication01",
                        text: "İletişim",
                        imageUrl: "assets/images/iletisim.avif",
                      ),
                      
                      
                ],
              ),
            ), 

            const Divider(color: kPrimaryLightColor,),
             const SizedBox(height: 20,),
            const Text("Popüler" ,  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 22),),
            const SizedBox(height: 10,),
             const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryOffline(
                    iconData: FontAwesomeIcons.music,
                    categoryName: "turkishRap01",
                        text: "Türkçe Rap",
                        imageUrl: "assets/images/rap.jpg",
                      ),
                      SizedBox(width: 10,),
                      CategoryOffline( 
                        iconData: FontAwesomeIcons.futbol,
                        categoryName: "galatasaray01", 
                        text: "Galatasaray",
                        imageUrl: "assets/images/gs.jpg",
                      ),
                       SizedBox(width: 10,),
                      CategoryOffline(
                        iconData: FontAwesomeIcons.music,
                        categoryName: "pop01",
                        text: "90'lar pop",
                        imageUrl: "assets/images/pop.jpg",
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

class CategoryOffline extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String categoryName;
  
  final  IconData iconData;
  final MyUser? friend;
  const CategoryOffline({
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
            builder: (context) => DetailPage(
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
 */
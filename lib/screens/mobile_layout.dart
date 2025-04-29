import 'package:brain_rivals/blocs/auth_bloc/auth_bloc.dart';
import 'package:brain_rivals/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:brain_rivals/constant.dart';
import 'package:brain_rivals/screens/login_screen.dart';
import 'package:brain_rivals/screens/my_profile.dart';
import 'package:brain_rivals/screens/offline_category_screen.dart';
import 'package:brain_rivals/screens/social_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  Future<String?> _getSelectedAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedAvatar');
  }

  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {}
      },
      child: Scaffold(
        
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/arkaplan01.jpg'), // Arka plan resmi
              fit: BoxFit.fill
              , // Resmin tüm alanı kaplaması
            )),
            child: Column(children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 100,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: BlocBuilder<MyUserBloc, MyUserState>(
  builder: (context, state) {
    if (state.status == MyUserStatus.succsess) {
      return Stack(
        alignment: Alignment.center,
        children: [
          // Arka plan Container
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Sol kısım
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: kPrimaryColor, borderRadius: BorderRadius.all(Radius.circular(12))),
                      width: 160,
                      child: Row(
                        children: [
                          const Icon(Icons.accessibility_new_sharp, color: Colors.amber),
                          const SizedBox(width: 5),
                          Text(
                            state.user?.name ?? 'No name available',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      decoration: const BoxDecoration(
                          color: kPrimaryColor, borderRadius: BorderRadius.all(Radius.circular(12))),
                      width: 160,
                      child: const Row(
                        children: [
                          Icon(Icons.star_border_sharp, color: Colors.amber),
                          SizedBox(width: 5),
                          Text(
                            'level:  1',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Sağ kısım
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 160,
                      decoration: const BoxDecoration(
                          color: kPrimaryColor, borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '400',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 45),
                          Icon(Icons.monetization_on, color: Colors.yellow),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      decoration: const BoxDecoration(
                          color: kPrimaryColor, borderRadius: BorderRadius.all(Radius.circular(12))),
                      width: 160,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '10',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 50),
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Ortadaki profil resmi (CircleAvatar)
          Align(
            alignment: const Alignment(0, -0),
            child: InkWell(
              onTap: () {
                
                showDialog(context: context, builder: (context) {
                  return  MyProfile(userId: state.user!.id,);
                },);
                 Navigator.push(
                 context,
                  MaterialPageRoute(builder: (context) {
                    return  MyProfile(userId: state.user!.id,); // Profil seçme ekranına yönlendirme
                  }),
                ); 
              },
              child: CircleAvatar(
                      radius: 40,
                      backgroundImage: state.user?.picture != null
      ? AssetImage(state.user!.picture!)
      : const AssetImage('assets/bilim.png') as ImageProvider,
                    )
            ),
          )
        ],
      );
    } else if (state.status == MyUserStatus.loading || state.status == MyUserStatus.failure) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return const Placeholder(); // Varsayılan durum
    }
  },
),
              ),
              SizedBox(
                  height: 300,
                  width: 300,
                  child: Image.asset(
                    "assets/images/BrainRivals4545.png",
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const OfflineCategoryScreen();
                            },
                          ));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              // Çerçevenin arka plan rengi
                              border: Border.all(
                                color: kPrimaryLightColor, // Çerçeve rengi
                                width: 5, // Çerçeve kalınlığı
                              ),
                              borderRadius: BorderRadius.circular(15), // Yuvarlak köşe
                            ),
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  "assets/images/indir.jpg",
                                ))),
                      ),
                      const Text(
                        "Tek Başına",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Column(
                    children: [
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
                          width: 100,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/images/login3.jpg",
                              ))),
                      const Text(
                        "Çevrim içi",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                children: [
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
                      width: 100,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "assets/images/login2.jpg",
                          ))),
                  const Text(
                    "Yapay Zekaya Karşı",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SocialScreen(),
                      ));
                      },
                      icon: const Icon(
                        Icons.supervised_user_circle_rounded,
                        size: 48,
                        color: kPrimaryLightColor,
                      )),
                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                    },
                    child: IconButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(const SignOutRequired());
                          context.read<MyUserBloc>().add(LogoutUser());
                        },
                        icon: const Icon(
                          Icons.settings,
                          size: 48,
                          color: kPrimaryLightColor,
                        )),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}

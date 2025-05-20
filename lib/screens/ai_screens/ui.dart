import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

/*
class YapayZekaUi extends StatefulWidget {
  const YapayZekaUi({super.key});

  @override
  State<YapayZekaUi> createState() => _YapayZekaUiState();
}

class _YapayZekaUiState extends State<YapayZekaUi> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(id: "0", firstName: "Kullanıcı");
  ChatUser geminiUser = ChatUser(id: "1", firstName: "Gemini");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Gemini Chat"),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
        
        currentUser: currentUser,
        onSend: _sendMessage,
        messages: messages.reversed.toList());
  }

  void _sendMessage(ChatMessage chatMessage) async {
    setState(() {
      messages = [...messages, chatMessage];
    });
    
    try {
      final response = await gemini.prompt(
        parts: [Part.text(chatMessage.text)],
      );
      
      final String text = response?.output ?? "Cevap alınamadı!";
      
      final geminiMessage = ChatMessage(
        user: geminiUser,
        createdAt: DateTime.now(),
        text: text,
      );

      setState(() {
        messages = [...messages, geminiMessage];
      });
    } catch (e) {
      print("Gemini Hatası: $e");
      
      final errorMessage = ChatMessage(
        user: geminiUser,
        createdAt: DateTime.now(),
        text: "Hata oluştu: ${e.toString()}",
      );

      setState(() {
        messages = [...messages, errorMessage];
      });
    }
  }
} */

 // veya kullandığınız paket import'u

class YapayZekaUi extends StatefulWidget {
  const YapayZekaUi({super.key});

  @override
  State<YapayZekaUi> createState() => _YapayZekaUiState();
}

class _YapayZekaUiState extends State<YapayZekaUi> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  late final ChatUser currentUser;
  late final ChatUser geminiUser;

  @override
  void initState() {
    super.initState();

    currentUser = ChatUser(id: "0", firstName: "Kullanıcı");
    geminiUser = ChatUser(id: "1", firstName: "Gemini", profileImage: "https://tldv.io/wp-content/uploads/2025/01/Gemini-Alternatives.jpg");

    // Başlangıç mesajı ekle
    messages.add(
      ChatMessage(
        user: geminiUser,
        createdAt: DateTime.now(),
        text: "Selam! Ben Gemini, yarışmanın gizli silahı. Hangi konuda desteğe ihtiyacın var? Sorunu el birliğiyle çözelim!",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Gemini Chat"),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
      currentUser: currentUser,
      onSend: _sendMessage,
   messages: messages.reversed.toList());
  }

  void _sendMessage(ChatMessage chatMessage) async {
    setState(() {
      messages = [...messages, chatMessage];
    });

    try {
      final response = await gemini.prompt(
        parts: [Part.text(chatMessage.text)],
      );

      final String text = response?.output ?? "Cevap alınamadı!";
      final geminiMessage = ChatMessage(
        user: geminiUser,
        createdAt: DateTime.now(),
        text: text,
      );

      setState(() {
        messages = [...messages, geminiMessage];
      });
    } catch (e) {
      print("Gemini Hatası: $e");

      final errorMessage = ChatMessage(
        user: geminiUser,
        createdAt: DateTime.now(),
        text: "Hata oluştu: ${e.toString()}",
      );

      setState(() {
        messages = [...messages, errorMessage];
      });
    }
  }
}

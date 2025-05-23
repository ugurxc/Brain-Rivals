import 'package:brain_rivals/screens/other_profile_screen.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:user_repository/user_repository.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final Set<String> _processedRequests = {};
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserRepository _userRepo;
  late String _userId;

  @override
  void initState() {
    super.initState();
    _userRepo = Provider.of<UserRepository>(context, listen: false);
    _userId = _auth.currentUser!.uid;
  }

  Future<void> _handleRequestAction(String requestId, bool isAccepted) async {
    try {
      await _userRepo.handleFriendRequest(requestId, isAccepted);
      
      setState(() {
        _processedRequests.add(requestId);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isAccepted 
              ? 'Arkadaşlık isteği kabul edildi'
              : 'Arkadaşlık isteği reddedildi'
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: ${e.toString()}')),
      );
    }
  }

  Widget _buildNotificationItem(AppNotification notification) {
    final dateFormat = DateFormat('dd MMM yyyy');
    final timeFormat = DateFormat('HH:mm');

    if (_processedRequests.contains(notification.relatedRequestId)) {
      return const SizedBox.shrink();
    }

    return FutureBuilder<MyUser>(
      future: _userRepo.getMyUser(notification.senderId),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const ListTile(
            leading: CircularProgressIndicator(),
          );
        }

        final user = userSnapshot.data ?? MyUser.empty;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: ListTile(
            key: ValueKey(notification.id),
            leading: InkWell(
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) {
              return OtherProfilePage(user: user,);
            },));
              },
              child: CircleAvatar(
                backgroundImage: user.picture?.isNotEmpty == true
                    ? AssetImage(user.picture!)
                    : const AssetImage('assets/default_avatar.png') as ImageProvider,
              ),
            ),
            title: Text(user.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification.message),
                const SizedBox(height: 4),
                Text(
                  '${dateFormat.format(notification.createdAt)} '
                  '${timeFormat.format(notification.createdAt)}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                if (notification.type == 'friend_request' &&
                    !_processedRequests.contains(notification.relatedRequestId))
                  _buildRequestButtons(notification),
              ],
            ),
            trailing: notification.status == 'unread'
                ? const Icon(Icons.circle, size: 12, color: Colors.blue)
                : null,
            onTap: () => _userRepo.updateNotificationStatus(notification.id, 'read'),
          ),
        );
      },
    );
  }

  Widget _buildRequestButtons(AppNotification notification) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            onPressed: () => _handleRequestAction(
              notification.relatedRequestId, 
              true
            ),
            child: const Text('Kabul'),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.red),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            onPressed: () => _handleRequestAction(
              notification.relatedRequestId, 
              false
            ),
            child: const Text('Reddet', style: TextStyle(color: Colors.red)),
      )],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bildirimler'),
        actions: [
          IconButton(
            icon: const Icon(Icons.mark_email_read),
            tooltip: 'Tümünü okundu işaretle',
            onPressed: () async {
              await _userRepo.markAllNotificationsAsRead(_userId);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tüm bildirimler okundu olarak işaretlendi')),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<AppNotification>>(
        stream: _userRepo.getNotifications(_userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final notifications = snapshot.data ?? [];

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: notifications.length,
            separatorBuilder: (context, index) => const Divider(height: 24),
            itemBuilder: (context, index) {
              final notification = notifications[index];
              
              if (_processedRequests.contains(notification.relatedRequestId)) {
                return const SizedBox.shrink();
              }

              return Dismissible(
                key: Key(notification.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  return await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Bildirimi Sil'),
                      content: const Text('Bu bildirimi silmek istediğinize emin misiniz?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, false),
                          child: const Text('İptal')),
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          child: const Text('Sil', style: TextStyle(color: Colors.red))),
                      ],
                    ),
                  );
                },
                onDismissed: (direction) {
                  _userRepo.deleteNotification(notification.id);
                },
                child: _buildNotificationItem(notification),
              );
            },
          );
        },
      ),
    );
  }
}
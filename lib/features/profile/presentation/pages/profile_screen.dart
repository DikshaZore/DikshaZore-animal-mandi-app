import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../routes/app_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color(0xFF2D8659),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(radius: 40, backgroundColor: Colors.white, child: const Icon(Icons.person, size: 40, color: Color(0xFF2D8659))),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Rajesh Kumar', style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                        const SizedBox(height: 4),
                        Text('Pune, Maharashtra', style: TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white70)),
                        const SizedBox(height: 8),
                        const Row(
                          children: [
                            Icon(Icons.star, size: 16, color: Color(0xFFFFA500)),
                            SizedBox(width: 4),
                            Text('4.5 (15 reviews)', style: TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white70)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.edit, color: Colors.white), onPressed: () {}),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [_buildStat('5', 'Active'), _buildStat('12', 'Sold'), _buildStat('28', 'Views')],
              ),
            ),
            const SizedBox(height: 32),
            _buildMenuItem(Icons.list, 'My Listings', () {}),
            _buildMenuItem(Icons.check_circle, 'Sold Listings', () {}),
            _buildMenuItem(Icons.language, 'Language', () {}),
            _buildMenuItem(Icons.dark_mode, 'Theme', () {}),
            _buildMenuItem(Icons.settings, 'Settings', () {}),
            _buildMenuItem(Icons.help, 'Help & Support', () {}),
            _buildMenuItem(Icons.logout, 'Logout', () => context.go(Routes.login)),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String number, String label) {
    return Column(
      children: [
        Text(number, style: const TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF2D8659))),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF757575))),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF2D8659)),
      title: Text(title, style: const TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
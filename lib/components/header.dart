import 'package:flutter/material.dart';
import '../components/headlines.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF528A7D),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/Soullog_WT.png', width: 24, height: 24, fit: BoxFit.contain),
          const SizedBox(width: 8),
          Text('SOULLOG', style: h2White),
        ],
      ),
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.menu, color: Colors.white),
          onSelected: (value) {
            switch (value) {
              case 'record':
              //Navigator.pushNamed(context, '/record');
                break;
              case 'entries':
              //Navigator.pushNamed(context, '/dashboard');
                break;
              case 'dashboard':
              //Navigator.pushNamed(context, '/entries');
                break;
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'record', child: Text('Record')),
            PopupMenuItem(value: 'dashboard', child: Text('Dashboard')),
            PopupMenuItem(value: 'entries', child: Text('Entries')),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
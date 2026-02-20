import 'package:flutter/material.dart';
import 'package:ums/core/token_manager.dart';
import '../../../bottom_nav/domain/entity/user_entity.dart';
import '../../../bottom_nav/presentation/screen/login_screen.dart';
import 'info_card.dart';

class ProfileBody extends StatelessWidget {
  final UserEntity user;
  const ProfileBody({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary,
                  colorScheme.primary.withOpacity(0.75),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.person_rounded,
                    size: 34,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.givenName} ${user.surname}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        user.role.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                InfoCard(
                  children: [
                    _Tile(
                      Icons.email_outlined,
                      'Email',
                      user.email,
                      verified: user.emailVerified,
                    ),
                    _Divider(),
                    _Tile(
                      Icons.phone_outlined,
                      'Phone',
                      user.phone,
                      verified: user.phoneVerified,
                    ),
                    _Divider(),
                    _Tile(
                      Icons.location_on_outlined,
                      'Landmark',
                      user.landmark,
                    ),
                    if (user.gpsCode != null) ...[
                      _Divider(),
                      _Tile(Icons.gps_fixed_rounded, 'GPS', user.gpsCode!),
                    ],
                    _Divider(),
                    _Tile(Icons.badge_outlined, 'ID', user.id),
                    _Divider(),
                    _Tile(
                      Icons.calendar_today_outlined,
                      'Joined',
                      _formatDate(user.createdAt),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          TextButton(
            onPressed: () async {
              await TokenManager.clearTokens();
              await Future.delayed(const Duration(milliseconds: 500));
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final dt = DateTime.parse(dateString);
      return '${dt.day}/${dt.month}/${dt.year}';
    } catch (_) {
      return dateString;
    }
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool? verified;

  const _Tile(this.icon, this.label, this.value, {this.verified});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: colorScheme.primary),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (verified != null)
            Icon(
              verified! ? Icons.check_circle_rounded : Icons.cancel_rounded,
              size: 16,
              color: verified! ? Colors.green : Colors.orange,
            ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      indent: 48,
      endIndent: 16,
      color: Colors.grey.shade100,
    );
  }
}

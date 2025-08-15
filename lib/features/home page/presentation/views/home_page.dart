import 'package:flutter/material.dart';
import 'package:learning_center_system/features/home%20page/presentation/widgets/quick_action_card.dart';
import 'package:learning_center_system/features/home%20page/presentation/widgets/stat_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          bool isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
          bool isDesktop = constraints.maxWidth >= 1024;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.settings),
                      label: const Text("الإعدادات"),
                    ),
                    Text(
                      "مرحباً بك في مركز طيبه التعليمي",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "لوحة التحكم الرئيسية",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 20),

                // Stats Cards
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: isMobile ? 2 : 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: isMobile ? 1.2 : 1.5,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    StatCard(icon: Icons.menu_book, iconColor: Colors.green, title: "المدرسين", value: "12"),
                    StatCard(icon: Icons.people, iconColor: Colors.blue, title: "إجمالي الطلاب", value: "245"),
                    StatCard(icon: Icons.calendar_today, iconColor: Colors.orange, title: "الحضور اليوم", value: "89%"),
                    StatCard(icon: Icons.group, iconColor: Colors.purple, title: "المجموعات", value: "18"),
                  ],
                ),

                const SizedBox(height: 24),

                // Quick Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("الإجراءات السريعة", style: Theme.of(context).textTheme.titleMedium),
                    const Icon(Icons.arrow_upward),
                  ],
                ),
                const SizedBox(height: 12),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: isMobile ? 2 : 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: isMobile ? 2 : 2.5,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    QuickActionCard(icon: Icons.qr_code_scanner, iconColor: Colors.blue, title: "تسجيل الحضور"),
                    QuickActionCard(icon: Icons.star, iconColor: Colors.purple, title: "عرض التقييمات"),
                    QuickActionCard(icon: Icons.person_add, iconColor: Colors.green, title: "إضافة طالب"),
                    QuickActionCard(icon: Icons.attach_money, iconColor: Colors.orange, title: "تسجيل المصروفات"),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}




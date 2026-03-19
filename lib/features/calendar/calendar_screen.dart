import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/glass_components.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  late HijriCalendar _viewMonth;

  @override
  void initState() {
    super.initState();
    _viewMonth = HijriCalendar.now();
  }

  void _previousMonth() {
    setState(() {
      int prevM = _viewMonth.hMonth - 1;
      int prevY = _viewMonth.hYear;
      if (prevM == 0) {
        prevM = 12;
        prevY--;
      }
      _viewMonth = HijriCalendar()
        ..hYear = prevY
        ..hMonth = prevM
        ..hDay = 1;
    });
  }

  void _nextMonth() {
    setState(() {
      int nextM = _viewMonth.hMonth + 1;
      int nextY = _viewMonth.hYear;
      if (nextM == 13) {
        nextM = 1;
        nextY++;
      }
      _viewMonth = HijriCalendar()
        ..hYear = nextY
        ..hMonth = nextM
        ..hDay = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkBackground,
        gradient: RadialGradient(
          center: Alignment.topCenter,
          radius: 1.5,
          colors: [
            Color(0xFF145355), // Teal glow
            AppColors.darkBackground,
          ],
          stops: [0.0, 1.0],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Islamic Calendar', // Replace with localized key
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            
            // Month Navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, color: Colors.white),
                    onPressed: _previousMonth,
                  ),
                  Text(
                    '\${_viewMonth.longMonthName} \${_viewMonth.hYear}',
                    style: const TextStyle(
                      color: AppColors.islamicGold,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right, color: Colors.white),
                    onPressed: _nextMonth,
                  ),
                ],
              ),
            ),
            
            // Calendar Grid Placeholder
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Weekdays
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text('S', style: TextStyle(color: AppColors.textMuted)),
                          Text('M', style: TextStyle(color: AppColors.textMuted)),
                          Text('T', style: TextStyle(color: AppColors.textMuted)),
                          Text('W', style: TextStyle(color: AppColors.textMuted)),
                          Text('T', style: TextStyle(color: AppColors.textMuted)),
                          Text('F', style: TextStyle(color: AppColors.islamicGold)),
                          Text('S', style: TextStyle(color: AppColors.textMuted)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Days Grid Placeholder (in real app, use GridView builder calculate starting day)
                      Expanded(
                        child: Center(
                          child: Text(
                            'Calendar Grid Implementation',
                            style: TextStyle(color: AppColors.textMuted),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Important Dates List for this month
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Important Events',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                   // Placeholder Event
                  GlassCard(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Demolition of Al-Baqi',
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '8 Shawwal',
                              style: TextStyle(color: AppColors.textMuted, fontSize: 14),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text('Martyrdom/Sad', style: TextStyle(color: Colors.red, fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100), // Space for bottom nav
          ],
        ),
      ),
    );
  }
}

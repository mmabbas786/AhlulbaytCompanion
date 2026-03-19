import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/glass_components.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  final _deviceSupport = FlutterQiblah.checkLocationStatus();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Qibla Direction'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: [Color(0xFF145355), AppColors.darkBackground],
            stops: [0.0, 1.0],
          ),
        ),
        child: FutureBuilder(
          future: _deviceSupport,
          builder: (_, AsyncSnapshot<LocationStatus> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: AppColors.islamicGold));
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: \${snapshot.error}", style: const TextStyle(color: Colors.white)));
            }

            if (snapshot.data!.enabled == true) {
              return const _QiblaCompassWidget();
            } else {
              return const Center(
                child: Text(
                  "Please enable location services to find Qibla.",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _QiblaCompassWidget extends StatelessWidget {
  const _QiblaCompassWidget();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: AppColors.islamicGold));
        }

        final qiblahDirection = snapshot.data;

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlassCard(
                padding: const EdgeInsets.all(32),
                child: SizedBox(
                  width: 300,
                  height: 300,
                  // Rotated image/widget goes here.
                  // For now, using a placeholder icon or simple layout.
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.rotate(
                        angle: (qiblahDirection?.direction ?? 0) * (3.1415926535897932 / 180) * -1,
                        child: const Icon(Icons.explore_outlined, size: 280, color: AppColors.primaryTeal),
                      ),
                      Transform.rotate(
                        angle: (qiblahDirection?.qiblah ?? 0) * (3.1415926535897932 / 180) * -1,
                        child: const Align(
                          alignment: Alignment.topCenter,
                          child: Icon(Icons.location_on, size: 48, color: AppColors.islamicGold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 48),
              const Text(
                'Align the pointer with the top of the compass',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 16),
              Text(
                "\${qiblahDirection?.offset.toStringAsFixed(1) ?? '0.0'}°",
                style: const TextStyle(
                  color: AppColors.islamicGold,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../constants/ad_ids.dart';

class AdMobService {
  static final AdMobService _instance = AdMobService._internal();
  factory AdMobService() => _instance;
  AdMobService._internal();

  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  DateTime? _lastInterstitialTime;

  Future<void> initialize() async {
    if (kIsWeb) return;
    await MobileAds.instance.initialize();
    loadInterstitial();
    loadRewarded();
  }

  // --- Banner ---
  Widget getBannerWidget(String adUnitId) {
    if (kIsWeb) return const SizedBox.shrink();
    
    final bannerAd = BannerAd(
      adUnitId: adUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();

    return Container(
      alignment: Alignment.center,
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
      child: AdWidget(ad: bannerAd),
    );
  }

  Widget getHomeBanner() {
    if (kIsWeb) return const SizedBox.shrink();
    return getBannerWidget(Platform.isAndroid ? AdIds.bannerAndroid : AdIds.bannerIOS);
  }

  // --- Interstitial ---
  void loadInterstitial() {
    if (kIsWeb) return;
    String adUnitId = Platform.isAndroid ? AdIds.interstitialAndroid : AdIds.interstitialIOS;
    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (err) {
          _interstitialAd = null;
          // Retry later logic could go here
        },
      ),
    );
  }

  void showInterstitialIfReady() {
    if (kIsWeb) return;
    // 3 minute cooldown
    if (_lastInterstitialTime != null) {
      final difference = DateTime.now().difference(_lastInterstitialTime!);
      if (difference.inMinutes < 3) return;
    }

    if (_interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null;
      _lastInterstitialTime = DateTime.now();
      loadInterstitial(); // preload next
    }
  }

  // --- Rewarded ---
  void loadRewarded() {
    if (kIsWeb) return;
    String adUnitId = Platform.isAndroid ? AdIds.rewardedAndroid : AdIds.rewardedIOS;
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (err) {
          _rewardedAd = null;
        },
      ),
    );
  }

  void showRewarded({required Function onReward}) {
    if (kIsWeb) {
      onReward();
      return;
    }
    
    if (_rewardedAd != null) {
      _rewardedAd!.show(onUserEarnedReward: (ad, reward) {
        onReward();
      });
      _rewardedAd = null;
      loadRewarded(); // preload next
    } else {
      // Could show a snackbar saying "Ad not ready"
    }
  }
}

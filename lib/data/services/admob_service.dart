import 'dart:io';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// AdMob Service to manage ads throughout the app
class AdMobService extends GetxController {
  static AdMobService get to => Get.find();

  // Real Ad Unit IDs from AdMob Console
  static const String _androidBannerId =
      'ca-app-pub-1451522103593938/4871045695';
  static const String _iosBannerId = 'ca-app-pub-1451522103593938/4871045695';

  static const String _androidInterstitialId =
      'ca-app-pub-1451522103593938/8028231078';
  static const String _iosInterstitialId =
      'ca-app-pub-1451522103593938/8028231078';

  // Banner Ad
  BannerAd? _homeBannerAd;
  final Rx<bool> isBannerAdLoaded = false.obs;

  // Interstitial Ad
  InterstitialAd? _interstitialAd;
  final Rx<bool> isInterstitialAdLoaded = false.obs;
  int _interstitialLoadAttempts = 0;
  static const int _maxInterstitialLoadAttempts = 3;

  // Ad show counter for interstitials
  int _notesSavedCounter = 0;
  static const int _showInterstitialAfterNotes =
      1; // Show ad after every 1 note
  @override
  void onInit() {
    super.onInit();

    loadHomeBannerAd();
    _loadInterstitialAd();
  }

  @override
  void onClose() {
    _homeBannerAd?.dispose();
    _interstitialAd?.dispose();
    super.onClose();
  }

  /// Get Banner Ad Unit ID based on platform
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return _androidBannerId;
    } else if (Platform.isIOS) {
      return _iosBannerId;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  /// Get Interstitial Ad Unit ID based on platform
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return _androidInterstitialId;
    } else if (Platform.isIOS) {
      return _iosInterstitialId;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  /// Load Home Banner Ad
  void loadHomeBannerAd() {
    _homeBannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          isBannerAdLoaded.value = true;
          print('✅ Banner ad loaded successfully');
        },
        onAdFailedToLoad: (ad, error) {
          print('❌ Banner ad failed to load: ${error.message}');
          isBannerAdLoaded.value = false;
          ad.dispose();
          _homeBannerAd = null;

          // Retry after 60 seconds
          Future.delayed(const Duration(seconds: 60), () {
            if (_homeBannerAd == null) {
              loadHomeBannerAd();
            }
          });
        },
        onAdOpened: (ad) {
          print('📱 Banner ad opened');
        },
        onAdClosed: (ad) {
          print('🔒 Banner ad closed');
        },
      ),
    );

    _homeBannerAd?.load();
  }

  /// Get Home Banner Ad
  BannerAd? get homeBannerAd => _homeBannerAd;

  /// Load Interstitial Ad
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          isInterstitialAdLoaded.value = true;
          _interstitialLoadAttempts = 0;
          print('✅ Interstitial ad loaded successfully');

          // Set full screen content callback
          _interstitialAd?.fullScreenContentCallback =
              FullScreenContentCallback(
                onAdShowedFullScreenContent: (ad) {
                  print('📱 Interstitial ad showed full screen content');
                },
                onAdDismissedFullScreenContent: (ad) {
                  print('🔒 Interstitial ad dismissed');
                  ad.dispose();
                  _interstitialAd = null;
                  isInterstitialAdLoaded.value = false;
                  // Load next ad
                  _loadInterstitialAd();
                },
                onAdFailedToShowFullScreenContent: (ad, error) {
                  print('❌ Interstitial ad failed to show: ${error.message}');
                  ad.dispose();
                  _interstitialAd = null;
                  isInterstitialAdLoaded.value = false;
                  // Load next ad
                  _loadInterstitialAd();
                },
              );
        },
        onAdFailedToLoad: (error) {
          print('❌ Interstitial ad failed to load: ${error.message}');
          _interstitialLoadAttempts++;
          _interstitialAd = null;
          isInterstitialAdLoaded.value = false;

          // Retry with exponential backoff
          if (_interstitialLoadAttempts < _maxInterstitialLoadAttempts) {
            final delay = Duration(seconds: _interstitialLoadAttempts * 60);
            Future.delayed(delay, () {
              _loadInterstitialAd();
            });
          }
        },
      ),
    );
  }

  /// Show Interstitial Ad when saving a note
  void onNoteSaved() {
    _notesSavedCounter++;

    // Show ad after every 3 notes saved
    if (_notesSavedCounter >= _showInterstitialAfterNotes) {
      showInterstitialAd();
      _notesSavedCounter = 0; // Reset counter
    }
  }

  /// Show Interstitial Ad
  void showInterstitialAd() {
    if (_interstitialAd != null && isInterstitialAdLoaded.value) {
      _interstitialAd?.show();
    } else {
      print('⏳ Interstitial ad not ready yet');
      // Load if not already loading
      if (_interstitialAd == null && !isInterstitialAdLoaded.value) {
        _loadInterstitialAd();
      }
    }
  }

  /// Dispose Banner Ad
  void disposeBannerAd() {
    _homeBannerAd?.dispose();
    _homeBannerAd = null;
    isBannerAdLoaded.value = false;
  }

  /// Dispose Interstitial Ad
  void disposeInterstitialAd() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
    isInterstitialAdLoaded.value = false;
  }
}

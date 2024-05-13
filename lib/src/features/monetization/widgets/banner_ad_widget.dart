import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  void _loadAd() {
    if (_bannerAd != null) return;

    String? adUnitId;
    if (kDebugMode) {
      adUnitId = 'ca-app-pub-3940256099942544/9214589741';
    } else if (Platform.isAndroid) {
      adUnitId = 'ca-app-pub-6093298333256656/4449919191';
    } else if (Platform.isIOS) {
      adUnitId = 'ca-app-pub-6093298333256656/6762557078';
    }

    if (adUnitId != null) {
      final bannerAd = BannerAd(
        adUnitId: adUnitId,
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            if (!mounted) {
              ad.dispose();
              return;
            }

            setState(() {
              _bannerAd = ad as BannerAd;
            });
          },
          onAdFailedToLoad: (ad, error) {
            developer.log(
              error.toString(),
              name: 'BannerAdException',
              time: DateTime.now(),
            );
            ad.dispose();
          },
        ),
        request: const AdRequest(),
      );

      bannerAd.load();
    }
  }

  @override
  Widget build(BuildContext context) {
    const double height = 55;
    final double width = MediaQuery.of(context).size.width;

    if (_bannerAd == null) {
      return const SizedBox();
    } else {
      return Column(
        children: [
          const Divider(height: 0),
          Stack(
            children: [
              const SizedBox(
                height: height,
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height,
                    width: width,
                    child: AdWidget(ad: _bannerAd!),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    }
  }
}

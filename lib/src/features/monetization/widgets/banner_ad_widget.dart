import 'dart:developer' as developer;
import 'dart:io';

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
    if (Platform.isAndroid) {
      adUnitId = 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      adUnitId = 'ca-app-pub-3940256099942544/2934735716';
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
    if (_bannerAd == null) {
      return const SizedBox();
    } else {
      return Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            const Divider(height: 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: AdSize.banner.height.toDouble(),
                  width: AdSize.banner.width.toDouble(),
                  child: AdWidget(ad: _bannerAd!),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}

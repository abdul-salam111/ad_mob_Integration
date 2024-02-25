import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initBannerAd();
  }
  late BannerAd bannerAd;
  bool isAdLoaded = false;
  //ad id..........from admob account
  initBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: '',
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              isAdLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, err) {
            ad.dispose();
          },
        ),
        request: const AdRequest());
    bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: isAdLoaded
          ? SizedBox(
              height: bannerAd.size.height.toDouble(),
              width: bannerAd.size.width.toDouble(),
              child: AdWidget(
                ad: bannerAd,
              ),
            )
          : SizedBox(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}

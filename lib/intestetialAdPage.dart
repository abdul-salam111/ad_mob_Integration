import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InstertitialsAdPage extends StatefulWidget {
  const InstertitialsAdPage({super.key});

  @override
  State<InstertitialsAdPage> createState() => _InstertitialsAdPageState();
}

class _InstertitialsAdPageState extends State<InstertitialsAdPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initInterstitialAd();
  }

  late InterstitialAd interstitialAd;
  bool isAdLoaded = false;
  initInterstitialAd() {
    InterstitialAd.load(
      adUnitId: '',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          setState(() {
            isAdLoaded = true;
          });
          interstitialAd.fullScreenContentCallback=FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad){
                ad.dispose();
                //do whatever you want after the ad is disposed 
                print("ok");
              },
              onAdFailedToShowFullScreenContent: (ad,err){
                  ad.dispose();

              }
          );
        },
        onAdFailedToLoad: (error) {
          interstitialAd.dispose();

        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  if (isAdLoaded) {
                    interstitialAd.show();
                  }
                },
                child: Text("Show Add"))
          ],
        ),
      ),
    );
  }
}

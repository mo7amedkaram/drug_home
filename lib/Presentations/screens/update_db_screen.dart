import 'package:drug_home/Ads%20Helper/ad_helper.dart';
import 'package:drug_home/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';

import '../../business_logic/cubit/update_data_from_server_cubit.dart';
import '../../business_logic/cubit/update_data_from_server_state.dart';

class UpdateDbScreen extends StatefulWidget {
  const UpdateDbScreen({super.key});

  @override
  State<UpdateDbScreen> createState() => _UpdateDbScreenState();
}

class _UpdateDbScreenState extends State<UpdateDbScreen> {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {},
          );

          setState(() {
            _interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //--------- load ads ------
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    ).load();
    _loadInterstitialAd();
  }

  @override
  void dispose() {
    // TODO: Dispose an InterstitialAd object
    _interstitialAd?.dispose();
    _bannerAd?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initiate data fetching when the widget is built
    context.read<UpdateDataFromServerCubit>().fetchData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Drug home update Drugs'),
        backgroundColor: AppColor.mainColor,
      ),
      body: BlocConsumer<UpdateDataFromServerCubit, UpdateDataFromServerState>(
        listener: (context, state) {
          if (state is UpdateDataFromServerError) {
            // Show error message if data fetching fails
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is UpdateDataFromServerWaiting) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/waiting.json"),
                    const Text("جاري تحديث البيانات"),
                  ],
                )),
                if (_bannerAd != null)
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: _bannerAd!.size.width.toDouble(),
                      height: _bannerAd!.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd!),
                    ),
                  ),
              ],
            ));
          } else if (state is UpdateDataFromServerLoaded) {
            // Render your data here
            if (_interstitialAd != null) {
              _interstitialAd?.show();
            }
            return Center(child: Lottie.asset('assets/done.json'));
          } else {
            return const Center(
                child: Text(
                    'انتهى وقت الإتصال, برجاء التحقق من سرعة الإنترنت لديك'));
          }
        },
      ),
    );
  }
}

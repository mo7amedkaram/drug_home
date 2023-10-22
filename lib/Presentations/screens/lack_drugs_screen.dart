import 'package:auto_size_text/auto_size_text.dart';
import 'package:drug_home/Ads%20Helper/ad_helper.dart';
import 'package:drug_home/business_logic/cubit/lack_drugs_cubit.dart';
import 'package:drug_home/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class LackDrugsScreen extends StatefulWidget {
  const LackDrugsScreen({super.key});

  @override
  State<LackDrugsScreen> createState() => _LackDrugsScreenState();
}

class _LackDrugsScreenState extends State<LackDrugsScreen> {
  Map<int, int> drugCounts = {};
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    context.read<LackDrugsCubit>().loadDrugs();

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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bannerAd?.dispose();
  }

  void _copyToClipboard(List<dynamic> drugsList) {
    String clipboardString = "";
    for (var drug in drugsList) {
      clipboardString +=
          " ${drug['arabicDrugName']} : (${drugCounts[drug['id']]} علبة)\n";
    }
    Clipboard.setData(ClipboardData(text: clipboardString)).then((result) {
      const snackBar = SnackBar(
        content: AutoSizeText(
          'تم نسخ جميع النواقص يمكنك لصقها مباشرة في أي مكان',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.mainColor,
          title: const AutoSizeText(
            "Drug Home",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    AppColor.secondaryColor)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            label: const AutoSizeText(
                              "Back to search",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          ElevatedButton.icon(
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.red),
                            ),
                            onPressed: () async {
                              context.read<LackDrugsCubit>().deleteAllDrugs();
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            label: const AutoSizeText(
                              "حذف كل النواقص",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 54, 0, 85)),
                        child: const Center(
                          child: AutoSizeText(
                            "صفحة النواقص",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      BlocBuilder<LackDrugsCubit, LackDrugsState>(
                        builder: (context, state) {
                          if (state is LackDrugsLoaded) {
                            if (drugCounts.isEmpty) {
                              for (var drug in state.data) {
                                drugCounts[drug['id']] =
                                    1; // set initial count for each drug
                              }
                            }
                            return DataTable(
                              border:
                                  TableBorder.all(color: AppColor.mainColor),
                              columnSpacing: 7.0,
                              headingRowHeight: height * 0.05,
                              horizontalMargin: 1.0,
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Center(
                                    child: Text(
                                      "حذف",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Center(
                                    child: Text(
                                      "سعر",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Center(
                                    child: Text(
                                      "الكمية",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Center(
                                    child: Text(
                                      "الصنف",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Center(
                                    child: Text(
                                      "م",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              rows: state.data.asMap().entries.map(
                                (entry) {
                                  int idx = entry.key;
                                  Map<String, dynamic> drug = entry.value;

                                  return DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                        Center(
                                          child: IconButton(
                                            onPressed: () {
                                              context
                                                  .read<LackDrugsCubit>()
                                                  .deleteSpecificDrug(
                                                      id: drug["id"]);
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Text(
                                            "${drug["price"]}",
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.red,
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    setState(
                                                      () {
                                                        drugCounts[drug[
                                                            'id']] = (drugCounts[
                                                                    drug[
                                                                        'id']]! -
                                                                1)
                                                            .clamp(1,
                                                                double.infinity)
                                                            .toInt(); // decrease count for this drug
                                                      },
                                                    );
                                                  },
                                                  icon:
                                                      const Icon(Icons.remove),
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "${drugCounts[drug['id']]}",
                                                textAlign: TextAlign.end,
                                                style: const TextStyle(
                                                    fontSize: 15),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.green,
                                                ),
                                                margin: const EdgeInsets.all(5),
                                                child: IconButton(
                                                  onPressed: () {
                                                    setState(
                                                      () {
                                                        drugCounts[drug[
                                                            'id']] = (drugCounts[
                                                                    drug[
                                                                        'id']]! +
                                                                1)
                                                            .toInt(); // increase count for this drug
                                                      },
                                                    );
                                                  },
                                                  icon: const Icon(Icons.add),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          "${drug["arabicDrugName"]}",
                                          textAlign: TextAlign
                                              .right, // Align this cell to the right
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Text(
                                              "${idx + 1}"), // use idx + 1 to get a 1-based index
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ).toList(),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                      //--------------------
                      BlocBuilder<LackDrugsCubit, LackDrugsState>(
                        builder: (context, state) {
                          // ... other widget building logic ...

                          return ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    AppColor.secondaryColor)),
                            onPressed: () {
                              if (state is LackDrugsLoaded) {
                                _copyToClipboard(state
                                    .data); // Assuming state.data is List<Map<String, dynamic>>
                              } else {
                                // You can show some feedback to the user if the state is not LackDrugsLoaded
                              }
                            },
                            icon: const Icon(
                              Icons.copy,
                              color: Colors.white,
                            ),
                            label: const AutoSizeText(
                              "نسخ جميع النواقص",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          );

                          // ... remaining build method ...
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
  }
}

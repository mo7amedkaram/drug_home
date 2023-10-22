import 'package:auto_size_text/auto_size_text.dart';
import 'package:drug_home/constants/colors.dart';
import 'package:drug_home/data/model/drugs_model.dart';
import 'package:flutter/material.dart';

import '../../data/repository/drugs_lack_repo.dart';

class DrugDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> drugDetails;

  DrugDetailsScreen({super.key, required this.drugDetails});

  @override
  State<DrugDetailsScreen> createState() => _DrugDetailsScreenState();
}

class _DrugDetailsScreenState extends State<DrugDetailsScreen> {
  List<DrugList> nearName = [];
  List<DrugList> allDrugs = [];
  List<DrugList> similarDrugs = [];
  List<DrugList> alternativeDrugs = [];

  // DrugDetailsScreen({super.key});
  void getNearName() {
    allDrugs = List<DrugList>.from(widget.drugDetails["allDrugs"]);
    String searchTerm =
        widget.drugDetails["drug"].name.substring(0, 5).toLowerCase();

    nearName = allDrugs
        .where((drug) => drug.name!.toLowerCase().startsWith(searchTerm))
        .toList();
    setState(() {});
  }

  void getSimilarDrugs() {
    List<DrugList> completeDrug = widget.drugDetails["allDrugs"];
    similarDrugs = completeDrug
        .where((drug) => drug.activeConstituents!
            .toLowerCase()
            .contains("${widget.drugDetails["drug"].activeConstituents}"))
        .toList(); // You can refine this comparison as needed.
    setState(() {});
  }

  void getAlternativeDrugs() {
    List<DrugList> completeDrug = widget.drugDetails["allDrugs"];
    alternativeDrugs = completeDrug
        .where((drug) => drug.description!
            .toLowerCase()
            .startsWith("${widget.drugDetails["drug"].description}"))
        .toList(); // You can refine this comparison as needed.
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNearName();
    getSimilarDrugs();
    getAlternativeDrugs();
  }

  void addLackDrug() {}
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        title: const AutoSizeText(
          "Drug Home",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              DrugsLackRepository.createItem(
                widget.drugDetails["drug"].name,
                1,
                double.parse(widget.drugDetails["drug"].price),
                widget.drugDetails["drug"].arabic,
              ).whenComplete(
                () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("تم إضافة العنصر في قائمة النواقص"),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
            label: const AutoSizeText(
              "نواقص",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 5, 2, 141)),
                  child: Center(
                    child: AutoSizeText(
                      "${widget.drugDetails["drug"].name}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 5, 100, 179),
                  ),
                  child: Table(
                    border: TableBorder.all(color: Colors.grey),
                    children: [
                      const TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: AutoSizeText(
                              "Item",
                              style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: AutoSizeText(
                                "Details",
                                style: TextStyle(
                                  color: Colors.yellow,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: AutoSizeText(
                              "Name",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: AutoSizeText(
                              "${widget.drugDetails["drug"].name}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: AutoSizeText(
                              "Price",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: AutoSizeText(
                              "${widget.drugDetails["drug"].price}.L.E.",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: AutoSizeText(
                              "Old Price",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: AutoSizeText(
                              "${widget.drugDetails["drug"].oldprice ?? "لا يوجد"}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: AutoSizeText(
                              "Active Sub.",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: AutoSizeText(
                              "${widget.drugDetails["drug"].activeConstituents}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: AutoSizeText(
                              "Pharmacology",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "${widget.drugDetails["drug"].description}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: AutoSizeText(
                              "Dosage Form",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: AutoSizeText(
                              "${widget.drugDetails["drug"].dosageForm}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: AutoSizeText(
                              "Units",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: AutoSizeText(
                              "${widget.drugDetails["drug"].units} units",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: AutoSizeText(
                              "Company",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: AutoSizeText(
                              "${widget.drugDetails["drug"].company}",
                              style: const TextStyle(
                                  color: Colors.yellow, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: AutoSizeText(
                              "Barcode",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: AutoSizeText(
                              "${widget.drugDetails["drug"].barcode}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //----------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(AppColor.secondaryColor),
                      ),
                      onPressed: () => Navigator.pushNamed(
                        context,
                        "/similarDrugScreen",
                        arguments: {
                          "allSimilarsDrugs": this.similarDrugs,
                          "currentDrugs": widget.drugDetails["drug"],
                          "alterDrugs": alternativeDrugs
                        },
                      ),
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      label: const AutoSizeText(
                        "Similars",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        "/alternativeDrugScreen",
                        arguments: {
                          "currentDrug": widget.drugDetails["drug"],
                          "alterDrugs": alternativeDrugs
                        },
                      ),
                      icon: const Icon(Icons.change_circle),
                      label: const AutoSizeText("Alters",
                          style: TextStyle(fontSize: 18)),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(AppColor.secondaryColor),
                      ),
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      label: const AutoSizeText(
                        "Back",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  height: height * 0.07,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 83, 7, 7),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: AutoSizeText(
                      "Near Names:",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: nearName.length,
                  itemBuilder: (_, index) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 38, 0, 39),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width * 0.6,
                              child: AutoSizeText(
                                "${nearName[index].name}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            AutoSizeText(
                              "${nearName[index].price}.L.E.",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

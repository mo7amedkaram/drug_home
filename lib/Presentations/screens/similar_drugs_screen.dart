import 'package:auto_size_text/auto_size_text.dart';
import 'package:drug_home/constants/colors.dart';
import 'package:flutter/material.dart';

class SimilarDrugs extends StatelessWidget {
  final Map<String, dynamic> similarDrugs;
  SimilarDrugs({super.key, required this.similarDrugs});

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                        AppColor.secondaryColor,
                      )),
                      onPressed: () => Navigator.pushNamed(
                            context,
                            "/alternativeDrugScreen",
                            arguments: {
                              "currentDrug": similarDrugs["currentDrugs"],
                              "alterDrugs": similarDrugs["alterDrugs"]
                            },
                          ),
                      child: const AutoSizeText(
                        "Alternatives",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                      AppColor.secondaryColor,
                    )),
                    onPressed: () {},
                    label: const AutoSizeText(
                      "Back to search",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AttentionCardForAlterAndSimilarDrugs(similarDrugs: similarDrugs),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: similarDrugs["allSimilarsDrugs"].length,
                itemBuilder: (_, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: SizedBox(
                            width: width * 0.7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black, // Default text color
                                    ),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text:
                                            "${similarDrugs["allSimilarsDrugs"][index].name}(",
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 5, 0, 82),
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "${similarDrugs["allSimilarsDrugs"][index].dosageForm}",
                                        style: const TextStyle(
                                            color: Color.fromARGB(255, 0, 0,
                                                0) // Red color for drug.units
                                            ),
                                      ),
                                      const TextSpan(
                                        text: ") ",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 5, 0,
                                              82), // Red color for drug.units
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: width * 0.7,
                                      child: AutoSizeText(
                                          "${similarDrugs["allSimilarsDrugs"][index].company}"),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black, // Default text color
                            ),
                            children: <InlineSpan>[
                              TextSpan(
                                text:
                                    "${similarDrugs["allSimilarsDrugs"][index].price}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 245, 4, 4),
                                ),
                              ),
                              const TextSpan(
                                text: ".L.E.",
                                style: TextStyle(
                                    color:
                                        Colors.black // Red color for drug.units
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class AttentionCardForAlterAndSimilarDrugs extends StatelessWidget {
  const AttentionCardForAlterAndSimilarDrugs({
    super.key,
    required this.similarDrugs,
  });

  final Map<String, dynamic> similarDrugs;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.black),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Default text color
                ),
                children: <InlineSpan>[
                  const TextSpan(
                      text: "Similars of ",
                      style: TextStyle(color: Colors.white)),
                  TextSpan(
                    text: "${similarDrugs["currentDrugs"].name}",
                    style: const TextStyle(
                        color: Colors.yellow // Red color for drug.units
                        ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          SizedBox(
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Default text color
                ),
                children: [
                  const TextSpan(
                    text: "Based on the same active ingredients : ",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextSpan(
                    text: "${similarDrugs["currentDrugs"].activeConstituents}",
                    style: const TextStyle(
                        color: Colors.yellow // Red color for drug.units
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

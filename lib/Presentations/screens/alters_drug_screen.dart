import 'package:auto_size_text/auto_size_text.dart';
import 'package:drug_home/constants/colors.dart';
import 'package:flutter/material.dart';

class AlternativeDrugsScreen extends StatelessWidget {
  final Map<String, dynamic> altersDrug;
  const AlternativeDrugsScreen({super.key, required this.altersDrug});

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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black, // Default text color
                          ),
                          children: <InlineSpan>[
                            const TextSpan(
                                text: "Alternatives of ",
                                style: TextStyle(color: Colors.white)),
                            TextSpan(
                              text: "${altersDrug["currentDrug"].name}",
                              style: const TextStyle(
                                  color:
                                      Colors.yellow // Red color for drug.units
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
                              text:
                                  "Based on the same Pharmacological properties: ",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text: "${altersDrug["currentDrug"].description}",
                              style: const TextStyle(
                                  color:
                                      Colors.yellow // Red color for drug.units
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: altersDrug["alterDrugs"].length,
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
                        Flexible(
                          flex: 5,
                          child: SizedBox(
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
                                            "${altersDrug["alterDrugs"][index].name}(",
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 5, 0, 82),
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "${altersDrug["alterDrugs"][index].dosageForm}",
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
                                          "${altersDrug["alterDrugs"][index].company}"),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black, // Default text color
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                  text:
                                      "${altersDrug["alterDrugs"][index].price}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 245, 4, 4),
                                  ),
                                ),
                                const TextSpan(
                                  text: ".L.E.",
                                  style: TextStyle(
                                      color: Colors
                                          .black // Red color for drug.units
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

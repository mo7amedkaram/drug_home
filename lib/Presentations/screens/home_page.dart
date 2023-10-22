import 'package:drug_home/business_logic/cubit/drugs_cubit.dart';
import 'package:drug_home/business_logic/cubit/drugs_state.dart';
import 'package:drug_home/data/model/drugs_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/colors.dart';
import '../widgets/drawer_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  String dropdownValue = 'Trade Name';
  List<DrugList> allDrugs = [];
  List<DrugList> searchedDrugs = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DrugsCubit>(context).getAllDrugs();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget buildDrugItem() {
    if (searchController.text.isEmpty) {
      return Container(); // Return an empty container when there is no search text.
    }

    return BlocBuilder<DrugsCubit, DrugsState>(
      builder: ((context, state) {
        if (state is DrugsLoaded) {
          allDrugs = (state).allDrugs;

          return drugCardItem(
              allDrugs: searchedDrugs.isEmpty ? allDrugs : searchedDrugs);
        } else {
          return const Text("");
        }
      }),
    );
  }

  void searchedForDrugs(String letterSearch) {
    if (letterSearch.isEmpty) {
      // Clear the search results
      setState(() {
        searchedDrugs.clear();
      });
    } else {
      List<DrugList> filterResults(
          List<DrugList> drugs, String filterKey, String filterValue) {
        return drugs.where((drug) {
          if (filterKey == 'Price') {
            return drug.price != null &&
                drug.price!.toLowerCase().startsWith(filterValue.toLowerCase());
          } else if (filterKey == 'Trade Name') {
            return drug.name != null &&
                drug.name!.toLowerCase().startsWith(filterValue.toLowerCase());
          } else if (filterKey == 'Active Ing.') {
            return drug.activeConstituents != null &&
                drug.activeConstituents!
                    .toLowerCase()
                    .startsWith(filterValue.toLowerCase());
          } else if (filterKey == 'Pharmacology') {
            return drug.description != null &&
                drug.description!
                    .toLowerCase()
                    .startsWith(filterValue.toLowerCase());
          } else if (filterKey == 'Company') {
            return drug.company != null &&
                drug.company!
                    .toLowerCase()
                    .startsWith(filterValue.toLowerCase());
          } else if (filterKey == 'Old Price') {
            return drug.oldprice != null &&
                drug.oldprice!
                    .toLowerCase()
                    .startsWith(filterValue.toLowerCase());
          } else if (filterKey == 'Arabic Name') {
            return drug.arabic != null &&
                drug.arabic!
                    .toLowerCase()
                    .startsWith(filterValue.toLowerCase());
          }
          return false;
        }).toList();
      }

      searchedDrugs = filterResults(allDrugs, dropdownValue, letterSearch);
      setState(() {});
    }
  }

  Widget drugCardItem({required allDrugs}) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ListView.builder(
      itemCount: allDrugs.length,
      itemBuilder: (context, index) {
        final drug = allDrugs[index];
        double calcUnitPrice(drugPrice, drugUnits) {
          return drugPrice / drugUnits;
        }

        var calculatedPriceUnit =
            calcUnitPrice(double.parse(drug.price), drug.units);
        return InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            "/drugDetailsScreen",
            arguments: {
              "drug": drug,
              "allDrugs": this.allDrugs,
            },
          ),
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColor.mainColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width * 0.7,
                      child: AutoSizeText(
                        "${drug.name}.",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          height: 1.25,
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.7,
                      child: AutoSizeText(
                        "${drug.activeConstituents}.",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          height: 1.25,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.7,
                      child: AutoSizeText(
                        "${drug.description}",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          height: 1.25,
                          fontSize: 15,
                          color: Color.fromARGB(255, 255, 208, 67),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.7,
                      child: AutoSizeText(
                        "${drug.company}",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          height: 1.25,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.7,
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black, // Default text color
                          ),
                          children: <InlineSpan>[
                            const TextSpan(
                              text: "(",
                            ),
                            TextSpan(
                              text: drug.units.toString(),
                              style: const TextStyle(
                                color: Color.fromARGB(
                                    255, 255, 0, 0), // Red color for drug.units
                              ),
                            ),
                            const TextSpan(
                              text: " units) > unit price: ",
                            ),
                            TextSpan(
                              text: calculatedPriceUnit.toStringAsFixed(2),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 255, 0,
                                    0), // Red color for calculatedPriceUnit
                              ),
                            ),
                            const TextSpan(
                              text: " L.E.",
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  width: width * 0.19,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          "${drug.price}",
                          style: TextStyle(
                              fontSize: 25,
                              color: AppColor.secondaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        AutoSizeText(
                          "Old: ${drug.oldprice == "" ? drug.price : drug.oldprice}",
                          style: const TextStyle(
                              height: 1,
                              fontStyle: FontStyle.italic,
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        title: const AutoSizeText(
          "Drug Home",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: height * 0.06,
                    width: width * 0.60,
                    child: TextField(
                      controller: searchController,
                      onChanged: (text) {
                        searchedForDrugs(text);
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintStyle: const TextStyle(fontSize: 18),
                          hintText: "Add your search keyword..."),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Container(
                    height: height * 0.06,
                    width: width * 0.35,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColor.secondaryColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey, // Set border color
                        width: 1.0, // Set border width
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        isExpanded: true, // Set this for better layout support
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        dropdownColor: AppColor.secondaryColor,
                        items: <String>[
                          'Trade Name',
                          'Active Ing.',
                          'Pharmacology',
                          'Price',
                          'Company',
                          'Arabic Name',
                          'Any Field'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: buildDrugItem(),
              ), // Empty expanded container to push down the Text widget

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          AppColor.secondaryColor,
                        ),
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, "/updateDbScreen"),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const AutoSizeText(
                            "Update Data",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          const Icon(
                            Icons.update,
                            color: Colors.yellow,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          AppColor.secondaryColor,
                        ),
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, "/lackDrugScreen"),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const AutoSizeText(
                            "إدارة النواقص",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          const Icon(
                            Icons.list,
                            color: Colors.yellow,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: DrawerWidget(),
    );
  }
}

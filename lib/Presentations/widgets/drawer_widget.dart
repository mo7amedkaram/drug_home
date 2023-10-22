import 'package:drug_home/Presentations/widgets/drawer_contents.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({
    super.key,
  });
  final Uri facebookPageUrl =
      Uri.parse('https://www.facebook.com/dwaprices?mibextid=ZbWKwL');
  final Uri facebookGroupUrl = Uri.parse(
      'https://m.facebook.com/groups/drughome/?ref=share&mibextid=ydkPgX');
  final Uri contactUsUrl = Uri.parse('https://dwaprices.com/contact_us.php');
  //------------
  Future<void> _launchUrl({required url}) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        width: width * 0.6,
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              child: Image.asset("assets/logo.png"),
            ),
            const Divider(),
            InkWell(
              onTap: () => _launchUrl(url: facebookPageUrl),
              child: DrawerContentWidgets(
                icon: const Icon(
                  Icons.facebook,
                  color: Colors.blue,
                ),
                text: "Facebook Page",
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () => _launchUrl(url: facebookGroupUrl),
              child: DrawerContentWidgets(
                icon: const Icon(
                  Icons.group,
                  color: Colors.blue,
                ),
                text: "Facebook Group",
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () => _launchUrl(url: contactUsUrl),
              child: DrawerContentWidgets(
                icon: const Icon(
                  Icons.contact_support,
                  color: Colors.blue,
                ),
                text: "Contact Us",
              ),
            ),
            const Divider(),
            const Text(
              "Drug Home V1.0",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

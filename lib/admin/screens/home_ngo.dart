import 'dart:convert';

import 'package:fcb_donate/admin/screens/request.dart';
import 'package:fcb_donate/constants/colors.dart';
import 'package:fcb_donate/features/auth/screens/first_screen.dart';
import 'package:fcb_donate/provider/ngoprovider.dart';
import 'package:fcb_donate/provider/userprovider.dart';
import 'package:fcb_donate/utils/container_image.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import 'package:provider/provider.dart';

import '../../models/ngo.dart';
import '../services/ngo_services.dart';
import '../widgets/ngorowdetails.dart';

class MyHomeNgoAdmin extends StatefulWidget {
  static const routeName = '/ngoadmin';
  const MyHomeNgoAdmin({super.key});

  @override
  State<MyHomeNgoAdmin> createState() => _MyHomeNgoAdminState();
}

class _MyHomeNgoAdminState extends State<MyHomeNgoAdmin> {
  final NgoServices ngoServices = NgoServices();
  @override
  void initState() {
    super.initState();
    getNgoDetails();
  }

  Ngo? ngo;
  void getNgoDetails() async {
    var ngos = Provider.of<NgoProvider>(context, listen: false).ngo;
    ngo = await ngoServices.getNgoDetails(context: context, id: ngos.id);
    setState(() {});
  }

  bool isBright = true;
  void dark() {
    if (isBright) {
      setState(() {
        isBright = false;
      });
    } else {
      setState(() {
        isBright = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ngoProvider = Provider.of<NgoProvider>(context, listen: false).ngo;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: dark,
                      child: MyContainerImage(
                        widget: isBright
                            ? const Icon(
                                Icons.nights_stay_outlined,
                                color: themeColor,
                              )
                            : const Icon(
                                Icons.sunny,
                                color: themeColor,
                              ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, FirstScreen.routeName, (route) => false);
                      },
                      child: const MyContainerImage(
                        widget: Icon(
                          Icons.login_rounded,
                          color: themeColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(50),
                Container(
                  height: 150,
                  width: 150,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/ngo.jpg"), fit: BoxFit.cover),
                    shape: BoxShape.circle,
                  ),
                ),
                const Gap(5),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    ngoProvider.username,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.black87, fontSize: 20),
                  ),
                ),
                const Gap(50),
                NgoRowDetails(
                  leftText: "Admin Name",
                  rightText: ngoProvider.ngo_admin,
                ),
                const Gap(10),
                NgoRowDetails(
                  leftText: "Contact Details",
                  rightText: ngoProvider.mobile_no,
                ),
                const Gap(10),
                NgoRowDetails(
                  leftText: "Area",
                  rightText: ngoProvider.area,
                ),
                const Gap(10),
                NgoRowDetails(
                  leftText: "City",
                  rightText: ngoProvider.city,
                ),
                const Gap(10),
                NgoRowDetails(
                  leftText: "Description",
                  rightText: ngoProvider.description,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

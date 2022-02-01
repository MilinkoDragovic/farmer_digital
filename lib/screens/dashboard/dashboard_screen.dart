import 'package:farmer_digital/responsive.dart';
// import 'package:flutterdemo/screens/dashboard/components/my_fields.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/header.dart';

// import 'components/recent_files.dart';
// import 'components/storage_details.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          const Header(),
          const SizedBox(height: defaultPadding),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    // MyFles(),
                    const SizedBox(height: defaultPadding),
                    // RecentFiles(),
                    if (Responsive.isMobile(context))
                      const SizedBox(height: defaultPadding),
                    // if (Responsive.isMobile(context)) StorageDetails(),
                  ],
                ),
              ),
              if (!Responsive.isMobile(context))
                const SizedBox(width: defaultPadding),
              // if (!Responsive.isMobile(context))
              //   Expanded(
              //     flex: 5,
              //     child: StorageDetails(),
              //   )
            ],
          )
        ],
      ),
    ));
  }
}

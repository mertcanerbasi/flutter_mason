import 'package:flutter/material.dart';
import '../../../core/res/colors.gen.dart';
import '../../../core/res/icons.dart';

class NoConnectivityPage extends StatelessWidget {
  const NoConnectivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: FittedBox(
                  child: Icon(AppIcons.noConnectivity,
                      color: AppColors.primarySwatch)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  Text(
                    "İnternet Bağlantısı Bulunamadı",
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "İnternet bağlantınızı kontrol edip tekrar deneyin.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

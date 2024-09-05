// Dart imports:
import 'dart:math';

import 'package:flutter/material.dart';
import '../../../core/res/colors.gen.dart';

enum SirenType {
  force, //Forces user to update your app
  option, //DEFAULT) Presents user with option to update app now or at next launch
  skip, //Presents user with option to update the app now, at next launch, or to skip this version all together
  none //Doesn't show the alert, but instead returns a localized message for use in a custom UI within the onDetectNewVersion() callback
}

typedef DetectNewVersion = void Function(
    String version,
    SirenType
        sirenType); // Siren performed version check and did not display alert

class Siren {
  SirenType majorUpdateAlertType = SirenType.option;
  SirenType minorUpdateAlertType = SirenType.option;
  SirenType patchUpdateAlertType = SirenType.option;
  SirenType revisionUpdateAlertType = SirenType.option;
  SirenType versionCodeUpdateAlertType = SirenType.option;

  ///Determines the type of alert that should be shown for major version updates: A.b.c
  void setMajorUpdateAlertType(SirenType majorUpdateAlertType) {
    this.majorUpdateAlertType = majorUpdateAlertType;
  }

  /// Determines the type of alert that should be shown for minor version updates: a.B.c
  void setMinorUpdateAlertType(SirenType minorUpdateAlertType) {
    this.minorUpdateAlertType = minorUpdateAlertType;
  }

  /// Determines the type of alert that should be shown for minor patch updates: a.b.C
  void setPatchUpdateAlertType(SirenType patchUpdateAlertType) {
    this.patchUpdateAlertType = patchUpdateAlertType;
  }

  /// Determines the type of alert that should be shown for revision updates: a.b.c.D
  void setRevisionUpdateAlertType(SirenType revisionUpdateAlertType) {
    this.revisionUpdateAlertType = revisionUpdateAlertType;
  }

  /// Determines alert type during version code verification
  void setVersionCodeUpdateAlertType(SirenType versionCodeUpdateAlertType) {
    this.versionCodeUpdateAlertType = versionCodeUpdateAlertType;
  }

  checkVersionName(
      {required String minVersion,
      required String currentVersion,
      required DetectNewVersion onDetectNewVersion,
      bool versionCheckEnabled = true,
      bool forceUpdateEnabled = false}) {
    if (!versionCheckEnabled) {
      return;
    }
    List<String> minVersionNumbers = minVersion.split(".");
    List<String> currentVersionNumbers = currentVersion.split(".");
    SirenType? sirenType;
    if (minVersionNumbers.length == currentVersionNumbers.length) {
      bool versionUpdateDetected = false;
      for (var index = 0;
          index < min(minVersionNumbers.length, currentVersionNumbers.length);
          index++) {
        int compareResult =
            checkVersionDigit(minVersionNumbers, currentVersionNumbers, index);
        if (compareResult == 1) {
          versionUpdateDetected = true;
          if (forceUpdateEnabled) {
            sirenType = SirenType.force;
          } else {
            switch (index) {
              case 0:
                sirenType = majorUpdateAlertType;
                break;
              case 1:
                sirenType = minorUpdateAlertType;
                break;
              case 2:
                sirenType = patchUpdateAlertType;
                break;
              case 3:
                sirenType = revisionUpdateAlertType;
                break;
              default:
                sirenType = SirenType.none;
                break;
            }
          }
          break;
        } else if (compareResult == -1) {
          return;
        }
      }

      if (versionUpdateDetected) {
        onDetectNewVersion(minVersion, sirenType!);
      }
    }
  }

  int checkVersionDigit(List<String> minVersionNumbers,
      List<String> currentVersionNumbers, int digitIndex) {
    if (minVersionNumbers.length > digitIndex) {
      if (isGreater(
          minVersionNumbers[digitIndex], currentVersionNumbers[digitIndex])) {
        return 1;
      } else if (isEquals(
          minVersionNumbers[digitIndex], currentVersionNumbers[digitIndex])) {
        return 0;
      }
    }
    return -1;
  }

  bool isGreater(String first, String second) {
    return isNumeric(first) &&
        isNumeric(second) &&
        int.parse(first) > int.parse(second);
  }

  bool isEquals(String first, String second) {
    return isNumeric(first) &&
        isNumeric(second) &&
        int.parse(first) == int.parse(second);
  }

  bool isNumeric(String string) {
    if (string.isEmpty || num.tryParse(string) == null) {
      return false;
    }
    return true;
  }
}

class ForceUpdatePage extends StatelessWidget {
  final VoidCallback update;
  const ForceUpdatePage({super.key, required this.update});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(
              child: FittedBox(
                  child: Icon(Icons.rocket_launch_outlined,
                      color: AppColors.primarySwatch)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  Text(
                    "Güncelleme Mevcut",
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Uygulamanın yeni bir sürümü mevcut.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            ElevatedButton(onPressed: update, child: const Text("Güncelle")),
          ],
        ),
      ),
    );
  }
}

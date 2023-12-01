import 'package:reports/app/app_prefs.dart';
import 'package:reports/app/di.dart';
import 'package:reports/presentation/resources/assets_manager.dart';
import 'package:flutter/cupertino.dart';

final AppPreferences _appPreferences = instance<AppPreferences>();

class Constant {
  static const String baseurl = "https://roayadesign.com/api_s/tqarer_a3meda_s3udia/";
  static const String empty = "";
  static const String columnModel = "ColumnModel";
  static const String mainBoxName = 'reportName';
  static String token = _appPreferences.getToken();
  static const int zero = 0;
  static const Duration timeout = Duration(milliseconds: 60000); //this time by ms
  static const String image = ImageAssets.personal;
  static Map<String, List<ExerciseObject>> exercisesData = {
    "HigH pull": [
      ExerciseObject(
        name: 'Deadlift to High Pull',
        image: ImageAssets.deadliftToHigh,
      ),
      ExerciseObject(
        name: 'RDL to High Pull',
        image: ImageAssets.rdlToHighPull,
      ),
      ExerciseObject(
        name: 'Single Arm High Pull Left',
        image: ImageAssets.singleArmHighPullLeft,
      ),
      ExerciseObject(
        name: 'Single Arm High Pull Right',
        image: ImageAssets.singleArmHighPullLeft,
      ),
    ],
    "Leg Curl": [
      ExerciseObject(
        name: 'Seated leg Curl',
        image: '',
      ),
      ExerciseObject(
        name: 'prone Leg Curl',
        image: '',
      ),
      ExerciseObject(
        name: 'Seated Leg Curl Single Leg',
        image: '',
      ),
      ExerciseObject(
        name: 'Seated Leg Curl Single Leg Overload',
        image: '',
      ),
      ExerciseObject(
        name: 'Standing Leg Curl',
        image: '',
      ),
    ],
    "Oblique Variations": [
      ExerciseObject(
        name: 'Core Rotations Left',
        image: '',
      ),
      ExerciseObject(
        name: 'Cor Rotations Right',
        image: '',
      ),
      ExerciseObject(
        name: 'Crunches',
        image: '',
      ),
      ExerciseObject(
        name: 'Rotational Sling Rotation',
        image: '',
      ),
      ExerciseObject(
        name: 'Side Bend Left',
        image: '',
      ),
      ExerciseObject(
        name: 'Side Crunch',
        image: '',
      ),
      ExerciseObject(
        name: 'Standing Core Twist',
        image: '',
      ),
    ],
    "OverHead Press": [
      ExerciseObject(
        name: "OverheadPress Left ",
        image: '',
      ),
      ExerciseObject(
        name: "Overhead press",
        image: '',
      ),
      ExerciseObject(
        name: "Seated Shoulder press",
        image: '',
      ),
    ],
  };
  static List<String> category = exercisesData.keys.toList();
}

class ExerciseObject {
  String name;
  String image;

  ExerciseObject({required this.name, required this.image});
}

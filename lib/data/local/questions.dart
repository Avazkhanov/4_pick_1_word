import 'package:words_game/data/models/game_model.dart';
import 'package:words_game/utils/app_images/app_images.dart';

List<GameModel> data = [
  GameModel(
    images: [
      AppImages.teacher1,
      AppImages.teacher2,
      AppImages.teacher3,
      AppImages.teacher4,
    ],
    result: "teacher",
  ),
  GameModel(
    images: [
      AppImages.box1,
      AppImages.box2,
      AppImages.box3,
      AppImages.box4,
    ],
    result: "box",
  ),
  GameModel(
    images: [
      AppImages.milk1,
      AppImages.milk2,
      AppImages.milk3,
      AppImages.milk4,
    ],
    result: "milk",
  ),
  GameModel(
    images: [
      AppImages.car1,
      AppImages.car2,
      AppImages.car3,
      AppImages.car4,
    ],
    result: "car",
  ),
];

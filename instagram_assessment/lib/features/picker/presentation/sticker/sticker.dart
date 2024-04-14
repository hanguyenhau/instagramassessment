class Stickers {
  List<List<String>> list() {
    return [
      dog(),
      nature(),
      girl(),
      food()
    ];
  }

  List<String> dog() {
    List<String> list = [];
    for (int i = 1; i <= 5; i++) {
      list.add('assets/stickers/dog_$i.png');
    }
    return list;
  }

  List<String> nature() {
    List<String> list = [];
    for (int i = 1; i <= 5; i++) {
      list.add('assets/stickers/nature_$i.png');
    }
    return list;
  }

  List<String> food() {
    List<String> list = [];
    for (int i = 1; i <= 5; i++) {
      list.add('assets/stickers/food_$i.png');
    }
    return list;
  }

  List<String> girl() {
    List<String> list = [];
    for (int i = 1; i <= 5; i++) {
      list.add('assets/stickers/girl_$i.png');
    }
    return list;
  }
}

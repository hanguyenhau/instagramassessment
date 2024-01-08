extension HexColorToColor on String{
  int convertHexColorToColor(){
    String currentColor = this.replaceAll('#', '');
    if(currentColor.length == 6){
      currentColor = '0xff$currentColor';
    }
    return int.parse(currentColor);
  }
}
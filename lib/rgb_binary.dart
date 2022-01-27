import 'package:flutter/material.dart';
Color test = Color(0xFFff0000);
List<int> rValues = [0,1,2,3];
List<int> gValues = [0,4,8,12];
List<int> bValues = [0,16,32,48];

int p100 = 255;// 255 = 100%
int p60 = 153;// 153 = 60%
int p30 = 77;// 76.5 = 30%
int p0 = 0;// 0 = 0%

int threshHigh = (p100-(p100-p60)/2).toInt();
int threshMedium = (p60-(p60-p30)/2).toInt();
int threshLow = (p30/3).toInt();

int redToBinary(int redIntensity){
  return (
      redIntensity>threshHigh?
      rValues[3]:(
          redIntensity>threshMedium?
          rValues[2]:(
              redIntensity>threshLow?
              rValues[1]:rValues[0])));
}
int greenToBinary(int greenIntensity){
  return (
      greenIntensity>threshHigh?
      gValues[3]:(
          greenIntensity>threshMedium?
          gValues[2]:(
              greenIntensity>threshLow?
              gValues[1]:gValues[0])));
}
int blueToBinary(int blueIntensity){
  return (
      blueIntensity>threshHigh?
      bValues[3]:(
          blueIntensity>threshMedium?
          bValues[2]:(
              blueIntensity>threshLow?
              bValues[1]:bValues[0])));
}

int rgbToBinary(int redIntensity, int greenIntensity, int blueIntensity){
  return (redToBinary(redIntensity)+greenToBinary(greenIntensity)+blueToBinary(blueIntensity));
}

int hexToBinary(Color color){
  int redValue = color.red;
  int greenValue = color.green;
  int blueValue = color.blue;
  return rgbToBinary(redValue, greenValue, blueValue);
}

int integerToBinary(int integer){
  int binary = 0, i = 1;
  while(integer >0){
    binary = binary+(integer%2)*i;
    integer = (integer/2).floor();
    i = i*10;
  }
  return binary;
}

bool isNumeric(String string){
  if(string == null){
    return false;
  }
  return double.tryParse(string) != null;
}

bool checkIfBinary(int binaryInteger){
  bool bin = true;
  String digitsString = binaryInteger.toString();
  if(isNumeric(digitsString)){
    while(digitsString.length > 0){
      String letter = digitsString.substring(0,1);
      if(int.parse(letter)!=0 || int.parse(letter)!=1){
          bin = false;
      }
      digitsString = digitsString.substring(1);
    }
  }
  return bin;
}

int binaryToInteger(int binary){
  return checkIfBinary(binary)?int.parse(binary.toString(), radix: 2):-1;
}

List<int> allNumbersUpToInteger(int integer){
  List<int> allNumbers = [];
  while(integer>-1){
    allNumbers.add(integer);
    integer--;
  }
  return allNumbers;
}

List<int> allBinaryNumbersUpToInteger(int integer){
  List<int> binaries = [];
  while(integer>1){
    binaries.add(integerToBinary(integer));
    integer--;
  }
  return binaries;
}

List<bool> binaryToBoolean(int binary){
  List<bool> bools = [];
  String binString = binary.toString();
  while(binString.length>0){
    String binDigit = binString.substring(0,1);
    bools.add(binDigit=='1'?true:false);
    binString = binString.substring(1);
  }
  return bools;
}

Color integerToColor(int integer){
  Color color = Color(0xff000000);

  return color;
}
List steps = [p0, p30, p60, p100];

List<List> getRGBsteps(){
  List<List> rgbSteps = [];
  for(int blue in steps) {
    for(int green in steps) {
      for(int red in steps) {
        rgbSteps.add([red,green,blue]);
      }
    }
  }
  return rgbSteps;
}

List rgbSteps = getRGBsteps();

Color getColorFromRGB(List rgb){
  return Color.fromARGB(255, rgb[0], rgb[1], rgb[2]);
}


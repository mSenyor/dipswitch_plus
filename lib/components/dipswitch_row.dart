import 'package:dipswitch_plus/components/single_dip.dart';
import 'package:flutter/material.dart';

List<List> dipSwitches = [
  [false,1,1],
  [false,2,2],
  [false,4,3],
  [false,8,4],
  [false,16,5],
  [false,32,6],
  [false,64,7],
  [false,128,8],
  [false,256,9],
  [false,512,10],];

void switchDip(int dipNumber){
  dipSwitches[dipNumber-1][0] = !dipSwitches[dipNumber-1][0];
}


class DipswitchRow extends StatefulWidget {
  const DipswitchRow({Key? key}) : super(key: key);

  @override
  _DipswitchRowState createState() => _DipswitchRowState();
}

class _DipswitchRowState extends State<DipswitchRow> {

  switchDip(int dipNumber){
      dipSwitches[dipNumber-1][0] = !dipSwitches[dipNumber-1][0];
  }

  List<SingleDip> getDips(){
    List<SingleDip> dipList = [];
    for(List dip in dipSwitches){
      dipList.insert(
        0,
        SingleDip(
          onPress:(){
            setState(() {
              switchDip(dip[2]);
              // print(dipSwitches);
            });
          },
          on: dip[0],
          switchValue: dip[1],
          switchNumber: dip[2],
        ),
      );
    }
    return dipList;
  }

  test(){
    print('test');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: getDips(),
    );
  }
}

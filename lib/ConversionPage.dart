import 'package:converter_pro/Utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConversionPage extends StatefulWidget{

  ConversionPage(this.fatherNode);

  Node fatherNode;

  @override
  _ConversionPage createState() => new _ConversionPage(fatherNode);
}

class _ConversionPage extends State<ConversionPage>{

  Node fatherNode;
  List<Node> listaNodi;
  List<TextEditingController> listaController=new List();

  _ConversionPage(Node fatherNode){
    this.fatherNode=fatherNode;
    listaNodi=fatherNode.getNodiFiglio();
    for(Node node in listaNodi)
      listaController.add(new TextEditingController());
  }


  List<UnitCard> _createList(){
    List<UnitCard> listaCard=new List();
    for (int i=0; i<listaNodi.length;i++){
      Node nodo=listaNodi[i];
      TextEditingController controller;
      controller=listaController[i];


      if(nodo.value!=null && !nodo.selectedNode)
        controller.text = nodo.value.toString();
      else if(nodo.value==null && !nodo.selectedNode)
        controller.text = "";

      listaCard.add(new UnitCard(
          node: nodo,
          textField: TextField(
            style: TextStyle(fontSize: 16.0,color: Colors.black,),
            keyboardType: TextInputType.numberWithOptions(decimal: true,signed: false),
            controller: controller,
            onChanged: (String txt){
              nodo.value = txt == "" ? null : double.parse(txt);
              print(txt);
              setState(() {
                fatherNode.ResetConvertedNode();
                fatherNode.Convert();
              });
            },
          )
      ));
    }
    return listaCard;
  }


  @override
  Widget build(BuildContext context) {
    List<UnitCard> listCard=_createList();

    return Scaffold(
      appBar: AppBar(title: new Text("Lunghezza"),),
      body: ListView(
        padding: new EdgeInsets.all(10.0),
        children: listCard
      ),
    );
  }
}

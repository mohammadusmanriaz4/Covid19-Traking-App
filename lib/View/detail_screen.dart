import 'package:covid19_tracking_app/View/world_states.dart';
import 'package:flutter/material.dart';



class DetailScreen extends StatefulWidget 
{
  final String name;
  final String image;

  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, tests;
  DetailScreen
  ({
  super.key,
  required this.name,
  required this.image,
  required this.active,
  required this.critical,
  required this.tests,
  required this.totalRecovered,
  required this.todayRecovered,
  required this.totalCases,
  required this.totalDeaths,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
  return SafeArea(
  child: Scaffold(
  
  appBar: AppBar(
  centerTitle: true,
  title: Text(widget.name),
  ),


  body: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
  children: [

    Stack(
    alignment: Alignment.topCenter,
    children: [
    Padding(
      padding: EdgeInsets.only(
      top: MediaQuery.of(context).size.height * 0.067,
      ),
      child: Card(
      child: Column(
      children: 
      [
        
      
      SizedBox(
      height: MediaQuery.of(context).size.height *0.01,
      ),

      
      ReuseableRow(title: 'Cases', value: widget.totalCases.toString()),
      ReuseableRow(title: 'Active Cases', value: widget.active.toString() ),
      ReuseableRow(title: 'Critical Cases', value: widget.critical.toString()),
      ReuseableRow(title: 'Total Recovered Cases', value:widget.totalRecovered.toString() ),
      ReuseableRow(title: 'Today Recovered Cases', value: widget.todayRecovered.toString()),
      ReuseableRow(title: 'Total Deaths', value: widget.totalDeaths.toString()),
      ReuseableRow(title: 'Tests', value: widget.tests.toString()),
      //ReuseableRow(title: '', value: ),
    
      ],
      ),
      ),
    ),

    CircleAvatar(
    radius: 50,
    backgroundImage: NetworkImage(widget.image),
    ),
    ],
    ),
  



  ],
  ),
  ),
  );
  }
}
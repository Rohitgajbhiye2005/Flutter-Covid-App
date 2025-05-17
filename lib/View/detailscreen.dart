import 'package:covid_app/View/worldstat.dart';
import 'package:flutter/material.dart';

class Detailscreen extends StatefulWidget {
  String name, image;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;

  Detailscreen({
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.todayRecovered,
    required this.active,
    required this.critical,
    required this.totalRecovered,
    required this.test,
    required this.image,
  });

  @override
  State<Detailscreen> createState() => _DetailscreenState();
}

class _DetailscreenState extends State<Detailscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.5),
        backgroundColor: Colors.blueAccent,
        title: Text(
          widget.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),
              SizedBox(height: 20),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Reusablerow(title: 'Cases', value: widget.totalCases.toString()),
                      Reusablerow(title: 'Recovered', value: widget.totalRecovered.toString()),
                      Reusablerow(title: 'Deaths', value: widget.totalDeaths.toString()),
                      Reusablerow(title: 'Critical', value: widget.critical.toString()),
                      Reusablerow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                      Reusablerow(title: 'Active', value: widget.active.toString()),
                      Reusablerow(title: 'Tests', value: widget.test.toString()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

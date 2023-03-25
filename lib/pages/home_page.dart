import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_5/pages/search_history.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var chnceOfrain;
  var cityname_weather;
  var temp;
  var maxtimp;
  var mintimp;
  var iconWeather;
  final TextEditingController SearchController = TextEditingController();

  // Future myweather({
  //   required String cityname,
  // }) async {
  //   final http.Response respne;
  //   Uri url = Uri.parse(
  //       'http://api.weatherapi.com/v1/forecast.json?key=b1242acfe43e49b8afa42843232802&q=$cityname&days=1&aqi=no&alerts=no');
  //   respne = await http.get(url);

  //   Map<String, dynamic> data = jsonDecode(respne.body);
  //   print(data);

  //   localtime = data['location']['localtime'];
  //   print(localtime);
  //   // String temp = data['forcast']['forcastday'][0]['day']['avgtemp_c'];
  // }

  String? cityname;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 29, 29, 29),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(left: 4, top: 4),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 95, 95, 95), borderRadius: BorderRadius.circular(12)),
                    width: double.infinity,
                    child: Center(
                      child: TextField(
                        controller: SearchController,
                        onSubmitted: (value) async {
                          final http.Response respne;
                          Uri url = Uri.parse(
                              'http://api.weatherapi.com/v1/forecast.json?key=b1242acfe43e49b8afa42843232802&q=$value&days=1&aqi=no&alerts=no');
                          respne = await http.get(url);

                          Map<String, dynamic> data = jsonDecode(respne.body);
                          print(data);
                          cityname_weather = data['location']['name'];

                          chnceOfrain = data['location']['localtime'];
                          iconWeather = data['forecast']['forecastday'][0]['day']['condition']['icon'];
                          temp = data['forecast']['forecastday'][0]['day']['avgtemp_c'];
                          maxtimp = data['forecast']['forecastday'][0]['day']['maxtemp_c'];
                          mintimp = data['forecast']['forecastday'][0]['day']['mintemp_c'];
                          chnceOfrain = data['forecast']['forecastday'][0]['day']['daily_chance_of_rain'];
                          print(chnceOfrain);
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search for city',
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                maxtimp == null
                    ? const Text('')
                    : InkWell(
                        onTap: () {
                          setState(() {
                            maxtimp = null;
                            mintimp = null;
                            chnceOfrain = null;
                            temp = null;
                            cityname_weather = null;
                            iconWeather = null;
                            SearchController.clear();
                          });
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Cancel\nSearch',
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      )
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            const Text(
              'Today Weather',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 38),
            ),
            const SizedBox(height: 16),
            cityname_weather == null
                ? const Text(
                    '',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 38),
                  )
                : Text(
                    '${cityname_weather!}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 38),
                  ),
            const SizedBox(
              height: 44,
            ),
            iconWeather == null
                ? const Text(
                    'No Weather yet',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  )
                : Image.network(
                    iconWeather,
                  ),
            const Row(
              children: [
                SizedBox(
                  width: 250,
                ),
              ],
            ),
            Text(
              temp == null ? '0' : '${temp!}\u2103',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 44, color: Colors.white),
            ),
            const SizedBox(
              height: 24,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  height: 100,
                  width: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 187, 77, 214), width: 0.6),
                    boxShadow: const [
                      BoxShadow(color: Color.fromARGB(251, 119, 57, 133), blurRadius: 2, spreadRadius: 0.2)
                    ],
                    color: Color.fromARGB(255, 50, 29, 53),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Min temp ',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(mintimp == null ? '0' : '${mintimp!}\u2103',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white))
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  height: 100,
                  width: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 235, 152, 29), width: 0.6),
                    boxShadow: const [
                      BoxShadow(color: Color.fromARGB(255, 155, 93, 1), blurRadius: 2, spreadRadius: 0.2)
                    ],
                    color: Color.fromARGB(255, 100, 55, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Max temp',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(maxtimp == null ? '0' : '${maxtimp!}\u2103',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white))
                    ],
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  height: 100,
                  width: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 29, 125, 235), width: 0.6),
                    boxShadow: const [
                      BoxShadow(color: Color.fromARGB(255, 16, 79, 128), blurRadius: 2, spreadRadius: 0.2)
                    ],
                    color: Color.fromARGB(255, 39, 49, 71),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Rain %',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(chnceOfrain == null ? '0' : '${chnceOfrain!}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white))
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

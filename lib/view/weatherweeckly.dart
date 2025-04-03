import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:weather_app/controller/dailyController.dart';
import 'package:weather_app/controller/homeController.dart';
import 'package:weather_app/view/HomePage.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
// ignore: must_be_immutable
class WeatherWeeckly extends StatelessWidget {
  List weatherParameters = ['WIND_SPEED', 'CLOUDY', 'HUMIDITY'];
  String timezone = Get.arguments;

  final Dailycontroller dailyController = Get.put(Dailycontroller());
  HomeController controller = Get.put(HomeController());
  late RxString city;
  late RxString country;
  WeatherWeeckly({super.key}) {
    city = timezone.split('/')[0].obs;
    country = timezone.split('/')[1].obs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF33267A),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            IconButton(
                onPressed: () {
                  Get.to(() => HomePage());
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Next 7 days",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 60),
            Stack(
              children: [
                Container(
                  width: 400,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6ECFF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AnimatedTextKit(
                          animatedTexts:[
                            TyperAnimatedText(
                              speed: const Duration(seconds: 5),
                              textStyle: const TextStyle(
                              color: Colors.black, fontSize: 25),
                              dailyController
                              .date(dailyController.daily.value![0]!.dt!,
                            ),
                            ),
                          ]
                          
                      
                        ),
                        Row(
                          children: [
                            Text(
                              '${dailyController.daily.value![0]!.tempday!.round()}°',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                ',${dailyController.daily.value![0]!.weather![0]['description'].toString().toUpperCase()}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                            height:
                                30), 
                        Row(
                          children: [
                            ...List.generate(
                              3,
                              (int index) => Padding(
                                padding: const EdgeInsets.only(right: 11),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Obx(() => Text(
                                              textAlign: TextAlign.start,
                                              dailyController
                                                  .weatherValues[index]
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            )),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          weatherParameters[index],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 7),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => Text(
                                      country.value,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 17),
                                    )),
                                Obx(() => Text(
                                      city.value,
                                      style:
                                          const TextStyle(color: Colors.black,
                                           fontSize: 18),
                                    )),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: -18,
                    right: -18,
                    child: Image.asset(
                      'assets/weather/${dailyController.daily.value![0]!.weather![0]['icon']}.png',
                    ))
              ],
            ),
            const SizedBox(height: 20),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                color: Color(0xFF312475),
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/weather/${dailyController.daily.value![index + 1]!.weather![0]['icon']}.png",
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        dailyController.daily.value![index + 1]!.tempday
                            .toString(),
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white),
                      )
                    ],
                  ),
                  leading: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedTextKit(
                        animatedTexts:[
                          TyperAnimatedText(
                            speed: const Duration(seconds: 5),
                            curve: Curves.decelerate,
                            textStyle:
                            const TextStyle(fontSize: 18, color: Colors.white),
                            dailyController
                            .date(dailyController.daily.value![index + 1]!.dt!)
                          )
                        ]
                        ,
                      ),
                      Text(
                        dailyController.daily.value![index + 1]!.weather![0]
                            ['description'],
                        style: const TextStyle(
                            fontSize: 18, color: Colors.white60),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

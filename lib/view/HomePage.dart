import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/controller/currentController.dart';
import 'package:weather_app/controller/homeController.dart';
import 'package:weather_app/controller/hourlyController.dart';
import 'package:weather_app/view/weatherweeckly.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animate_gradient/animate_gradient.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomeController controller = Get.put(HomeController());
  final CurrentController currentController = Get.put(CurrentController());
  final Hourlycontroller hourlyController = Get.put(Hourlycontroller());
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF33267A),
      body: ListView(
        padding: const EdgeInsets.only(right: 20, left: 20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                width: 400,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () {
                              if (controller.searchController.text.isNotEmpty) {
                                controller.Search();
                              }
                            },
                            child: const Icon(
                              Icons.search,
                              color: Colors.black,
                            )),
                        hintText: "search by place",
                        hintStyle: const TextStyle(color: Colors.blue),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    controller: controller.searchController),
              ),
              const SizedBox(height: 10),
              Obx(
                () =>  controller.search.value
                    ? InkWell(
                        onTap: () {
                          controller.GetStarted();
                        },
                        child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "weather of my location",
                                    style: TextStyle(
                                        color: Colors.blue[800],
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.blue[800],
                                    size: 20,
                                  )
                                ],
                              ),
                            )),
                      )
                    : const SizedBox.shrink(),
              ),
              Obx(
                () => controller.is_loading.value == true
                    ? const Padding(
                        padding: EdgeInsets.only(top: 300),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : controller.data_found.value == true ||
                            controller.data_seach_found.value == true
                        ? Column(
                            children: [
                              const SizedBox(height: 30),
                              Obx(
                                () => AnimatedTextKit(
                                  animatedTexts: [
                                    TyperAnimatedText(
                                      speed: const Duration(seconds: 5),
                                        textAlign: TextAlign.start,
                                        textStyle: const TextStyle(
                                            color: Colors.white, fontSize: 30),
                                        controller
                                            .currentController.timezone!.value)
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 320,
                                      height: 470,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF1E1647),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Obx(
                                            () => Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    'assets/weather/${currentController.currentData.value!.weather![0]['icon']}.png'),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Obx(
                                                () => AnimatedTextKit(
                                                  animatedTexts: [
                                                    TyperAnimatedText(
                                                      speed: const Duration(seconds: 5),
                                                      curve: Easing
                                                          .emphasizedAccelerate,
                                                      textStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 30),
                                                      currentController
                                                              .currentData
                                                              .value!
                                                              .weather![0]
                                                          ['description'],
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Obx(
                                                () => Text(
                                                  textAlign: TextAlign.center,
                                                  controller.DataToday.value,
                                                  style: const TextStyle(
                                                      color: Colors.white24,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Obx(
                                                () => Text(
                                                  textAlign: TextAlign.center,
                                                  "${currentController.currentData.value!.temp}°",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 50),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ...List.generate(3, (int index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10, left: 5),
                                                  child: Stack(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: AnimateGradient(
                                                          primaryBegin:
                                                              Alignment.topLeft,
                                                          primaryEnd: Alignment
                                                              .bottomRight,
                                                          secondaryBegin:
                                                              Alignment
                                                                  .topCenter,
                                                          secondaryEnd:
                                                              Alignment
                                                                  .bottomCenter,
                                                          primaryColors: const [
                                                            Colors.white,
                                                            Color(
                                                                0xFF33267A),
                                                          ],
                                                          secondaryColors: const [
                                                            Color(
                                                                0xFF33267A),
                                                            Color
                                                                .fromARGB(135,
                                                                220, 45, 220),
                                                          ],
                                                          child: Container(
                                                            width: 80,
                                                            height: 120,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              5),
                                                                  child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(20),
                                                                      child: Image.asset(
                                                                        "assets/listweather${index + 1}.JPG",
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                      )),
                                                                ),
                                                                const SizedBox(
                                                                    height: 5),
                                                                Obx(
                                                                  () => Text(
                                                                    "${currentController.temp[index]}%",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                currentController.text[
                                                                            index] ==
                                                                        "WIND_SPEED"
                                                                    ? const SizedBox(
                                                                        height:
                                                                            2)
                                                                    : const SizedBox
                                                                        .shrink(),
                                                                Text(
                                                                  currentController
                                                                          .text[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize: currentController.text[index] ==
                                                                              "WIND_SPEED"
                                                                          ? 12.5
                                                                          : null),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                          top: 0.1,
                                                          right: 17,
                                                          child: Container(
                                                            width: 40,
                                                            height: 2,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white30,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40)),
                                                          ))
                                                    ],
                                                  ),
                                                );
                                              }),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        top: 1,
                                        right: 50,
                                        child: Container(
                                          width: 230,
                                          height: 0.4,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white),
                                        ))
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text(
                                    "Today",
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.white),
                                  ),
                                  const SizedBox(width: 190),
                                  InkWell(
                                      onTap: () {
                                        Get.to(() => WeatherWeeckly(),
                                            arguments: controller
                                                .currentController
                                                .timezone!
                                                .value);
                                      },
                                      child: const Text(
                                        "Next Week",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Container(
                                    height: 120,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromARGB(
                                            255, 231, 188, 255)),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.asset(
                                              'assets/weather/${currentController.currentData.value!.weather![0]['icon']}.png',
                                              height: 50,
                                              width: 50,
                                            )),
                                        const SizedBox(height: 10),
                                        const Text(
                                          "Now",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          currentController
                                              .currentData.value!.temp
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: SizedBox(
                                        height: 120,
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  const SizedBox(width: 10),
                                          itemCount: hourlyController
                                                      .hourly.value.length >
                                                  12
                                              ? 12
                                              : hourlyController
                                                  .hourly.value.length,
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              Container(
                                            width: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color(0xFF4D2F9F)),
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.asset(
                                                      "assets/weather/${hourlyController.hourly.value[index]!.weather![0]['icon']}.png",
                                                      height: 50,
                                                      width: 50,
                                                    )),
                                                const SizedBox(height: 10),
                                                Text(
                                                  hourlyController.date(
                                                      hourlyController.hourly
                                                          .value[index]!.dt!),
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  hourlyController
                                                      .hourly.value[index]!.temp
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        )),
                                  )
                                ],
                              )
                            ],
                          )
                        : controller.data_found.value == false &&
                                controller.data_seach_found.value == true
                            ? const Center(
                                child: Text(
                                  "Error Geting data",
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : Center(
                                child: Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: Column(
                                  children: [
                                    Lottie.asset(
                                        "assets/lotie/data_not_found.json"),
                                    RichText(
                                        text: TextSpan(children: [
                                      const TextSpan(
                                          text: 'place',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          )),
                                      const WidgetSpan(
                                          child: SizedBox(width: 5)),
                                      const TextSpan(text: '"'),
                                      TextSpan(
                                          text:
                                              controller.searchController.text,
                                          style: TextStyle(
                                            color: Colors.blue[500],
                                            fontSize: 20,
                                          )),
                                      const TextSpan(text: '"'),
                                      const WidgetSpan(
                                          child: SizedBox(width: 5)),
                                      const TextSpan(
                                          text: 'Not Found',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ))
                                    ])),
                                  ],
                                ),
                              )),
              )
            ],
          )
        ],
      ),
    );
  }
}

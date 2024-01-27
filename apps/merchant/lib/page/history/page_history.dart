import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_marchant/page/history/controller_history.dart';
import 'package:lugo_marchant/shared/utils.dart';

class PageHistory extends GetView<ControllerHistory> {
  const PageHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    controller.orderValue.value,
                    style: GoogleFonts.readexPro(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.sort),
                  onSelected: (item) {
                    controller.loading.value = Status.loading;
                    controller.handleGetOrders(item);
                    controller.loading.value = Status.success;
                    if (item == "day") {
                      controller.orderValue("Hari Ini");
                    }
                    if (item == "week") {
                      controller.orderValue("Minggu Ini");
                    }
                    if (item == "month") {
                      controller.orderValue("Bulan Ini");
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem<String>(
                      value: "day",
                      child: Text('Hari Ini'),
                    ),
                    const PopupMenuItem<String>(
                      value: "week",
                      child: Text('Minggu Ini'),
                    ),
                    const PopupMenuItem<String>(
                      value: "month",
                      child: Text('Bulan Ini'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(
                () => controller.loading.value == Status.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.orders.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                child: SizedBox(
                                  width: Get.width,
                                  child: Card(
                                    elevation: 5,
                                    surfaceTintColor: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 10, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'ID Order | ${controller.orders[index]['id']}',
                                                style: GoogleFonts.readexPro(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              AnimatedRatingStars(
                                                starSize: 16,
                                                readOnly: true,
                                                initialRating: 5,
                                                onChanged: (p0) {},
                                                customEmptyIcon:
                                                    Icons.star_rounded,
                                                customFilledIcon:
                                                    Icons.star_rounded,
                                                customHalfFilledIcon:
                                                    Icons.star_rounded,
                                              )
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Divider(
                                            height: 1,
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Nama Customer',
                                                style: GoogleFonts.readexPro(
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                controller.orders[index]
                                                    ['customer']['name'],
                                                style: GoogleFonts.readexPro(
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        controller.orders[index]?['driver'] !=
                                                null
                                            ? Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 5, 10, 0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Text(
                                                          'Nama Driver',
                                                          style: GoogleFonts
                                                              .readexPro(
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          controller.orders[
                                                                      index]
                                                                  ['driver']
                                                              ['name'],
                                                          style: GoogleFonts
                                                              .readexPro(
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 5, 10, 0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Text(
                                                          'Plat Nomor',
                                                          style: GoogleFonts
                                                              .readexPro(
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          controller.orders[
                                                                          index]
                                                                      ['driver']
                                                                  [
                                                                  'driver_details']
                                                              [
                                                              'vehicle']['vehicle_rn'],
                                                          style: GoogleFonts
                                                              .readexPro(
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 5, 10, 0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Text(
                                                          'Kendaraan',
                                                          style: GoogleFonts
                                                              .readexPro(
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          controller.orders[index]
                                                                          [
                                                                          'driver']
                                                                      [
                                                                      'driver_details']
                                                                  ['vehicle']
                                                              ['vehicle_brand'],
                                                          style: GoogleFonts
                                                              .readexPro(
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Divider(
                                                      height: 1,
                                                      thickness: 1,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : const SizedBox(),
                                        ...(controller.orders[index]
                                                    ['order_items']
                                                as List<dynamic>)
                                            .map(
                                          (e) {
                                            final data =
                                                e as Map<String, dynamic>;
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 0, 10, 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        '${data['product']['name']}',
                                                        style: GoogleFonts
                                                            .readexPro(
                                                          color: Colors.black87,
                                                        ),
                                                      ),
                                                      Text(
                                                        intlNumberCurrency(
                                                          data['product']
                                                                  ['price'] *
                                                              data['quantity'],
                                                        ),
                                                        style: GoogleFonts
                                                            .readexPro(
                                                          color: Colors.black87,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${data['quantity']}x',
                                                        style: GoogleFonts
                                                            .readexPro(
                                                          color: Colors.black87,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ).toList(),
                                        const Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Divider(
                                            height: 1,
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Divider(
                                            height: 1,
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Total',
                                                style: GoogleFonts.readexPro(
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                intlNumberCurrency(
                                                    controller.orders[index]
                                                        ['gross_amount']),
                                                style: GoogleFonts.readexPro(
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

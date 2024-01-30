import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lugo_customer/page/running_order/controller_running.dart';
import 'package:lugo_customer/response/live_transaction.dart';
import 'package:lugo_customer/shared/utils.dart';

class PageRunning extends GetView<ControllerRunning> {
  const PageRunning({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Pesanan Berjalan',
          style:
              GoogleFonts.readexPro(fontSize: 22, fontWeight: FontWeight.w400),
        ),
      ),
      body: Obx(() => controller.orderId.value.isNotEmpty || controller.orderId.value != ''
          ? StreamBuilder<LiveTransaction?>(
              stream: controller.trackTransaction(),
              builder: (context, snapshot) {

                if(snapshot.data?.driverId != null){
                  controller.findDriverDetail(snapshot.data?.driverId);
                  if (snapshot.hasData) {
                    return snapshot.data != null
                        ? CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: SizedBox(
                              width: Get.width,
                              child: Card(
                                elevation: 5,
                                surfaceTintColor: const Color(0xFF3978EF),
                                color: Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          snapshot.data?.orderType == 'CAR'
                                              ? const Icon(CupertinoIcons.car, color: Color(0xFF3978EF))
                                              : snapshot.data?.orderType == 'BIKE'
                                              ? const Icon(Icons.directions_bike, color: Color(0xFF3978EF))
                                              : snapshot.data?.orderType == 'FOOD'
                                              ? const Icon(Icons.fastfood_rounded, color: Color(0xFF3978EF))
                                              : snapshot.data?.orderType == 'MART'
                                              ? const Icon(Icons.shopping_bag_rounded, color: Color(0xFF3978EF))
                                              : snapshot.data?.orderType == 'DELIVERY'
                                              ? const Icon(CupertinoIcons.gift, color: Color(0xFF3978EF))
                                              : const SizedBox(),
                                          Text(
                                            DateFormat("dd MMMM yyyy").format(snapshot.data!.createdAt!),
                                            style: GoogleFonts.readexPro(
                                                color: Colors.grey,
                                                fontSize: 12
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Jenis Pembayaran',
                                            style: GoogleFonts.readexPro(
                                                color: Colors.grey,
                                                fontSize: 12
                                            ),
                                          ),
                                          Text(
                                            '${snapshot.data?.paymentType}',
                                            style: GoogleFonts.readexPro(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                                fontSize: 12
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Total Pembayaran',
                                            style: GoogleFonts.readexPro(
                                                color: Colors.grey,
                                                fontSize: 12
                                            ),
                                          ),
                                          Text(
                                            convertToIdr(controller.price.value, 0),
                                            style: GoogleFonts.readexPro(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                                fontSize: 12
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
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: SizedBox(
                              width: Get.width,
                              child: Card(
                                elevation: 5,
                                surfaceTintColor: const Color(0xFF3978EF),
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 10),
                                            child: CachedNetworkImage(
                                              imageUrl: controller.driver.value.avatar ?? '',
                                              errorWidget: (context, url, error) => SizedBox(
                                                width: 70,
                                                height: 70,
                                                child: Card(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(100)),
                                                  child: const Icon(Icons.person_rounded,
                                                      size: 40, color: Colors.black54),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.driver.value.name ?? 'Driver',
                                                style: GoogleFonts.readexPro(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              Text(
                                                controller.driver.value.id ?? 'Driver',
                                                style: GoogleFonts.readexPro(
                                                    fontSize: 12
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Kendaraan',
                                            style: GoogleFonts.readexPro(
                                                color: Colors.grey,
                                                fontSize: 12
                                            ),
                                          ),
                                          Text(
                                            '${controller.driver.value.driverDetails?.vehicle?.vehicleBrand}',
                                            style: GoogleFonts.readexPro(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                                fontSize: 12
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Nomor Plat',
                                            style: GoogleFonts.readexPro(
                                                color: Colors.grey,
                                                fontSize: 12
                                            ),
                                          ),
                                          Text(
                                            '${controller.driver.value.driverDetails?.vehicle?.vehicleRn}',
                                            style: GoogleFonts.readexPro(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                                fontSize: 12
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      width: Get.width * 0.25,
                                      margin:  const EdgeInsets.only(bottom: 20, right: 20),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.transparent,
                                          border: Border.all(
                                              width: 1,
                                              color: const Color(0xFF3978EF)
                                          )
                                      ),
                                      child: Center(
                                        child: Text(
                                          snapshot.data!.status!,
                                          style: GoogleFonts.readexPro(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                        : Center(
                      child: Text(
                        "Anda sedang tidak memiliki pesanan",
                        style: GoogleFonts.readexPro(fontSize: 14),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Ada yang salah",
                        style: GoogleFonts.readexPro(fontSize: 14),
                      ),
                    );
                  }
                }else{
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          : Center(
              child: Text(
              "Anda tidak punya pesanan",
              style: GoogleFonts.readexPro(fontSize: 20),
            ))),
    );
  }
}

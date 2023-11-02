import 'package:agencies_app/widgets/event_card.dart';
import 'package:agencies_app/widgets/manage_card.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.home_filled)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.man_2_outlined)),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/logos/indiaflaglogo.png'),
                    const SizedBox(
                      width: 21,
                    ),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jai Hind!',
                          style: GoogleFonts.inter().copyWith(fontSize: 12),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'NDRF Team REX78',
                          style: GoogleFonts.plusJakartaSans().copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              Container(
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.green,
                          size: 35,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Events',
                              style: GoogleFonts.inter().copyWith(
                                  color: Color.fromARGB(255, 220, 217, 217),
                                  fontSize: 12),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('120',
                                style: GoogleFonts.inter().copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                          ],
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: VerticalDivider(
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.green,
                          size: 35,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rescue Ops',
                              style: GoogleFonts.inter().copyWith(
                                  color: Color.fromARGB(255, 220, 217, 217),
                                  fontSize: 12),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('70',
                                style: GoogleFonts.inter().copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              Text(
                'Manage',
                style: GoogleFonts.plusJakartaSans().copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                children: [
                  ManageCard(text1: 'Alert for disaster', text2: 'Send Alert'),
                  SizedBox(
                    width: 11,
                  ),
                  ManageCard(text1: 'Rescue Operation', text2: 'Start'),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                children: [
                  ManageCard(text1: 'Awareness Event', text2: 'Organize Event'),
                  SizedBox(
                    width: 11,
                  ),
                  ManageCard(text1: 'History', text2: 'History'),
                ],
              ),
              const SizedBox(
                height: 31,
              ),
              Text(
                'Events',
                style: GoogleFonts.plusJakartaSans().copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 31,
              ),
              const Row(
                children: [
                  EventCard(
                    text1: 'E',
                    text2: 'Manage',
                    text3: 'Events',
                    color1: Color.fromARGB(232, 224, 83, 61),
                    color2: Color.fromARGB(232, 224, 83, 61),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  EventCard(
                    text1: 'M',
                    text2: 'Rescue',
                    text3: 'Map',
                    color1: Color.fromARGB(228, 231, 140, 157),
                    color2: Color.fromARGB(228, 231, 140, 157),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

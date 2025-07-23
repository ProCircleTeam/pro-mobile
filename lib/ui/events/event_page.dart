import 'package:flutter/material.dart';
import 'package:pro_mobile/ui/events/widgets/event_card.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/padded_container.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Events", weight: FontWeight.bold),
        leading: SizedBox(),
      ),
      body: SingleChildScrollView(
        child: Column(children: [PaddedContainer(child: EventCard(title: "Peering Session",))]),
      ),
    );
  }
}

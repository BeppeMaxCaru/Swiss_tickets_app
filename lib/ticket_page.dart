// ticket_detail_page.dart
import 'package:flutter/material.dart';

class TicketDetailPage extends StatelessWidget {
  final int ticketIndex;

  TicketDetailPage({required this.ticketIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Details'),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                color: Colors.red, // Replace with your desired background color
                width: double.infinity,
                height: 200,
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Ticket ${ticketIndex + 1} Description', // Replace with ticket description
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
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

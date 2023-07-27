import 'package:flutter/material.dart';
import 'dart:math';
import 'ticket_page.dart';

class RectangleListPage extends StatelessWidget {
  const RectangleListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available tickets'),
      ),
      body: _buildRectangleList(context),
    );
  }

  Widget _buildRectangleList(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        // Generate random original price and discounted price in CHF
        double originalPriceInCHF =
            Random().nextInt(100).toDouble() + Random().nextDouble() + 50;
        double discountedPriceInCHF =
            originalPriceInCHF * 0.8; // Assume 20% discount

        // Calculate the discount percentage
        double discountPercentage =
            ((originalPriceInCHF - discountedPriceInCHF) / originalPriceInCHF) *
                100;

        bool isSmallScreen = MediaQuery.of(context).size.width < 600;

        return GestureDetector(
          onTap: () {
            _navigateToTicketDetail(context, index);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0), // Set border radius
              child: Container(
                height: 100,
                color: Colors.red, // Red background to match Swiss flag color
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(isSmallScreen ? 5 : 10),
                        color: Colors
                            .red, // Red background to match the container color
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Ticket ${index + 1}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isSmallScreen ? 14 : 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: isSmallScreen ? 120 : 160,
                      padding: EdgeInsets.all(isSmallScreen ? 5 : 10),
                      color: Colors
                          .red, // Red background to match the container color
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${originalPriceInCHF.toStringAsFixed(2)} CHF',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isSmallScreen ? 14 : 18,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${discountedPriceInCHF.toStringAsFixed(2)} CHF',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isSmallScreen ? 12 : 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '- ${discountPercentage.toStringAsFixed(0)}%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isSmallScreen ? 12 : 16,
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
        );
      },
    );
  }

  void _navigateToTicketDetail(BuildContext context, int ticketIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketDetailPage(ticketIndex: ticketIndex),
      ),
    );
  }
}

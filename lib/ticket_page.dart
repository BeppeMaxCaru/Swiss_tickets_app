import 'package:flutter/material.dart';

class TicketDetailPage extends StatefulWidget {
  final int ticketIndex;

  TicketDetailPage({Key? key, required this.ticketIndex}) : super(key: key);

  @override
  _TicketDetailPageState createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Details'),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  color:
                      Colors.red, // Replace with your desired background color
                  width: double.infinity,
                  height: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Ticket ${widget.ticketIndex + 1} Description', // Replace with ticket description
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _decrementCounter,
                          child: Icon(Icons.remove),
                        ),
                        Text(
                          '$_counter',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        ElevatedButton(
                          onPressed: _incrementCounter,
                          child: Icon(Icons.add),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    SwipeableButton(
                      onChanged: _onSwipeChange,
                      width: 200.0,
                      height: 50.0,
                      borderRadius: 25.0,
                      child: Text(
                        'Swipe to Confirm',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _onSwipeChange(SwipeAction action) {
    if (action == SwipeAction.swipeRight) {
      // Replace this with your desired action when swiping right
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirmation'),
          content: Text('Ticket confirmed!'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

class SwipeableButton extends StatefulWidget {
  final ValueChanged<SwipeAction> onChanged;
  final double width;
  final double height;
  final double borderRadius;
  final Widget child;

  const SwipeableButton({
    Key? key,
    required this.onChanged,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.child,
  }) : super(key: key);

  @override
  _SwipeableButtonState createState() => _SwipeableButtonState();
}

enum SwipeAction { none, swipeRight }

class _SwipeableButtonState extends State<SwipeableButton> {
  double _dx = 0.0;
  bool _isSwipingRight = false;

  void _handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      _dx = details.localPosition.dx;
      _isSwipingRight = _dx >= widget.width - widget.height;
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    if (_isSwipingRight) {
      widget.onChanged(SwipeAction.swipeRight);
    }
    setState(() {
      _dx = 0.0;
      _isSwipingRight = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _handlePanUpdate,
      onPanEnd: _handlePanEnd,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: _isSwipingRight ? Colors.green : Colors.grey,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: Center(
          child: _isSwipingRight
              ? Icon(Icons.check, color: Colors.white)
              : widget.child,
        ),
      ),
    );
  }
}

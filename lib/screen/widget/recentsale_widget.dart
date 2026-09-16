import 'package:flutter/material.dart';
class RecentsaleWidget extends StatelessWidget {
  const RecentsaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child:Container(
        width:double.infinity,
        decoration:BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 1, 0, 0).withValues(alpha: 0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            "Recent Sales",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        
          const SizedBox(height: 15),
        
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              child: Icon(Icons.shopping_cart),
            ),
            title: const Text("Coca Cola"),
            subtitle: const Text("2 items • Today"),
            trailing: const Text(
              "\$3.00",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        
          const Divider(),
        
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              child: Icon(Icons.shopping_cart),
            ),
            title: const Text("Pepsi"),
            subtitle: const Text("1 item • Today"),
            trailing: const Text(
              "\$1.50",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        
          const Divider(),
        
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              child: Icon(Icons.shopping_cart),
            ),
            title: const Text("Water"),
            subtitle: const Text("3 items • Today"),
            trailing: const Text(
              "\$3.00",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
            ),
          ),
        ),
      ));
  }
}

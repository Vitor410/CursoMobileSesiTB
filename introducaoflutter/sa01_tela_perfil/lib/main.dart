import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Tela_Perfil"),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 54, 54, 54),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    Image.asset(
                      'assets/img/image.png',
                      width: 200,
                      height: 200,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Text("Johan Smith", style: TextStyle(fontSize: 30)),
                    Text("California, USA", style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 1, 90, 255),
                              ),
                            ),
                            Icon(Icons.person),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 1, 90, 255),
                              ),
                            ),
                            Icon(Icons.person),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 1, 90, 255),
                              ),
                            ),
                            Icon(Icons.person),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Column(
                  children: [
                    _buildRowWithIcon(Icons.person, "Personal Information"),
                    _buildRowWithIcon(Icons.shopping_cart, "Your Order"),
                    _buildRowWithIcon(Icons.favorite, "Your Favorites"),
                    _buildRowWithIcon(Icons.payment, "Payment"),
                    _buildRowWithIcon(Icons.shop, "Recommended Shops"),
                    _buildRowWithIcon(Icons.location_on, "Nearest Shop"),
                  ],
                ),
              ],
            ),
          ),
        ),
        drawer: Drawer(child: ListView()),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.notification_add), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ""),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.person),
        ),
      ),
    );
  }

  Widget _buildRowWithIcon(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, size: 30),
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

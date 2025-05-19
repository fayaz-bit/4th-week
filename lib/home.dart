import 'package:app/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detailscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> people = [
    {
      "name": "Mountains",
      "image":
          "https://tse3.mm.bing.net/th?id=OIP.W_itMW5hTkkEcy7YvUwQsgHaE8&pid=Api&P=0&h=180",
    },
    {
      "name": "Forest",
      "image":
          "https://tse1.mm.bing.net/th?id=OIP.Kdks3tAunVN146_NAiaejQHaEK&pid=Api&P=0&h=180",
    },
    {
      "name": "Lake",
      "image":
          "https://tse1.mm.bing.net/th?id=OIP.PBcAfpVIIRrnvjnazTUH1QHaD_&pid=Api&P=0&h=180",
    },
    {
      "name": "Waterfall",
      "image":
          "https://tse4.mm.bing.net/th?id=OIP.9_wTtBPGmV2LF1vYuXmA9AHaE7&pid=Api&P=0&h=180",
    },
    {
      "name": "Desert",
      "image":
          "https://tse1.mm.bing.net/th?id=OIP.4UHD0fMe3wrHo5gbcFLr4QHaD7&pid=Api&P=0&h=180",
    },
    {
      "name": "Beach",
      "image":
          "https://tse2.mm.bing.net/th?id=OIP.9dXEUxBTm42RMeQLeWloVAHaE8&pid=Api&P=0&h=180",
    },
  ];

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Log out"),
            content: Text("Are you sure you want to log out?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  final pref = await SharedPreferences.getInstance();
                  await pref.setBool('isLoggedIn', false);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()),
                    (route) => false,
                  );
                },
                child: Text("Yes"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Home Page'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _showLogoutDialog(context),
            icon: Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final person = people[index];
                  final isCircle = index % 2 == 0;
                  return ListTile(
                    leading:
                        isCircle
                            ? ClipOval(
                              child: Image.network(
                                person['image']!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            )
                            : ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                person['image']!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                    title: Text(
                      person['name']!,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => DetailScreen(
                                name: person['name']!,
                                image: person['image']!,
                              ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder:
                    (_, __) => Divider(height: 20, color: Colors.black),
                itemCount: people.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

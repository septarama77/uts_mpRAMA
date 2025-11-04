import 'package:flutter/material.dart';
import 'dashboard.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(_controller);
  }

  void _onTapDown(TapDownDetails details) => _controller.forward();
  void _onTapUp(TapUpDetails details) => _controller.reverse();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gunakan Container penuh tinggi layar
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF311B92), Color(0xFF4A148C), Color(0xFF00BCD4)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // AppBar Custom
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushReplacement(_createRoute(const DashboardPage()));
                      },
                    ),
                    const Text(
                      "YOUR PROFILE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
                const SizedBox(height: 20),

                // Avatar
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/avatar.jpg'),
                ),
                const SizedBox(height: 15),

                // Nama & info
                const Text(
                  "rammm",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "NIM: 23670098",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const Text(
                  "Email: rama@gmail.com",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),

                const SizedBox(height: 25),

                // Prodi & Semester
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.school, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      "Prodi: Informatika",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(width: 20),
                    Icon(Icons.date_range, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      "Semester: 5",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Tombol Kembali ke Dashboard
                GestureDetector(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  onTapCancel: () => _controller.reverse(),
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushReplacement(_createRoute(const DashboardPage()));
                  },
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.cyanAccent,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Kembali ke Dashboard",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Animasi transisi halaman
Route _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(position: animation.drive(tween), child: child),
      );
    },
  );
}

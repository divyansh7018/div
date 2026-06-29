import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constants/app_constants.dart';
import 'main_shell_screen.dart';
class SplashScreen extends StatefulWidget { const SplashScreen({super.key}); @override State<SplashScreen> createState() => _SplashScreenState(); }
class _SplashScreenState extends State<SplashScreen> { @override void initState() { super.initState(); Future.delayed(const Duration(seconds: 3), () { if (mounted) Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const MainShellScreen())); }); } @override Widget build(BuildContext context) => Scaffold(body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Lottie.asset('assets/animations/fitness_loading.json', width: 180), const Text(AppConstants.appName, style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: AppConstants.gold)), const SizedBox(height: 8), const Text(AppConstants.tagline, style: TextStyle(color: Colors.white70))]))); }

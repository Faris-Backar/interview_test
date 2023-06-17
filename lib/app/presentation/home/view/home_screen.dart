import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:interview_test/app/presentation/dog_screen/view/dog_screen.dart';
import 'package:interview_test/app/presentation/profile_screen/view/profile_screen.dart';
import 'package:interview_test/app/widgets/primary_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isBluetoothEnabled = false;
  final platform = const MethodChannel('bluetooth_channel');

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    isBluetoothEnabled = await getBluetoothStatus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PrimaryButton(
                ontap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DogScreen(),
                  ),
                ),
                label: 'Random Dog Images',
              ),
              const SizedBox(
                height: 20,
              ),
              SwitchListTile(
                value: isBluetoothEnabled,
                onChanged: (value) {
                  if (isBluetoothEnabled) {
                    disableBluetooth();
                  } else {
                    enableBluetooth();
                  }
                  setState(() {});
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                tileColor: Colors.grey[300],
                title: const Text(
                  'Bluetooth',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                ontap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<bool> enableBluetooth() async {
    try {
      final bool isEnabled = await platform.invokeMethod('enableBluetooth');
      isBluetoothEnabled = isEnabled;

      return isEnabled;
    } catch (e) {
      isBluetoothEnabled = false;
      return false;
    }
  }

  Future<bool> disableBluetooth() async {
    try {
      final bool isEnabled = await platform.invokeMethod('disableBluetooth');
      isBluetoothEnabled = false;
      return isEnabled;
    } catch (e) {
      isBluetoothEnabled = true;
      return false;
    }
  }

  Future<bool> getBluetoothStatus() async {
    try {
      final bool isEnabled = await platform.invokeMethod('getBluetoothStatus');
      return isEnabled;
    } catch (e) {
      return false;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:interview_test/app/presentation/profile_screen/controller/profile_controller.dart';
import 'package:interview_test/app/widgets/text_field_widget.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _numberOfDaysController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
            future: ProfileController().getProfileDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final profileData = snapshot.data!.results!.first;
                _nameController.text =
                    "${profileData.name?.title ?? ""} ${profileData.name?.first ?? ""} ${profileData.name?.last ?? ""}";
                _emailController.text = profileData.email ?? "";
                _locationController.text =
                    "${profileData.location?.street?.name}, ${profileData.location?.city}, ${profileData.location?.country} ";
                _dobController.text = DateFormat("dd-MMM-yyyy")
                    .format(profileData.dob?.date ?? DateTime.now());
                _numberOfDaysController.text =
                    "${getNumberOfdaysSinceregistered(profileData.registered?.date ?? DateTime.now())} days";
                if (snapshot.data!.results!.isEmpty) {
                  return const Center(
                    child: Text('No Data Available.'),
                  );
                }
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(
                        snapshot.data?.results?.first.picture?.large ?? "",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        controller: _nameController, lable: 'Full Name'),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        controller: _emailController, lable: "Email"),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        controller: _locationController, lable: "Location"),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(controller: _dobController, lable: "DOB"),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        controller: _numberOfDaysController,
                        lable: "Number Of Days Since Joined"),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }

  int getNumberOfdaysSinceregistered(DateTime date) {
    DateTime now = DateTime.now();
    int days = now.difference(date).inDays;
    return days;
  }
}

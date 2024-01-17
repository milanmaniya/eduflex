import 'package:eduflex/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

class TeacherInformationScreen extends StatefulWidget {
  const TeacherInformationScreen({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  State<TeacherInformationScreen> createState() =>
      _TeacherInformationScreenState();
}

class _TeacherInformationScreenState extends State<TeacherInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Information',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSize.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(
                      image: NetworkImage(
                        widget.data['image'],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: TSize.spaceBtwItems / 2,
              ),
              const Divider(),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              Text(
                'Profile Information',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              LabelWithValue(
                labelName: 'Name',
                value: "${widget.data['firstName']} ${widget.data['lastName']}",
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              LabelWithValue(
                labelName: 'Username',
                value: "${widget.data['userName']}",
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              Text(
                'Profile Information',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              LabelWithValue(
                labelName: 'User ID',
                value: "${widget.data['id']}",
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              LabelWithValue(
                labelName: 'E-mail',
                value: "${widget.data['email']}",
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              LabelWithValue(
                labelName: 'Phone Number',
                value: "${widget.data['phoneNumber']}",
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              LabelWithValue(
                labelName: 'Gender',
                value: "${widget.data['phoneNumber']}",
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              LabelWithValue(
                labelName: 'Date Of Birth',
                value: "${widget.data['phoneNumber']}",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LabelWithValue extends StatelessWidget {
  const LabelWithValue({
    super.key,
    required this.labelName,
    required this.value,
  });

  final String labelName;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            labelName,
            style: Theme.of(context).textTheme.titleLarge,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            // style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

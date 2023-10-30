import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import '../screens/sign_in/sign_in_screen.dart';
import '../utils/image_picker.dart';

class UserMenu extends StatelessWidget {
  const UserMenu({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SimpleDialog(
      alignment: Alignment.topCenter,
      insetPadding: const EdgeInsets.symmetric(
        vertical: 60,
        horizontal: 20,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
      ),
      elevation: 0,
      titlePadding: const EdgeInsets.all(0),
      title: dialogTitle(context),
      children: <Widget>[
        Container(
          width: width,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Theme.of(context).scaffoldBackgroundColor.withAlpha(180),
          ),
          child: Column(
            children: [
              userMenuTop(context),
              const Divider(),
              userMenuBottom(context),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Gizlilik Politikası',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            const Icon(Icons.circle, size: 4),
            TextButton(
              onPressed: () {},
              child: Text(
                'Hizmet Şartları',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget userMenuBottom(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width,
            child: TextButton.icon(
              style: const ButtonStyle(
                alignment: Alignment.centerLeft,
              ),
              label: Text(
                'Başka bir hesap ekle',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: () async {
                await context.read<AuthProvider>().signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const SignInScreen()));
              },
              icon: const Icon(
                Icons.person_add_alt,
                size: 26,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: width,
            child: TextButton.icon(
              style: const ButtonStyle(
                alignment: Alignment.centerLeft,
              ),
              label: Text(
                'Bu cihazdaki hesapları yönet',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: () {},
              icon: const Icon(
                Icons.manage_accounts_outlined,
                size: 26,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget userMenuTop(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              userMenuAvatar(context),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.watch<UserProvider>().user?.username ?? '',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      context.watch<UserProvider>().user!.email!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          OutlinedButton(
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () {},
              child: const Text('Google Hesabınızı Yönetin'))
        ],
      ),
    );
  }

  GestureDetector userMenuAvatar(BuildContext context) {
    Future<void> changeProfilePhoto(BuildContext context) async {
      final file = await ImagePicker().pickFromGallery();
      if (file == null) return;
      context.read<UserProvider>().changeProfilePhoto(file);
    }

    return GestureDetector(
      onTap: () => changeProfilePhoto(context),
      child: CircleAvatar(
        radius: 20,
        backgroundImage: context.watch<UserProvider>().user?.photo != null
            ? Image.network(context.watch<UserProvider>().user!.photo!).image
            : null,
        child: Container(
          width: 20,
          height: 20,
          margin: const EdgeInsets.only(left: 20, top: 20),
          decoration: const BoxDecoration(
            color: Color(0xff2D2E30),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.photo_camera_outlined,
            size: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget dialogTitle(BuildContext context) {
    return AppBar(
      toolbarHeight: 40,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          'Google',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      leading: IconButton(
        onPressed: Navigator.of(context).pop,
        icon: const Icon(Icons.close),
      ),
    );
  }
}

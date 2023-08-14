import 'package:flutter/material.dart';
import 'package:google_keep_clone/constants/color.dart';

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
      backgroundColor: CustomColors.userMenuContainerBg,
      titlePadding: const EdgeInsets.all(0),
      title: dialogTitle(context),
      children: <Widget>[
        Container(
          width: width,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: CustomColors.userMenuContentBg,
          ),
          child: Column(
            children: [
              userMenuTop(),
              const Divider(
                color: Colors.white38,
                thickness: 1,
              ),
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
              child: const Text(
                'Gizlilik Politikası',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
            const Icon(Icons.circle, size: 4),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Gizlilik Politikası',
                style: TextStyle(
                  fontSize: 10,
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width,
          child: TextButton.icon(
            style: const ButtonStyle(
              alignment: Alignment.centerLeft,
              foregroundColor: MaterialStatePropertyAll(
                CustomColors.secondaryTextColor,
              ),
            ),
            label: const Text(
              'Başka bir hesap ekle',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            onPressed: () {},
            icon: const Icon(
              Icons.person_add_alt,
              size: 20,
              color: CustomColors.secondaryTextColor,
            ),
          ),
        ),
        SizedBox(
          width: width,
          child: TextButton.icon(
            style: const ButtonStyle(
              alignment: Alignment.centerLeft,
              foregroundColor: MaterialStatePropertyAll(
                CustomColors.secondaryTextColor,
              ),
            ),
            label: const Text(
              'Bu cihazdaki hesapları yönet',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            onPressed: () {},
            icon: const Icon(
              Icons.manage_accounts_outlined,
              size: 20,
              color: CustomColors.secondaryTextColor,
            ),
          ),
        )
      ],
    );
  }

  Widget userMenuTop() {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              userMenuAvatar(),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Uğur Danış',
                        style: TextStyle(
                          fontSize: 12,
                        )),
                    Text(
                      'ugur946658@gmail.com',
                      style: TextStyle(
                        fontSize: 10,
                        color: CustomColors.actionsColor,
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

  GestureDetector userMenuAvatar() {
    return GestureDetector(
      onTap: () {},
      child: CircleAvatar(
        radius: 20,
        backgroundImage: const AssetImage('assets/images/profile-img.png'),
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
      backgroundColor: CustomColors.userMenuContainerBg,
      title: const Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          'Google',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      leading: IconButton(
        onPressed: Navigator.of(context).pop,
        icon: const Icon(Icons.close),
      ),
    );
  }
}

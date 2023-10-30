part of '../home_screen.dart';

class _UserAvatar extends StatelessWidget {
  const _UserAvatar();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return InkWell(
      onTap: () =>
          showDialog(context: context, builder: (context) => const UserMenu()),
      child: CircleAvatar(
        radius: 16,
        backgroundImage: userProvider.user?.photo != null
            ? Image.network(userProvider.user!.photo!).image
            : null,
      ),
    );
  }
}

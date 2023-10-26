part of '../home_screen.dart';

class _UserAvatar extends StatelessWidget {
  const _UserAvatar();

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return InkWell(
      onTap: () =>
          showDialog(context: context, builder: (context) => const UserMenu()),
      child: CircleAvatar(
        radius: 16,
        backgroundImage: authProvider.user?.photoURL != null
            ? Image.network(authProvider.user!.photoURL!).image
            : null,
      ),
    );
  }
}

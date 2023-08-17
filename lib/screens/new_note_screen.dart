import 'package:flutter/material.dart';

class NewNote extends StatelessWidget {
  const NewNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.push_pin_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notification_add_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.archive_outlined),
            ),
          ],
        ),
        bottomNavigationBar: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_box_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.color_lens_outlined),
            ),
            const Expanded(
              child: Text(
                'Düzenlenme saati: 15:06',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10),
              ),
            ),
            const SizedBox(width: 48),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 20),
                  expands: true,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Başlık',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: TextField(
                  expands: true,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Not',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

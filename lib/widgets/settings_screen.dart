import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Ayarlar', style: Theme.of(context).textTheme.titleMedium),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Görüntüleme seçenekleri',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Text('Yeni öğeleri alta ekle'),
                  ),
                  Switch(
                    value: true,
                    onChanged: (value) => {},
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Text('İşaretli öğeleri alta taşı'),
                  ),
                  Switch(
                    value: true,
                    onChanged: (value) => {},
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Text('Yeni öğeleri alta ekle'),
                  ),
                  Switch(
                    value: true,
                    onChanged: (value) => {},
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Text('Tema')),
                    Text('Sistem varsayılanı'),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              Text(
                'Hatırlatıcı varsayılanları',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Text('Sabah')),
                    Text('08:00'),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Text('Öğleden sonra')),
                    Text('13:00'),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Text('Akşam')),
                    Text('18:00'),
                  ],
                ),
              ),
              Text(
                'Paylaşım',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(child: Text('Paylaşımı etkinleştir')),
                  Switch(
                    value: true,
                    onChanged: (value) => {},
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

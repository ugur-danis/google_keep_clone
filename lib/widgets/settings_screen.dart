import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Ayarlar', style: TextStyle(fontSize: 18)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Görüntüleme seçenekleri',
                  style: TextStyle(fontSize: 20)),
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
              const Text('Hatırlatıcı varsayılanları',
                  style: TextStyle(fontSize: 20)),
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
              const Text('Paylaşım', style: TextStyle(fontSize: 20)),
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

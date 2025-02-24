import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const ImageTransformer(),
      ),
    );
  }
}

class ImageTransformer extends StatefulWidget {
  const ImageTransformer({super.key});

  @override
  State<ImageTransformer> createState() => _ImageTransformerState();
}

class _ImageTransformerState extends State<ImageTransformer> {
  double _rotation = 0.0;
  double _scale = 1.0;
  bool _isMirrored = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(color: Colors.white),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateZ(_rotation)
                    ..scale(_isMirrored ? -_scale : _scale, _scale),
                  child: Image.asset(
                    '../assets/images/breaking_bad.jpg',
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text('Rotation: ${(_rotation * (180 / 3.1416)).toStringAsFixed(0)}°'),
          Slider(
            value: _rotation,
            min: 0,
            max: 6.2832, 
            onChanged: (value) {
              setState(() {
                _rotation = value;
              });
            },
          ),
          Text('Échelle: ${_scale.toStringAsFixed(2)}x'),
          Slider(
            value: _scale,
            min: 0.5,
            max: 3.0,
            onChanged: (value) {
              setState(() {
                _scale = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Effet miroir'),
            value: _isMirrored,
            onChanged: (value) {
              setState(() {
                _isMirrored = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

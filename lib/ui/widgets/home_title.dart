part of 'widgets.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key, required text, required size})
      : _text = text,
        _size = size;

  final String _text;
  final double _size;

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: TextStyle(
        color: const Color(0xFFFFDF00),
        fontFamily: "Raleway",
        fontSize: _size,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    );
  }
}

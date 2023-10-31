part of 'widgets.dart';

class RowButtons extends StatelessWidget {
  const RowButtons({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height / 6,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 7.5),
              width: width / 2 - 40,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFFFDF00),
                    side: const BorderSide(
                        width: 1, color: Color(0xFFFFDF00)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Back',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w700,
                    ),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(left: 7.5),
              width: width / 2 - 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFDF00),
                  foregroundColor: Colors.black,
                ),
                onPressed: () {},
                child: const Text(
                  'Continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
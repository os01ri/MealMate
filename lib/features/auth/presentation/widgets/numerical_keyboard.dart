import 'package:flutter/material.dart';
import '../../../../core/ui/theme/colors.dart';

class NumericalKeyboard extends StatelessWidget {
  const NumericalKeyboard({
    Key? key,
    required this.textEditingController,
    required this.size,
    required this.maxLength,
    this.onTap,
    this.value,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final Size size;
  final int maxLength;
  final VoidCallback? onTap;
  final ValueNotifier<String>? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NumberButton(
              onTap: () {
                onTapButton('1');
              },
              size: size,
              title: '1',
            ),
            _NumberButton(
              onTap: () {
                onTapButton('2');
              },
              size: size,
              title: '2',
            ),
            _NumberButton(
              onTap: () {
                onTapButton('3');
              },
              size: size,
              title: '3',
            ),
          ],
        ),
        SizedBox(height: size.width * .025),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NumberButton(
              onTap: () {
                onTapButton('4');
              },
              size: size,
              title: '4',
            ),
            _NumberButton(
              onTap: () {
                onTapButton('5');
              },
              size: size,
              title: '5',
            ),
            _NumberButton(
              onTap: () {
                onTapButton('6');
              },
              size: size,
              title: '6',
            ),
          ],
        ),
        SizedBox(height: size.width * .025),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NumberButton(
              onTap: () {
                onTapButton('7');
              },
              size: size,
              title: '7',
            ),
            _NumberButton(
              size: size,
              title: '8',
              onTap: () {
                onTapButton('8');
              },
            ),
            _NumberButton(
              size: size,
              title: '9',
              onTap: () {
                onTapButton('9');
              },
            )
          ],
        ),
        SizedBox(height: size.width * .025),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NumberButton(
              onTap: () {
                if (textEditingController.text.isNotEmpty) {
                  textEditingController.text = textEditingController.text.substring(
                    0,
                    textEditingController.text.length - 1,
                  );
                  value?.value = textEditingController.text;
                }
              },
              size: size,
              isDelete: true,
            ),
            _NumberButton(
              size: size,
              title: '0',
              onTap: () {
                onTapButton('0');
              },
            ),
            (onTap == null)
                ? SizedBox(
                    width: size.width * .25,
                    height: size.width * .125,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ElevatedButton(
                      onPressed: onTap,
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                          Size(size.width * .25, size.width * .125),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.mainColor,
                        ),
                        overlayColor: MaterialStateProperty.all<Color>(
                          Colors.grey.withOpacity(0.4),
                        ),
                        shadowColor: MaterialStateProperty.all<Color>(
                          Colors.transparent,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'OK',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        )
      ],
    );
  }

  onTapButton(String text) {
    if (textEditingController.text.length < maxLength) {
      textEditingController.text += text;
      value?.value = textEditingController.text;
    }
  }
}

class _NumberButton extends StatelessWidget {
  const _NumberButton({
    Key? key,
    this.isDelete = false,
    this.title = '',
    required this.size,
    required this.onTap,
  }) : super(key: key);

  final bool isDelete;
  final Size size;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all<Size>(
            Size(size.width * .25, size.width * .125),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.white,
          ),
          overlayColor: MaterialStateProperty.all<Color>(
            Colors.grey.withOpacity(0.4),
          ),
          shadowColor: MaterialStateProperty.all<Color>(
            Colors.transparent,
          ),
        ),
        child: Center(
          child: isDelete
              ? const Icon(
                  Icons.delete,
                  color: Colors.black,
                )
              : Text(
                  title,
                  style: TextStyle(
                    fontSize: size.width * .06,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../login.dart';

class UserInput extends StatefulWidget {
  final LoginPresenter presenter;
  final ScrollController scrollController;
  final FocusNode passwordInputfocusNode;

  const UserInput({
    Key? key,
    required this.presenter,
    required this.scrollController,
    required this.passwordInputfocusNode,
  }) : super(key: key);

  @override
  _UserInputState createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  late TextEditingController _textEditingController;
  late bool _suffixIsVisible;
  late FocusNode _focusNode;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _suffixIsVisible = false;
    _focusNode = FocusNode()
      ..addListener(() async {
        if (_focusNode.hasPrimaryFocus) {
          await Future.delayed(const Duration(milliseconds: 100));
          widget.scrollController.animateTo(100, duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
        }
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: _textEditingController,
            focusNode: _focusNode,
            autocorrect: false,
            cursorRadius: const Radius.circular(2.0),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: 'gabrielscota@email.com',
              suffixIcon: Visibility(
                visible: _suffixIsVisible,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 12.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      _textEditingController.clear();
                      widget.presenter.validateEmail(_textEditingController.text);
                      setState(() {
                        _suffixIsVisible = false;
                      });
                    },
                    child: SvgPicture.asset(
                      'lib/ui/assets/icons/close_square.svg',
                      color: Theme.of(context).colorScheme.onBackground.withAlpha(200),
                      width: 28.0,
                      height: 28.0,
                    ),
                  ),
                ),
              ),
            ),
            onChanged: (value) {
              widget.presenter.validateEmail(value);
              setState(() {
                value != '' ? _suffixIsVisible = true : _suffixIsVisible = false;
              });
            },
            onFieldSubmitted: (_) {
              if (widget.passwordInputfocusNode.canRequestFocus) {
                widget.passwordInputfocusNode.requestFocus();
              }
            },
          ),
        ],
      ),
    );
  }
}

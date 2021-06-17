import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../login.dart';

class PasswordInput extends StatefulWidget {
  final LoginPresenter presenter;
  final ScrollController scrollController;
  final FocusNode focusNode;

  const PasswordInput({
    Key? key,
    required this.presenter,
    required this.scrollController,
    required this.focusNode,
  }) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  late TextEditingController _textEditingController;
  late bool _showPassword;
  late bool _suffixIsVisible;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _showPassword = false;
    _suffixIsVisible = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Senha',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: _textEditingController,
            focusNode: widget.focusNode,
            obscureText: !_showPassword,
            autocorrect: false,
            cursorRadius: const Radius.circular(2.0),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: '******',
              suffixIcon: Visibility(
                visible: _suffixIsVisible,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 12.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    child: SvgPicture.asset(
                      _showPassword ? 'lib/ui/assets/icons/show.svg' : 'lib/ui/assets/icons/hide.svg',
                      color: Theme.of(context).colorScheme.onBackground.withAlpha(200),
                      width: 28.0,
                      height: 28.0,
                    ),
                  ),
                ),
              ),
            ),
            onChanged: (value) {
              widget.presenter.validatePassword(value);
              setState(() {
                value != '' ? _suffixIsVisible = true : _suffixIsVisible = false;
              });
            },
          ),
        ],
      ),
    );
  }
}

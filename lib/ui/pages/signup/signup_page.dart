import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../helpers/helpers.dart';
import '../../mixins/mixins.dart';
import '../pages.dart';

class SignUpPage extends StatefulWidget {
  final SignUpPresenter presenter;

  const SignUpPage({Key? key, required this.presenter}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with NavigationManager {
  int currentPage = 0;
  final PageController _pageController = PageController();

  late final TextEditingController nameTextEditingController;
  late final TextEditingController emailTextEditingController;
  late final TextEditingController cpfTextEditingController;
  late final TextEditingController passwordTextEditingController;
  late final FocusNode nameFocusNode;
  late final FocusNode emailFocusNode;
  late final FocusNode cpfFocusNode;
  late final FocusNode passwordFocusNode;

  @override
  void initState() {
    handleNavigationWithArgs(widget.presenter.navigateToWithArgsAndClearStackStream, clearStack: true);

    nameTextEditingController = TextEditingController();
    emailTextEditingController = TextEditingController();
    cpfTextEditingController = TextEditingController();
    passwordTextEditingController = TextEditingController();

    nameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    cpfFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    super.initState();
  }

  void changePage(int value) {
    _pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
    setState(() {
      currentPage = value;
    });
    switch (value) {
      case 0:
        nameFocusNode.requestFocus();
        break;
      case 1:
        emailFocusNode.requestFocus();
        break;
      case 2:
        cpfFocusNode.requestFocus();
        break;
      case 3:
        passwordFocusNode.requestFocus();
        break;
    }
  }

  void signUp() {
    if (widget.presenter.isFormValid == true) {
      widget.presenter.signup();
    }
  }

  void onNameEditingComplete() => changePage(1);

  void onEmailEditingComplete() => changePage(2);

  void onCpfEditingComplete() => changePage(3);

  void onPasswordEditingComplete() => signUp();

  TextInputFormatter cpfTextInputFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            onPressed: () {
              if (currentPage > 0) {
                changePage(currentPage - 1);
              } else {
                Get.back();
              }
            },
            icon: Icon(
              IconlyLight.arrow_left_2,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (currentPage > 0) {
            changePage(currentPage - 1);
            return false;
          } else {
            return true;
          }
        },
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => GestureDetector(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  padding: const EdgeInsets.only(top: 24.0),
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FadeIn(
                        delay: const Duration(milliseconds: 400),
                        duration: const Duration(milliseconds: 600),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${currentPage + 1} de 4', style: Theme.of(context).textTheme.subtitle1),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 10.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6.0),
                                            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                          ),
                                        ),
                                        LayoutBuilder(
                                          builder: (context, stepsConstraints) {
                                            return AnimatedContainer(
                                              duration: const Duration(milliseconds: 400),
                                              curve: Curves.easeInOut,
                                              width: (stepsConstraints.maxWidth / 4) * (currentPage + 1),
                                              height: 10.0,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6.0),
                                                color: Theme.of(context).colorScheme.primary,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 6,
                                    child: SizedBox(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      Expanded(
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PageViewInput(
                                  label: "What's your name?",
                                  hint: 'Hint for name...',
                                  controller: nameTextEditingController,
                                  textInputType: TextInputType.name,
                                  validateField: widget.presenter.validateName,
                                  textInputAction: TextInputAction.next,
                                  focusNode: nameFocusNode,
                                  onEditingComplete: onNameEditingComplete,
                                  errorStream: widget.presenter.nameErrorStream,
                                  autoFocus: true,
                                ),
                                FadeInUp(
                                  delay: const Duration(milliseconds: 1200),
                                  duration: const Duration(milliseconds: 600),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        StreamBuilder<UIError>(
                                          stream: widget.presenter.nameErrorStream,
                                          builder: (context, snapshot) {
                                            return ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding: const EdgeInsets.symmetric(horizontal: 56.0, vertical: 16.0),
                                              ),
                                              onPressed: snapshot.hasData && snapshot.data == UIError.noError
                                                  ? () => changePage(1)
                                                  : null,
                                              child: const Icon(IconlyLight.arrow_right),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PageViewInput(
                                  label: "What's your email?",
                                  hint: 'Hint for email...',
                                  controller: emailTextEditingController,
                                  textInputType: TextInputType.emailAddress,
                                  validateField: widget.presenter.validateEmail,
                                  textInputAction: TextInputAction.next,
                                  focusNode: emailFocusNode,
                                  onEditingComplete: onEmailEditingComplete,
                                  errorStream: widget.presenter.emailErrorStream,
                                ),
                                FadeInUp(
                                  delay: const Duration(milliseconds: 1200),
                                  duration: const Duration(milliseconds: 600),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        StreamBuilder<UIError>(
                                          stream: widget.presenter.emailErrorStream,
                                          builder: (context, snapshot) {
                                            return ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding: const EdgeInsets.symmetric(horizontal: 56.0, vertical: 16.0),
                                              ),
                                              onPressed: snapshot.hasData && snapshot.data == UIError.noError
                                                  ? () => changePage(2)
                                                  : null,
                                              child: const Icon(IconlyLight.arrow_right),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PageViewInput(
                                  label: 'And your CPF?',
                                  hint: 'Hint for CPF...',
                                  controller: cpfTextEditingController,
                                  textInputType: TextInputType.datetime,
                                  validateField: widget.presenter.validateCpf,
                                  textInputAction: TextInputAction.next,
                                  focusNode: cpfFocusNode,
                                  onEditingComplete: onCpfEditingComplete,
                                  textInputFormatter: cpfTextInputFormatter,
                                  errorStream: widget.presenter.cpfErrorStream,
                                ),
                                FadeInUp(
                                  delay: const Duration(milliseconds: 1200),
                                  duration: const Duration(milliseconds: 600),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        StreamBuilder<UIError>(
                                          stream: widget.presenter.cpfErrorStream,
                                          builder: (context, snapshot) {
                                            return ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding: const EdgeInsets.symmetric(horizontal: 56.0, vertical: 16.0),
                                              ),
                                              onPressed: snapshot.hasData && snapshot.data == UIError.noError
                                                  ? () => changePage(3)
                                                  : null,
                                              child: const Icon(IconlyLight.arrow_right),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PageViewInput(
                                  label: 'Lastly a password',
                                  hint: 'Hint for password...',
                                  controller: passwordTextEditingController,
                                  textInputType: TextInputType.visiblePassword,
                                  validateField: widget.presenter.validatePassword,
                                  textInputAction: TextInputAction.done,
                                  focusNode: passwordFocusNode,
                                  onEditingComplete: onPasswordEditingComplete,
                                  errorStream: widget.presenter.passwordErrorStream,
                                ),
                                FadeInUp(
                                  delay: const Duration(milliseconds: 1200),
                                  duration: const Duration(milliseconds: 600),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        StreamBuilder<bool?>(
                                          stream: widget.presenter.isFormValidStream,
                                          builder: (context, snapshot) {
                                            return ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding: const EdgeInsets.symmetric(horizontal: 56.0, vertical: 16.0),
                                              ),
                                              onPressed: currentPage < 3
                                                  ? () => changePage(currentPage + 1)
                                                  : currentPage == 3 && snapshot.hasData && snapshot.data == true
                                                      ? () => signUp()
                                                      : null,
                                              child: const Icon(IconlyLight.arrow_right),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PageViewInput extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType textInputType;
  final Function(String value) validateField;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final Function() onEditingComplete;
  final TextInputFormatter? textInputFormatter;
  final Stream<UIError> errorStream;
  final bool autoFocus;

  const PageViewInput({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.textInputType,
    required this.validateField,
    required this.textInputAction,
    required this.focusNode,
    required this.onEditingComplete,
    this.textInputFormatter,
    required this.errorStream,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  State<PageViewInput> createState() => _PageViewInputState();
}

class _PageViewInputState extends State<PageViewInput> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInUp(
            delay: const Duration(milliseconds: 600),
            duration: const Duration(milliseconds: 600),
            child: Text(
              widget.label,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          const SizedBox(height: 8.0),
          FadeInUp(
            delay: const Duration(milliseconds: 800),
            duration: const Duration(milliseconds: 600),
            child: Text(
              widget.hint,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Theme.of(context).colorScheme.primaryVariant.withOpacity(0.6),
                  ),
            ),
          ),
          const SizedBox(height: 12.0),
          FadeInUp(
            delay: const Duration(milliseconds: 1000),
            duration: const Duration(milliseconds: 600),
            child: StreamBuilder<UIError>(
                stream: widget.errorStream,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: widget.controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      errorText:
                          snapshot.hasData && snapshot.data != UIError.noError ? snapshot.data!.description : null,
                    ),
                    autofocus: widget.autoFocus,
                    cursorColor: Theme.of(context).colorScheme.primary,
                    cursorHeight: 32.0,
                    cursorRadius: const Radius.circular(6.0),
                    keyboardType: widget.textInputType,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).colorScheme.primaryVariant,
                          fontWeight: FontWeight.w300,
                        ),
                    onChanged: widget.validateField,
                    textInputAction: widget.textInputAction,
                    focusNode: widget.focusNode,
                    onEditingComplete: widget.onEditingComplete,
                    inputFormatters: widget.textInputFormatter != null ? [widget.textInputFormatter!] : [],
                  );
                }),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

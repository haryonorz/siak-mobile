import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/cubit/sign_in/sign_in_cubit.dart';
import 'package:siak_mobile/presentation/widget/form/password_form_field.dart';

class SignInForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            validator: MultiValidator(
              [
                RequiredValidator(errorText: 'Username required'),
              ],
            ),
            keyboardType: TextInputType.text,
            controller: usernameController,
            decoration: const InputDecoration(
              hintText: "Username",
            ),
          ),
          const SizedBox(height: AppDefaults.xlSpace),
          PasswordFormField(controller: passwordController),
          const SizedBox(height: AppDefaults.lSpace),
          const StayLoggedInCheckBox(),
          const SizedBox(height: AppDefaults.xlSpace),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  context.read<SignInCubit>().doSignIn(
                        usernameController.text,
                        passwordController.text,
                      );
                }
              },
              child: const Text("Sign In"),
            ),
          ),
        ],
      ),
    );
  }
}

class StayLoggedInCheckBox extends StatefulWidget {
  const StayLoggedInCheckBox({Key? key}) : super(key: key);

  @override
  State<StayLoggedInCheckBox> createState() => _StayLoggedInCheckBoxState();
}

class _StayLoggedInCheckBoxState extends State<StayLoggedInCheckBox> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        unselectedWidgetColor: AppColors.iconWhite,
      ),
      child: CheckboxListTile(
        value: checked,
        activeColor: AppColors.primary,
        onChanged: (value) {
          setState(() {
            checked = !checked;
          });
        },
        title: Text(
          "Stay logged in",
          style: Theme.of(context).textTheme.bodyText2,
        ),
        dense: true,
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_free_server/core/components/widgets/smart_dialog.dart';
import '../../core/components/constants/strings.dart';
import '../../core/components/widgets/custom_button.dart';
import '../../core/components/widgets/custom_input.dart';
import '../../generated/assets.dart';
import '../../services/database_services.dart';
import '../../state/auth_state.dart';
import '../../styles/colors.dart';
import '../../styles/styles.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isInvisible = true;
  final emailController = TextEditingController(text: 'admin@ifs.com');
  final passwordController=TextEditingController(text: 'admin2023');

  @override
  void initState() {
   //check if user is logged in go to home page
    super.initState();
  }

  createAdmin()async{
    try{
      final response=await ServicesApi.createAdmin();
    } catch (catchError){
      CustomDialog.showError(title: 'Error', message: 'Server is not responding');
    }
  }

  @override
  Widget build(
    BuildContext context,) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, size) {
        return
               FutureBuilder<void>(
                 future: createAdmin(),
                 builder: (context, snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator());
                    }else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: normalText(color: Colors.red),
                        ),
                      );
                    }else {
                      return Center(
                    child: Card(
                             elevation: 10,
                             color: Colors.white,
                             child: Container(
                      color: Colors.white,
                      width: size.maxWidth > 800 && size.maxWidth <= 1100
                          ? size.maxWidth * 0.7
                          : size.maxWidth > 1000
                              ? size.maxWidth * .5
                              : size.maxWidth * .8,
                      child: size.maxWidth > 800
                          ? SizedBox(
                            height: size.maxWidth > 800 && size.maxWidth <= 1100? size.maxHeight * .7:size.maxHeight * .6,
                            child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    color: primaryColor,
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          Assets.logos2,
                                          height: size.maxWidth * .13,
                                        ),
                                        const Text('Internet Free Server', style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                  )),
                                  Expanded(child: _buildForm(context, ref, size.maxWidth))
                                ],
                              ),
                          )
                          : _buildForm(context, ref, size.maxWidth)),
                           ));
                    }
                 }
               );
            }
          
        
      ));
    
  }

  Widget _buildForm(BuildContext context, WidgetRef ref, double width) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (width <= 800)
                Image.asset(
                  Assets.logos2,
                  height: width * .2,
                ),
              Text(
                'ADMIN LOGIN',
                style:
                    TextStyle(fontSize: width < 800 ? width * .05 : 40),
              ),
              const Divider(
                color: primaryColor,
                thickness: 4,
                indent: 20,
                endIndent: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFields(
                label: 'Admin Email',
                prefixIcon: Icons.email,
                controller: emailController,
                validator: (email) {
                  if (email!.isEmpty || RegExp(emailReg).hasMatch(email) == false) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (email) {
                  ref.read(authStateProvider.notifier).setEmail(email);
                },
              ),
              const SizedBox(
                height: 24,
              ),
              CustomTextFields(
                  label: 'Admin Password',
                  prefixIcon: Icons.password,
                  obscureText: isInvisible,
                  controller: passwordController,
                  validator: (password){
                    if(password!.isEmpty || password.length < 6){
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  onSaved: (password){
                    ref.read(authStateProvider.notifier).setPassword(password);            
                  },
                  suffixIcon: IconButton(
                    icon: Icon(isInvisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                    onPressed: () {
                      setState(() {
                        isInvisible = !isInvisible;
                      });
                    },
                  )),
              const SizedBox(
                height: 24,
              ),
              CustomButton(text: 'Login', onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ref.read(authStateProvider.notifier).login(context);
                }
              }),
              const SizedBox(
                height: 10,
              ),
              //forgot password
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: normalText(
                        color: primaryColor,
                        fontSize: width < 800 ? width * .03 : 18),
                  )),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

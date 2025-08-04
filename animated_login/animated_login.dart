// lib/animated_login/teddy_login_screen.dart

import 'package:bloc_stm/animated_login/bloc.dart';
import 'package:bloc_stm/animated_login/event.dart';
import 'package:bloc_stm/animated_login/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeddyLoginScreen extends StatelessWidget {
  TeddyLoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          String teddyImageUrl;
          if (state is LoginEyeCover) {
            teddyImageUrl = 'https://i.imgur.com/5b0Yc3v.png'; // eyes covered
          } else if (state is LoginEmailTracking) {
            teddyImageUrl = 'https://i.imgur.com/Ue3GhIQ.png'; // email typing
          } else {
            teddyImageUrl = 'https://i.imgur.com/Po6M2jY.png'; // neutral
          }

          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    teddyImageUrl,
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 350,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [BoxShadow(blurRadius: 4)],
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: _emailController,
                          onTap:
                              () => context.read<LoginBloc>().add(
                                LoginEmailFocused(),
                              ),
                          onChanged:
                              (value) => context.read<LoginBloc>().add(
                                LoginEmailChanged(value),
                              ),
                          decoration: const InputDecoration(labelText: "Email"),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          onTap:
                              () => context.read<LoginBloc>().add(
                                LoginPasswordFocused(),
                              ),
                          decoration: const InputDecoration(
                            labelText: "Password",
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            context.read<LoginBloc>().add(
                              LoginSubmitted(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                          },
                          child: const Text("Login"),
                        ),
                        const SizedBox(height: 12),
                        if (state is LoginSuccess)
                          const Text(
                            "Login Successful!",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        else if (state is LoginFailure)
                          const Text(
                            "Invalid credentials",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

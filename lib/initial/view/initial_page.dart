import 'package:coolmovies/common/constants/app_layout.dart';
import 'package:coolmovies/home/home.dart';
import 'package:coolmovies/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coolmovies/user/bloc/user_bloc.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state.status == UserStatus.success) {
          UtilNavigate.to(context, const HomePage());
        }
      },
      child: Scaffold(
        body: Center(
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: AppLayout.logoMedium,
                        child: Image.asset('assets/logo.png'),
                      ),
                      const SizedBox(width: AppLayout.spacingSmall),
                      Text(
                        'COOLMOVIES',
                        style: TextStyle(
                          fontSize: 24,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppLayout.spacingLarge),
                  if (state.status == UserStatus.failure) const Text('Something went wrong'),
                  if (state.status == UserStatus.failure) const SizedBox(height: AppLayout.spacingMedium),
                  if (state.status == UserStatus.failure)
                    ElevatedButton(
                        onPressed: () {
                          context.read<UserBloc>().add(const UserCurrentDataRequested());
                        },
                        child: const Text('Retry')),
                  if (state.status != UserStatus.failure) CircularProgressIndicator(color: Theme.of(context).primaryColor),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

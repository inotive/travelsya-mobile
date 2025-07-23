part of 'login_page.dart';

class _LoginActionSection extends StatelessWidget {
  final LoginVM model;
  const _LoginActionSection({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(margin16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Belum punya akun? ', style: mainBody4),
              GestureDetector(
                onTap: () {
                  model.onRegisterTap(context);
                },
                child: Text('Daftar',
                    style: mainBody4.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor)),
              ),
            ],
          ),
          SizedBox(
            height: margin16,
          ),
          ElevatedButtonWidget(
              enabled: true,
              onTap: () {
                model.onLogin(context);
              },
              title: 'Masuk')
        ],
      ),
    );
  }
}

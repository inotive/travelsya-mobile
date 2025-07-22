part of 'home_page.dart';

class _HomePageBalanceSection extends StatelessWidget {
  final BerandaVM model;
  const _HomePageBalanceSection({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xffEAEAEA))),
      padding: EdgeInsets.all(margin24 / 2),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xffF6F6F6)),
                padding: EdgeInsets.all(margin24 / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(ConstHelper.walletIcon),
                        ),
                        SizedBox(
                          width: margin4,
                        ),
                        Text('Saldo Anda', style: mainBody5)
                      ],
                    ),
                    SizedBox(
                      height: margin4,
                    ),
                    BlocBuilder<AuthCubit, AuthState>(
                      bloc: BlocProvider.of<AuthCubit>(context),
                      builder: (contexts, state) {
                        if (state is AuthLoaded) {
                          return BlocBuilder<ProfileCubit, ProfileState>(
                              bloc: BlocProvider.of<ProfileCubit>(context),
                              builder: (context, state) {
                                if (state is ProfileLoading) {
                                  return SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: CircularProgressIndicator(
                                        color: Theme.of(context).primaryColor),
                                  );
                                } else {
                                  return Text(
                                    '0',
                                    style: mainBody5.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor),
                                  );
                                }
                              });
                        } else {
                          return Text(
                            'Silakan Login',
                            style: mainBody5.copyWith(
                                color: Theme.of(context).primaryColor),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: margin24 / 2,
            ),
            HomeSaldoActionWidget(
              title: 'Top Up',
              iconAsset: 'assets/icons/plus_1.png',
              onTap: () {
                model.onTopupMenuTap(context);
              },
            ),
            SizedBox(
              width: margin24 / 2,
            ),
            HomeSaldoActionWidget(
              title: 'Transfer',
              iconAsset: 'assets/icons/trf.png',
              onTap: () {
                model.onTransferTap(context);
              },
            ),
            SizedBox(
              width: margin24 / 2,
            ),
            HomeSaldoActionWidget(
              title: 'Mutasi',
              iconAsset: 'assets/icons/list 1.png',
              onTap: () {
                model.onMutasiTap(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

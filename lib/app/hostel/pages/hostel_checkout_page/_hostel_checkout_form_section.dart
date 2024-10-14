part of 'hostel_checkout_page.dart';

class _HostelCheckoutFormSection extends StatelessWidget {
  final HostelDetailModel data;
  final HostelFormVM model;

  final HostelRoom selectedRoom;

  const _HostelCheckoutFormSection(
      {required this.data, required this.selectedRoom, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(margin16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Pemesan',
            style: mainBody3.copyWith(
                color: neutral100, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: margin24 / 2,
          ),
          TitleWithWidget(
              title: 'Nama Lengkap',
              child: RoundedTextfield(
                  hintText: 'Masukkan nama lengkap Anda',
                  controller: model.nameController)),
          SizedBox(
            height: margin4,
          ),
          Text(
            'Seperti di KTP/SIM.',
            style: mainBody5.copyWith(color: neutral70),
          ),
          SizedBox(
            height: margin16,
          ),
          TitleWithWidget(
              title: 'Nomor Handphone',
              child: RoundedTextfield(
                  hintText: 'Nomor Handphone',
                  keyboardType: TextInputType.number,
                  controller: model.phoneController)),
          SizedBox(
            height: margin16,
          ),
          TitleWithWidget(
              title: 'Email',
              child: RoundedTextfield(
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: model.emailController)),
        ],
      ),
    );
  }
}

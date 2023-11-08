part of 'dialogs.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String description;
  final String cancelText;
  final String confirmText;
  final void Function()? onConfirm;
  final void Function()? onCancel;

  const ConfirmDialog({
    Key? key,
    required this.title,
    this.description = '',
    this.cancelText = '',
    this.confirmText = '',
    this.onConfirm,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: title,
      children: [
        const SizedBox(height: 16),
        if (description.isNotEmpty) ...[
          Text(
            description,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
        ],
        Row(
          children: [
            if (cancelText.isNotEmpty) ...[
              Expanded(
                child: CustomButton(
                  title: cancelText,
                  onTap: onCancel,
                ),
              ),
              const SizedBox(width: 16),
            ],
            if (confirmText.isNotEmpty) ...[
              Expanded(
                child: CustomButton(
                  title: confirmText,
                  onTap: onConfirm,
                ),
              ),
            ],
          ],
        )
      ],
    );
  }
}

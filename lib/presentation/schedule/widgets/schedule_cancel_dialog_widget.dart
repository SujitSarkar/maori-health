import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maori_health/core/config/app_strings.dart';
import 'package:maori_health/core/utils/extensions.dart';
import 'package:maori_health/core/utils/form_validators.dart';

import 'package:maori_health/domain/schedule/entities/schedule.dart';

import 'package:maori_health/presentation/lookup_enums/bloc/bloc.dart';
import 'package:maori_health/presentation/shared/decorations/outline_input_decoration.dart';
import 'package:maori_health/presentation/shared/widgets/app_dialog.dart';
import 'package:maori_health/presentation/shared/widgets/loading_widget.dart';
import 'package:maori_health/presentation/shared/widgets/solid_button.dart';

class ScheduleCancelDialogWidget extends StatelessWidget {
  final Schedule schedule;
  final VoidCallback onClose;
  final Function(String cancelBy, String reason, String reasonType, int hour, int minute) onSave;

  const ScheduleCancelDialogWidget({super.key, required this.schedule, required this.onSave, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final ValueNotifier<String?> cancelReason = ValueNotifier(null);
    final ValueNotifier<String> reasonType = ValueNotifier('');
    final TextEditingController reasonController = TextEditingController();
    final TextEditingController hourController = TextEditingController();
    final TextEditingController minuteController = TextEditingController();

    return AppDialog(
      title: AppStrings.cancelJob,
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: .start,
          children: [
            ValueListenableBuilder(
              valueListenable: cancelReason,
              builder: (context, value, child) => CancelReasonFilterWidget(
                selectedCancelReason: value,
                onSelected: (newReason) {
                  cancelReason.value = newReason;
                },
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: hourController,
                    decoration: OutlineInputDecoration(context: context, labelText: AppStrings.hours),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: FormValidators.validateHours,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: .number,
                    errorBuilder: (context, error) => Text(
                      error,
                      maxLines: 2,
                      style: context.textTheme.labelSmall?.copyWith(
                        fontSize: 9,
                        color: context.theme.colorScheme.error,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: TextFormField(
                    controller: minuteController,
                    decoration: OutlineInputDecoration(context: context, labelText: AppStrings.minutes),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: FormValidators.validateMinutes,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: .number,
                    errorBuilder: (context, error) => Text(
                      error,
                      maxLines: 2,
                      style: context.textTheme.labelSmall?.copyWith(
                        fontSize: 9,
                        color: context.theme.colorScheme.error,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: reasonController,
              decoration: OutlineInputDecoration(context: context, labelText: AppStrings.reason),
              validator: FormValidators.required(),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: .text,
              textCapitalization: .sentences,
              minLines: 3,
              maxLines: 5,
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: SolidButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        onSave(
                          cancelReason.value!,
                          reasonController.text,
                          reasonType.value,
                          int.parse(hourController.text),
                          int.parse(minuteController.text),
                        );
                      }
                    },
                    child: const Text(AppStrings.save),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SolidButton(onPressed: onClose, child: const Text(AppStrings.close)),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class CancelReasonFilterWidget extends StatelessWidget {
  final String? selectedCancelReason;
  final void Function(String? cancelReason) onSelected;
  const CancelReasonFilterWidget({super.key, this.selectedCancelReason, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LookupEnumsBloc, LookupEnumsState>(
      builder: (context, state) {
        final List<String> cancelReasons = state is LookupEnumsLoadedState
            ? state.lookupEnums.cancelReason.values.toList()
            : [];
        final isLoading = state is LookupEnumsLoadingState;
        return Column(
          crossAxisAlignment: .start,
          children: [
            Text(AppStrings.cancelReason, style: context.textTheme.bodyMedium?.copyWith(fontWeight: .w600)),
            const SizedBox(height: 8),
            isLoading
                ? Container(
                    height: 44,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: .circular(10),
                      border: .all(color: context.theme.hintColor),
                    ),
                    child: Center(child: SizedBox(height: 16, width: 16, child: LoadingWidget())),
                  )
                : DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      initialValue: selectedCancelReason,
                      items: cancelReasons.map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList(),
                      onChanged: (String? value) => onSelected(value),
                      validator: FormValidators.required(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: OutlineInputDecoration(
                        context: context,
                        hintText: AppStrings.select,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}

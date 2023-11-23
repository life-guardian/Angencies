String? validateTextField(value, String? label) {
  if (value.isEmpty) {
    return 'Please enter a $label';
  }
  return null;
}

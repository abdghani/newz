import 'dart:math';

List<String> keys = [
  '09c62928a2304401904c503c8c1bc0c1',
  'c2f0c5214b8a46c9921cbfec2b83ab8d',
  'ed42d48abb164af7a27767ba92d14089'
];

getKeys() {
  Random random = new Random();
  int randomNumber = random.nextInt(keys.length);
  return keys[randomNumber];
}

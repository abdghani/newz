import 'dart:math';

List<String> keys = [
  '09c62928a2304401904c503c8c1bc0c1',
  'c2f0c5214b8a46c9921cbfec2b83ab8d',
  'ed42d48abb164af7a27767ba92d14089',
  '35242890bd68453b9155ad31f26285f4',
  'ed8655331a1d42fc8cc31d64b31228be',
  'cb3388cb7ea1452a97598748602e1b5c'
];

getKeys() {
  Random random = new Random();
  int randomNumber = random.nextInt(keys.length);
  return keys[randomNumber];
}

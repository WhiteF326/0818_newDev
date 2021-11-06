<?php
$umail = "lume1a326.leno@gmail.com";
$method = "AES-256-CBC";
$ivLength = openssl_cipher_iv_length($method);
$iv = openssl_random_pseudo_bytes($ivLength);
function concat($carry, $item){
  return $carry. $item;
}
$keyStr = array_reduce(
  array_fill(0, 16, base_convert(bin2hex(openssl_random_pseudo_bytes(16)), 16, 36)),
  "concat", ""
);
$key = substr($keyStr, 0, 256);
$encrypted = openssl_encrypt($umail, $method, $key, 0, $iv);
$saveObject = array(
  "email" => $encrypted,
  "key" => $key,
  "iv" => base64_encode($iv)
);
$saveClearText = json_encode($saveObject);
$timeStamp = time();
$civ = substr(date("Y-m-d H:i:s"), 0, $ivLength);
$saveEncrypted = openssl_encrypt($saveClearText, $method, $key, 0, $civ);

echo openssl_decrypt($saveEncrypted, $method, $key, 0, $civ);
?>
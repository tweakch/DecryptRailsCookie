require 'cgi'
require 'json'
require 'active_support'

# Verifies and decrypts a session cookie using a secret key base.
# @param [String] cookie - The encrypted session cookie.
# @param [String] secret_key_base - The secret key for decryption.
# @return [String] Decrypted cookie content.
def verify_and_decrypt_session_cookie(cookie, secret_key_base)
  raise ArgumentError, 'Cookie cannot be blank' if cookie.to_s.strip.empty?
  raise ArgumentError, 'Secret key base cannot be blank' if secret_key_base.to_s.strip.empty?

  cookie = CGI::unescape(cookie)
  salt         = 'encrypted cookie'
  signed_salt  = 'signed encrypted cookie'
  key_generator = ActiveSupport::KeyGenerator.new(secret_key_base, iterations: 1000)
  secret = key_generator.generate_key(salt)[0, ActiveSupport::MessageEncryptor.key_len]
  sign_secret = key_generator.generate_key(signed_salt)
  encryptor = ActiveSupport::MessageEncryptor.new(secret, sign_secret, serializer: JSON)

  encryptor.decrypt_and_verify(cookie)
end

encrypted_cookie = '<your_cookie>'
secret = '<your_secret>'

cookie = verify_and_decrypt_session_cookie(encrypted_cookie, secret)
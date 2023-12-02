require 'cgi'
require 'json'
require 'active_support'

# Constants for salt values
ENCRYPTED_COOKIE_SALT = 'encrypted cookie'
SIGNED_ENCRYPTED_COOKIE_SALT = 'signed encrypted cookie'

def verify_and_decrypt_session_cookie(cookie, secret_key_base)
  raise ArgumentError, 'Cookie cannot be blank' if cookie.to_s.strip.empty?
  raise ArgumentError, 'Secret key base cannot be blank' if secret_key_base.to_s.strip.empty?

  cookie = CGI::unescape(cookie)
  key_generator = ActiveSupport::KeyGenerator.new(secret_key_base, iterations: 1000)
  secret = key_generator.generate_key(ENCRYPTED_COOKIE_SALT)[0, ActiveSupport::MessageEncryptor.key_len]
  sign_secret = key_generator.generate_key(SIGNED_ENCRYPTED_COOKIE_SALT)
  encryptor = ActiveSupport::MessageEncryptor.new(secret, sign_secret, serializer: JSON)

  encryptor.decrypt_and_verify(cookie)
end

if ARGV.empty?
  puts "Usage: ruby main.rb <encrypted_cookie> [secret_key_base]"
  exit
end

encrypted_cookie = ARGV[0]
secret = ARGV.length > 1 ? ARGV[1] : ENV['RAILS_SECRET_KEY_BASE']

raise 'Secret key base is not provided or set in the environment' if secret.nil? || secret.strip.empty?

begin
  cookie = verify_and_decrypt_session_cookie(encrypted_cookie, secret)
  puts "Decrypted Cookie: #{cookie}"
rescue => e
  puts "Error: #{e.message}"
end
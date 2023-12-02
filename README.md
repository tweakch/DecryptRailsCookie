# DecryptRailsCookie

## Introduction
DecryptRailsCookie is a simple Ruby script designed to decrypt Rails session cookies. This guide will help you set up and run the script.

## Prerequisites
- Ruby environment.
- Rails application with an encrypted cookie to decrypt.

## Setup
1. **Clone the Repository**: Clone this repository to your local machine.
   ```bash
   git clone https://github.com/tweakch/DecryptRailsCookie.git
   cd DecryptRailsCookie
   ```

2. **Install Dependencies**: Install the required Ruby gems.
   ```bash
   gem install cgi json activesupport
   ```

## Usage
1. **Set Cookie and Secret**: Open `main.rb` and replace `<your_cookie>` and `<your_secret>` with your encrypted cookie and secret key base respectively.

2. **Run the Script**: Execute the script in your terminal.
   ```bash
   ruby main.rb
   ```

## Output
The script will output the decrypted content of the Rails session cookie.

## Parameters

### Finding Your Rails Session Cookie:
1. **Access Your Rails Application**: Open your Rails application in a web browser.

2. **Open Developer Tools**:
   - In Chrome, Firefox, or Edge: Press `F12` or right-click on the page and select `Inspect`.
   - In Safari: Enable the Develop menu in Safari's Advanced preferences, then select `Show Web Inspector`.

3. **Go to the 'Application' Tab**: In the developer tools, navigate to the 'Application' tab (Chrome, Edge) or 'Storage' tab (Firefox, Safari).

4. **Find the Cookie**:
   - Look under the 'Cookies' section on the left.
   - Select your site's domain.
   - Find the cookie named something similar to `_yourapp_session`.

This is your encrypted Rails session cookie. Copy its value for use with the DecryptRailsCookie script.

## Locating the Secret Key Base

### Finding Your Rails Application's Secret Key Base:
1. **Access Your Rails Application's Code**: Open the source code of your Rails application.

2. **Locate the Secrets File**: The secret key base is typically stored in one of these files:
   - `config/secrets.yml`
   - `config/credentials.yml.enc` (for Rails 5.2 and later)
   - Environment variables

3. **Extract the Secret Key Base**:
   - If in `secrets.yml`, look for a line like `secret_key_base:`.
   - If using `credentials.yml.enc`, run `rails credentials:edit` to view the file.
   - If stored in environment variables, it will typically be named `SECRET_KEY_BASE`.

Copy the `secret_key_base` for use with the DecryptRailsCookie script. Keep this information secure.

## Configuring Salt and Signed Salt

### Understanding and Setting Salt Values:
1. **Purpose of Salt and Signed Salt**: 
   - `salt`: Used in generating the encryption key.
   - `signed_salt`: Used in generating the signing key for the cookie.

2. **Default Rails Configuration**:
   - Typically, Rails uses default values for these salts.
   - Default values are `"encrypted cookie"` for `salt` and `"signed encrypted cookie"` for `signed_salt`.

3. **Custom Configuration**:
   - If your Rails application uses custom salt values, you need to replace the default values in the script.
   - Find these values in your Rails application, possibly within the initializers or the environment configuration files.

Ensure that the `salt` and `signed_salt` in the script match the ones used by your Rails application for accurate decryption.

## Note
Ensure the secret key base matches the one used by your Rails application for the encrypted cookie. Use environment variables or other secure methods to
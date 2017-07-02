package.path  = '?.lua;' .. package.path
package.cpath = '?.dll;clibs\\?.dll;' .. package.cpath

dropbox = require 'init'

dropbox.access_token = '' -- set access_token

print('logged in with: ' .. dropbox.get_current_account(dropbox.access_token).email)
# Lua-Dropbox-API
Esta librería se conecta con la API REST de Dropbox para interactuar con archivos desde Lua.

# Dependencias

requests 1.1-1     - https://github.com/JakobGreen/lua-requests lic
lub 1.1.0-1	       - https://github.com/lubyk/lub
md5 1.2-1          - https://github.com/keplerproject/md5
luasocket 3.0rc1-2 - https://github.com/diegonehab/luasocket
luasec 0.6-1       - https://github.com/brunoos/luasec
xml 1.1.3-1        - https://github.com/lubyk/xml

# Instalacion
	
	$ git clone https://github.com/dariocanoh/Lua-Dropbox-API.git dropboxapi

# Como usarlo

Debe ejecutar la libreria lua con un intérprete de Lua5.1 y para importarlo es dependiendo de 
como haya llamado el repositorio que descargó, pero por favor llamelo *dropboxapi*.

	local dropbox      = require 'dropboxapi.init'
	local a_token      = '<acces_token>'
	local account_info = dropbox.get_account_info(a_token)
	
	print('Cuenta de Dropbox:\n> Nombre: '.. account_info.display_name .. '\n> Email: ' .. account_info.display_name)
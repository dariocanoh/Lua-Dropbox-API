-- /////////////////////////////////////////////////////////////////////////////////////////////////
-- // Name:        luadropboxapi/init.lua
-- // Purpose:     Initialize Lua Dropbox API functions
-- // Author:      Dario Cano [thdkano@gmail.com]
-- // Created:     2016/09/15
-- // Copyright:   (c) 2016 Dario Cano
-- // License:     MIT License
-- /////////////////////////////////////////////////////////////////////////////////////////////////
--
--- dropbox.get_access_token
--- dropbox.get_account_info
--- dropbox.get_file_content
---

local requests = require 'requests'
local dropbox  = {}

--- Devuelve el token de acceso que permite hacer operaciones con la api de dropbox.
--- client_id y client_secret son appkey y appsecret respectivamente, estos los podemos encontrar en:
--- > https://www.dropbox.com/developers/apps/
--- 
--- auth_code lo obtenemos de acuerdo con el tutorial oficial: https://blogs.dropbox.com/developers/2013/07/using-oauth-2-0-with-the-core-api/
--- 
--- Ingresamos esta web en el explorador: https://www.dropbox.com/1/oauth2/authorize?client_id=<app_key>&response_type=code
--- cambiando "<app_key>" por la clave que obtenemos en la consola de dropbox
---
--- string access_token = dropbox.get_access_token ( string 'app_key', string 'app_secret', string 'auth_code' );
---
function dropbox.get_access_token ( client_id, client_secret, auth_code )
	local query_parameters  = { 
		grant_type    = 'authorization_code', 
		code          = (auth_code),
		client_id     = client_id,
		client_secret = client_secret,
	}
	
	local response = requests.post { url = 'https://api.dropboxapi.com/1/oauth2/token', params = query_parameters }

	if response.json().error then
		print ('http error:', response.json().error, response.json().error_description)
	end

	for json_key, json_val in pairs( response.json() ) do
		if (json_key == 'access_token') then
			return json_val
		end
	end
end

--- Devuelve la informacion de la cuenta de Dropbox en una tabla de acuerdo al documento json original.
--- 
--- table account_info = dropbox.get_account_info ( string 'access_token' )
---
function dropbox.get_account_info ( access_token )
	local query_parameters = { locale = 'en' }

	local headers = {
		['Authorization'] = 'Bearer ' .. access_token
	}

	local response = requests.get {url = 'https://api.dropboxapi.com/1/account/info', headers = headers, query_parameters = query_parameters }

	return response.json()	
end

--- Devuelve el contenido del archivo o false si hubo un error.
--- 
--- file_contents = dropbox.get_file ( string 'access_token', string 'cloud_file_path' )
--- 	
---		dropbox.get_file_content(acces_token, 'Public/Documentos/Trabajo.docx');
---
function dropbox.get_file_content ( access_token, cloud_file_path )
	local query_parameters = { 
		-- rev The revision of the file to retrieve. This defaults to the most recent revision.
		-- rev = ''
	}

	local headers = {
		['Authorization'] = 'Bearer ' .. access_token
	}

	local response = requests.get { url = 'https://content.dropboxapi.com/1/files/auto/'..cloud_file_path, headers = headers, query_parameters = query_parameters }	
	
	-- 200 Codigo 200 significa que todo va bien:
	if (response.status_code == 200) then
		-- Retornamos el archivo completo:
		return response.text
	elseif (response.status_code == '404') then
		return false, 'lua-dropbox-api: '..response.json().error, response.json().error_description
	end
end

return dropbox
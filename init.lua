-- /////////////////////////////////////////////////////////////////////////////////////////////////
-- // Name:        luadropboxapi/init.lua
-- // Purpose:     Lua Dropbox API functions
-- // Author:      Hernan Dario Cano [dcanohdev@gmail.com]
-- // Created:     2016/09/15
-- // Copyright:   (c) 2016 Hernan Dario Cano
-- // License:     MIT/X11
-- /////////////////////////////////////////////////////////////////////////////////////////////////
--
-- All dates in the API are strings in the following format:
-- "Sat, 21 Aug 2010 22:31:20 +0000"
-- In code format, which can be used in all programming languages that support strftime or strptime:
-- "%a, %d %b %Y %H:%M:%S %z"

--[[ status_codes:

400	Bad input parameter. Error message should indicate which one and why.
401	Bad or expired token. This can happen if the user or Dropbox revoked or expired an access token. To fix, you should re-authenticate the user.
403	Bad OAuth request (wrong consumer key, bad nonce, expired timestamp...). Unfortunately, re-authenticating the user won't help here.
404	File or folder not found at the specified path.
405	Request method not expected (generally should be GET or POST).
429	Your app is making too many requests and is being rate limited. 429s can trigger on a per-app or per-user basis.
503	If the response includes the Retry-After header, this means your OAuth 1.0 app is being rate limited. Otherwise, this indicates a transient server error, and your app should retry its request.
507	User is over Dropbox storage quota.
5xx	Server error. Check DropboxOps.

]]

function print ( txt )
	Dialog.Message('DROPBOXAPI:', tostring(txt))
end

local function validate_response ( response )
	local DROPBOX_BAD_REQUEST       = 400
	local DROPBOX_BAD_EXPIRED_TOKEN = 401
	
	if (response.status_code == DROPBOX_BAD_REQUEST) 
	or (response.status_code == DROPBOX_BAD_EXPIRED_TOKEN) then
		return false, response.text
	else
		return response.json()
	end
end

local requests = require 'requests'
local dropbox  = {}

dropbox.access_token = nil

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
function dropbox.get_access_token ( client_id, client_secret, auth_code, redirect_uri )
	local query_parameters  = { 
		grant_type = 'authorization_code', 
		code       = auth_code,
		--client_id     = client_id,
		--client_secret = client_secret,
		redirect_uri  = redirect_uri,
	}

	local auth = requests.HTTPBasicAuth(client_id, client_secret)
	local response = requests.post { url = 'https://api.dropbox.com/1/oauth2/token', auth = auth, params = query_parameters }
	
	if response.status_code == 400 then
		print('dropbox.lua:' .. response.text)
		return false, response.text
	end

	if response.json() then
		dropbox.access_token = response.json().access_token--, response.json().account_id
		return dropbox.access_token
	end
end

-- Disables the access token used to authenticate the call.
function dropbox.auth_token_revoke ( access_token )
	local headers = {
		['Authorization'] = 'Bearer ' .. access_token,
	}

	local response = requests.post { url = 'https://api.dropboxapi.com/2/auth/token/revoke', headers = headers }
	
	if response.status_code == 400 then
		return false, response.text
	end

	return true
end

-- Get the space usage information for the current user's account.
function dropbox.get_space_usage ( access_token )
	local headers = {
		['Authorization'] = 'Bearer ' .. access_token,
	}

	local response = requests.post { url = 'https://api.dropboxapi.com/2/users/get_space_usage', headers = headers }
	
	if response.status_code == 400 then
		return false, response.text
	end

	return response.json()
end


function dropbox.list_folder( access_token, path, recursive, include_media_info, include_deleted, include_has_explicit_shared_members )
	local data = { 
		path      = tostring(path),
		recursive = recursive,
		include_media_info = include_media_info,
		include_deleted = include_deleted,
		include_has_explicit_shared_members = include_has_explicit_shared_members,
	}

	local headers = {
		['Authorization'] = 'Bearer ' .. access_token,
		['Content-Type']  = 'application/json',
	}

	local response = requests.post { url = 'https://api.dropboxapi.com/2/files/list_folder', headers = headers, data = data }	
	
    return validate_response(response)
end

-- Create a folder at a given path.
-- metadata = dropbox.create_folder ( token, '/thepath' )
function dropbox.create_folder ( access_token, path, autorename )
	local headers = {
		['Authorization'] = 'Bearer ' .. access_token,
		['Content-Type']  = 'application/json',
	}
	
	local query_parameters = {
		path = path,
		autorename = autorename,
	}

	local response = requests.post { 
		url = 'https://api.dropboxapi.com/2/files/create_folder_v2',
		headers = headers, data = query_parameters 
	}

	if validate_response(response) then
		return validate_response(response).metadata
	else
		return validate_response(response)
	end
end

-- Delete the file or folder at a given path.
-- If the path is a folder, all its contents will be deleted too.
-- A successful response indicates that the file or folder was deleted. The returned metadata will be the corresponding FileMetadata or FolderMetadata for the item at time of deletion, and not a DeletedMetadata object.

function dropbox.file_delete ( access_token, path )
	local headers = {
		['Authorization'] = 'Bearer ' .. access_token,
		['Content-Type']  = 'application/json',
	}
	
	local query_parameters = {
		path = path,
	}

	local response = requests.post { 
		url = 'https://api.dropboxapi.com/2/files/delete_v2',
		headers = headers, data = query_parameters 
	}
	
	if validate_response(response) then
		return validate_response(response).metadata
	else
		return validate_response(response)
	end
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

-- Download a file from a user's Dropbox.
-- %to.do% upgrade endpoints to api v2: https://content.dropboxapi.com/2/files/download
function dropbox.file_download( access_token, path, destination)
	local dest_file = io.open (destination, 'w+b')
	local content   = dropbox.get_file_content ( access_token, path )

	dest_file:write(content)
	dest_file:flush()
	dest_file:close()

	local read = io.open(destination, 'r+b');
	if read:read '*a' == content then
		read:close()
		return true
	else
		return false
	end
end

local json = require 'cjson'

-- Create a new file with the contents provided in the request.
-- Do not use this to upload a file larger than 150 MB. Instead, create an upload session with upload_session/start.
function dropbox.file_upload ( access_token, file_to_upload, path, mode, autorename, mute )
	local headers = {
		['Authorization']   = 'Bearer ' .. access_token,
		['Content-Type']    = 'application/octet-stream',
		['Dropbox-API-Arg'] = json.encode { path = path, mode = mode, autorename, autorename, mute, mute }
	}
	
	local response = requests.post { 
		url = 'https://content.dropboxapi.com/2/files/upload',
		headers = headers, --arg = json.encode(query_data),
		
		['data-binary'] = io.open(file_to_upload, 'r+b'):read '*a'
	}
	
	if validate_response(response) then
		return validate_response(response)
	end
end

--- Get information about the current user's account.
function dropbox.get_current_account ( access_token )
	local headers = {
		['Authorization'] = 'Bearer ' .. access_token
	}

	local response = requests.get {url = 'https://api.dropboxapi.com/2/users/get_current_account', headers = headers }

	return response.json()
end

return dropbox
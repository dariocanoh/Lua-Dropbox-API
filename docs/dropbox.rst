Referencia para Lua Dropbox API
-------------------------------

Todas las funciones de la api devolverán *false* en caso de error y como segundo argumento un string que
contiene el mensaje de error proporcionado por la Dropbox Core API o por el programador.

dropbox.get_access_token
^^^^^^^^^^^^^^^^^^^^^^^^
   
Obtiene el token de acceso para hacer operaciones con la api de dropbox.
*app_key* y *app_secret* los podemos encontrar en: 
	> https://www.dropbox.com/developers/apps/
   
*auth_code* lo obtenemos de acuerdo con el tutorial oficial:
	> https://blogs.dropbox.com/developers/2013/07/using-oauth-2-0-with-the-core-api/
   
Ingresando ésta web en el explorador: 
	> https://www.dropbox.com/1/oauth2/authorize?client_id=<app_key>&response_type=code

Cambiando "<app_key>" por la clave que obtenemos en la consola de dropbox

==========  ========================================================================================
 string      dropbox.get_access_token ( string_ 'app_key', string_ 'app_secret', string_ 'auth_code' );
==========  ========================================================================================

----------------------------------------------------------------------------------------------------

dropbox.get_account_info
^^^^^^^^^^^^^^^^^^^^^^^^
   
Devuelve la informacion de la cuenta de Dropbox en una tabla.
   
==========  ========================================================================================
  table     dropbox.get_account_info ( string_ 'access_token' )
==========  ========================================================================================

----------------------------------------------------------------------------------------------------

dropbox.get_file_content
^^^^^^^^^^^^^^^^^^^^^^^^
   
Obtiene el contenido de un archivo binario o de texto.

=========  ===========================================================================================
 string  	dropbox.get_file ( string_ 'access_token', string_ 'dropbox_file_path' )
=========  ===========================================================================================
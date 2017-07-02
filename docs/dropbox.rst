Referencia para Lua Dropbox API
-------------------------------

Todas las funciones de la api devolverán *false* en caso de error y como segundo argumento un string que
contiene el mensaje de error proporcionado por la Dropbox Core API o por el programador.

dropbox.get_access_token
^^^^^^^^^^^^^^^^^^^^^^^^
   
Obtiene el token de acceso para hacer operaciones con la api de dropbox.

*app_key* y *app_secret* los podemos encontrar en: 
	>>> https://www.dropbox.com/developers/apps/
   
*auth_code* lo obtenemos de acuerdo con el tutorial oficial:
	>>> https://blogs.dropbox.com/developers/2013/07/using-oauth-2-0-with-the-core-api/
   
Ingresando ésta web en el explorador: 
Cambiando "<app_key>" por la clave que obtenemos en la consola de dropbox
	>>> https://www.dropbox.com/1/oauth2/authorize?client_id=<app_key>&response_type=code



==========  ========================================================================================
 string      dropbox.get_access_token ( string_ 'app_key', string_ 'app_secret', string_ 'auth_code' );
==========  ========================================================================================

----------------------------------------------------------------------------------------------------

dropbox.auth_token_revoke
^^^^^^^^^^^^^^^^^^^^^^^^^

Deshabilita el token de acceso usado para autenticar las llamadas.
   
==========  ========================================================================================
  bool_      dropbox.auth_token_revoke ( string_ 'access_token' )
==========  ========================================================================================

----------------------------------------------------------------------------------------------------

dropbox.get_space_usage
^^^^^^^^^^^^^^^^^^^^^^^  

Devuelve la información acerca del espacio utilizado para la cuenta actual. 

**(Los valores están expresados en bytes).**

==========  ========================================================================================
  table      dropbox.get_space_usage ( string_ 'access_token' )
==========  ========================================================================================

.. code-block::
  
 {
    "used": 314159265,
    "allocation": {
        ".tag": "individual",
        "allocated": 10000000000
    }
 }

----------------------------------------------------------------------------------------------------

dropbox.get_file_content
^^^^^^^^^^^^^^^^^^^^^^^^
   
Obtiene el contenido de un archivo binario o de texto.

=========  ===========================================================================================
 string_  	dropbox.get_file ( string_ 'access_token', string_ 'dropbox_file_path' )
=========  ===========================================================================================


----------------------------------------------------------------------------------------------------

dropbox.create_folder
^^^^^^^^^^^^^^^^^^^^^  

Crear una carpeta en la ruta especificada.

.. code-block::

 - path: (String pattern = "(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)") La ruta a crear dentro del dropbox.
 - autorename: Si hay un conflicto, el servidor de dropbox tiene qué renombrar la carpeta para 
   resolver el conflicto.

==========  ========================================================================================
  table_     dropbox.create_folder ( string_ 'path', bool_ autorename = false )
==========  ========================================================================================
 
 - **Returns:**

.. code-block::

 CreateFolderResult :: FolderMetadata {
    "metadata": {
        "name": "math",
        "id": "id:a4ayc_80_OEAAAAAAAAAXz",
        "path_lower": "/homework/math",
        "path_display": "/Homework/math",
        "sharing_info": {
            "read_only": false,
            "parent_shared_folder_id": "84528192421",
            "traverse_only": false,
            "no_access": false
        },
        "property_groups": [
            {
                "template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa",
                "fields": [
                    {
                        "name": "Security Policy",
                        "value": "Confidential"
                    }
                ]
            }
        ]
    }
 }
----------------------------------------------------------------------------------------------------

dropbox.file_delete
^^^^^^^^^^^^^^^^^^^  

Eliminar el archivo en la ruta especificada.

.. code-block::

 - path: (String pattern = "(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)") La ruta a crear dentro del dropbox.

==========  ========================================================================================
  table_     dropbox.file_delete ( string_ 'access_token', string_ 'path' )
==========  ========================================================================================


.. code-block::

 DeletedMetadata :: FolderMetadata {
    ".tag": "file",
    "name": "Prime_Numbers.txt",
    "id": "id:a4ayc_80_OEAAAAAAAAAXw",
    "client_modified": "2015-05-12T15:50:38Z",
    "server_modified": "2015-05-12T15:50:38Z",
    "rev": "a1c10ce0dd78",
    "size": 7212,
    "path_lower": "/homework/math/prime_numbers.txt",
    "path_display": "/Homework/math/Prime_Numbers.txt",
    "sharing_info": {
        "read_only": true,
        "parent_shared_folder_id": "84528192421",
        "modified_by": "dbid:AAH4f99T0taONIb-OurWxbNQ6ywGRopQngc"
    },
    "property_groups": [
        {
            "template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa",
            "fields": [
                {
                    "name": "Security Policy",
                    "value": "Confidential"
                }
            ]
        }
    ],
    "has_explicit_shared_members": false,
    "content_hash": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
 }
----------------------------------------------------------------------------------------------------

dropbox.file_download
^^^^^^^^^^^^^^^^^^^^^  

Descargar el archivo desde Dropbox a la ruta especificada.

==========  ========================================================================================
  bool_      dropbox.file_delete ( string_ 'access_token', string_ 'path', string_ 'destination' )
==========  ========================================================================================

----------------------------------------------------------------------------------------------------

dropbox.file_upload
^^^^^^^^^^^^^^^^^^^

Descargar el archivo desde Dropbox a la ruta especificada.

==========  ========================================================================================
  table_     dropbox.file_upload ( string_ access_token, string_ file_to_upload, string_ path, string_ mode, bool_ autorename = false, bool_ mute = false  )
==========  ========================================================================================

----------------------------------------------------------------------------------------------------

dropbox.get_current_account
^^^^^^^^^^^^^^^^^^^^^^^^^^^ 

Obtiene la información acerca de la cuenta de usuario actual.

==========  ========================================================================================
  table_     dropbox.get_current_account ( string_ 'access_token' )
==========  ========================================================================================

----------------------------------------------------------------------------------------------------

dropbox.list_folder
^^^^^^^^^^^^^^^^^^^

Obtiene los nombres de archivos dentro de una carpeta.

==========  ========================================================================================
  table_     dropbox.list_folder( _string_ access_token, string_ path, bool_ recursive, bool_ include_media_info, bool_ include_deleted, bool_ include_has_explicit_shared_members )
==========  ========================================================================================

----------------------------------------------------------------------------------------------------

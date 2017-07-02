*Lua Dropbox API* está construida sobre la `Dropbox REST API v2 <https://www.dropbox.com/developers/documentation/http/documentation>`_ 
la cual es una serie de endpoints que nos permiten interactuar con los servicios de Dropbox.

Aquí está todo explicado, de todos modos puede echar un vistazo a la documentación completa para 
aprender todo lo que podemos hacer con la API.

`Dropbox for HTTP Developers <https://www.dropbox.com/developers/documentation/http/overview>`_ 


Dependencias
============

Para poder funcionar, ésta libreria requiere tener instaladas las siguientes librerías en su máquina.

.. code-block::

	* requests 1.1-1      - https://github.com/JakobGreen/lua-requests
	* lub 1.1.0-1	      - https://github.com/lubyk/lub
	* md5 1.2-1           - https://github.com/keplerproject/md5
	* luasocket 3.0rc1-2  - https://github.com/diegonehab/luasocket
	* luasec 0.6-1        - https://github.com/brunoos/luasec
	* xml 1.1.3-1         - https://github.com/lubyk/xml
	* lbase64 20120820-1  - http://webserver2.tecgraf.puc-rio.br/~lhf/ftp/lua/5.1/lbase64.tar.gz
	* lua-cjson           - 

Instalación
===========

.. code-block:: bash
	
	$ cd my_app
	$ git clone https://github.com/dariocanoh/Lua-Dropbox-API.git dropboxapi
	$ lua5.1 -l dropboxapi.init


Cómo usarlo
===========

Debe ejecutar la libreria lua con un intérprete de Lua5.1 y para importarlo es dependiendo de 
como haya llamado el repositorio que descargó, pero por favor llamelo *luadropboxapi*.

.. code-block:: lua
	
	dropbox = require 'luadropboxapi'

	dropbox.access_token = '' --> define access_token here

	print('logged in with: ' .. dropbox.get_current_account(dropbox.access_token).email)


Referencia
==========

===============================  =======================================================================
  Métodos de la clase      	       Descripción
===============================  =======================================================================
 dropbox.get_access_token_        Obtiene el token de acceso para trabajar con las funciones de la api.
 dropbox.get_file_content_        Obtiene el contenido de un archivo binario o de texto.
 dropbox.get_space_usage_         Obtiene la informacion de el espacio de almacenamiento usado.
 dropbox.auth_token_revoke_       Deshabilita el token de acceso usado para autenticar las llamadas.
 dropbox.get_file_content_        Obtiene el contenido de un archivo binario o de texto.
 dropbox.create_folder_	          Crear una carpeta en la ruta especificada.
 dropbox.file_delete_             Eliminar el archivo en la ruta especificada.
 dropbox.file_download_           Descargar el archivo desde Dropbox a la ruta especificada.
 dropbox.file_upload_             Descargar el archivo desde Dropbox a la ruta especificada.
 dropbox.get_current_account_     Obtiene la información acerca de la cuenta de usuario actual.
 dropbox.list_folder_             Obtiene los nombres de archivos dentro de una carpeta.
===============================  =======================================================================


.. _dropbox.get_access_token: docs/dropbox.rst # dropboxget_access_token
.. _dropbox.get_account_info: docs/dropbox.rst # dropboxget_account_info
.. _dropbox.get_file_content: docs/dropbox.rst # dropboxget_file_content
.. _dropbox.get_space_usage: docs/dropbox.rst # dropboxget_space_usage
.. _dropbox.auth_token_revoke: docs/dropbox.rst # dropboxauth_token_revoke
.. _dropbox.create_folder: docs/dropbox.rst # dropboxcreate_folder
.. _dropbox.file_delete: docs/dropbox.rst # dropboxfile_delete
.. _dropbox.file_download: docs/dropbox.rst # dropboxfile_download
.. _dropbox.file_upload: docs/dropbox.rst # dropboxfile_upload
.. _dropbox.get_current_account:docs/dropbox.rst # dropboxget_current_account
.. _dropbox.list_folder: docs/dropbox.rst # dropboxlist_folder
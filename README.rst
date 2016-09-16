Ésta librería se conecta con la API REST de Dropbox para interactuar con archivos desde Lua.

*Lua Dropbox API* está construida sobre la `Dropbox REST API v2 <https://www.dropbox.com/developers/documentation/http/documentation>`_ 
la cual es una serie de endpoints que nos permiten interactuar con los servicios de Dropbox.

.. note::

	Un endpoint es la interface web a través de la cual los sistemas externos pueden enviar y recibir 
	mensajes a una aplicación o servidor web.

Aquí está todo explicado, de todos modos puede echar un vistazo a la documentación completa para 
aprender todo lo que podemos hacer con la API.

`Dropbox for HTTP Developers <https://www.dropbox.com/developers/documentation/http/overview`_ 


Dependencias
============

Para poder funcionar, ésta libreria requiere tener instaladas las siguientes librerías en su máquina.

.. code-block::

	* requests 1.1-1      - https://github.com/JakobGreen/lua-requests lic
	* lub 1.1.0-1	      - https://github.com/lubyk/lub
	* md5 1.2-1           - https://github.com/keplerproject/md5
	* luasocket 3.0rc1-2  - https://github.com/diegonehab/luasocket
	* luasec 0.6-1        - https://github.com/brunoos/luasec
	* xml 1.1.3-1         - https://github.com/lubyk/xml
	* lbase64 20120820-1  - http://webserver2.tecgraf.puc-rio.br/~lhf/ftp/lua/5.1/lbase64.tar.gz


Instalación
===========

.. code-block:: bash
	
	$ cd my_app
	$ git clone https://github.com/dariocanoh/Lua-Dropbox-API.git dropboxapi
	$ lua5.1 -l dropboxapi.init


# Cómo usarlo

Debe ejecutar la libreria lua con un intérprete de Lua5.1 y para importarlo es dependiendo de 
como haya llamado el repositorio que descargó, pero por favor llamelo *dropboxapi*.

	local dropbox      = require 'dropboxapi.init'
	local a_token      = '<acces_token>'
	local account_info = dropbox.get_account_info(a_token)
	
	print('Cuenta de Dropbox:\n> Nombre: '.. account_info.display_name .. '\n> Email: ' .. account_info.display_name)


Referencia
==========

Lua Wrapper para Dropbox Core API.

===========================  =======================================================================
  Métodos de la clase      	   Descripción
===========================  =======================================================================
 dropbox.get_access_token_     Obtiene el token de acceso para trabajar con las funciones de la api.
 dropbox.get_account_info_	   Obtiene la información de la cuenta del usuario.
 dropbox.get_file_content_     Obtiene el contenido de un archivo binario o de texto.
===========================  =======================================================================


.. _dropbox.get_access_token: docs/dropbox.rst # dropboxget_access_token
.. _dropbox.get_account_info: docs/dropbox.rst # dropboxget_account_info
.. _dropbox.get_file_content: docs/dropbox.rst # dropboxget_file_content
name             "radicale"
maintainer       "Christian Nicolai"
maintainer_email "cn@mycrobase.de"
license          "Apache 2.0"
description      "Installs Radicale (the complete CalDAV and CardDAV server) via pip and configures it"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

depends "python"

suggests "logrotate" # for radicale::logrotate

supports "debian"

maintainer       "Pirate Party Swizerland"
maintainer_email "admin@piratenpartei.ch"
license          "MIT"
description      "Installs/Configures base preconditions"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

%w{debian}.each do |os|
  supports os
end
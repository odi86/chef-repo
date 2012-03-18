maintainer       "Christian Häusler"
maintainer_email "haeusler.christian@mac.com"
license          "Apache 2.0"
description      "Installs and maintain php-fpm sapi. Based on the work of Yevgeniy Viktorov<wik@rentasite.com.ua>"
version          "0.2.0"
recipe           "php-fpm", "Installs php-fpm with a defualt pool"
recipe           "php-fpm::manager", "Installs php-fpm without any active pool"
recipe           "php-fpm::pool", "Installs a default php-fpm pool"

%w{ debian }.each do |os|
  supports os
end

%w{ dotdeb }.each do |cb|
  depends cb
end

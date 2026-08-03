{ pkgs, ... }:

{
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    
    ensureDatabases = [  ]; 
    
    settings = {
      mysqld = {
        bind-address = "127.0.0.1"; 
        max_connections = 50; 
        innodb_buffer_pool_size = "128M";
        key_buffer_size = "16M";
        performance_schema = "OFF";
      };
    };
  };
}

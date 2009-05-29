# Example of a safe script to backup your server
#
# for more detail look here:
# http://github.com/astrails/safe/tree/master
# http://blog.astrails.com/2009/4/6/simple-backups-can-be-simple
safe do
    local :path => "/backup/:kind/:id"

    s3 do
      key "...................."
      secret "........................................"
      bucket "backup.astrails.com"
      path "servers/alpha/:kind/:id"
    end

    keep do
      local 3
      s3 3
    end

    mysqldump do
      options "-ceKq --single-transaction --create-options"

      user "root"
      password "............"
      #socket "/var/run/mysqld/mysqld.sock"

      database :your_app_production

    end

    tar do
      archive "dot-configs",      :files => "/home/*/.[^.]*"
      archive "etc",              :files => "/etc"

      archive "your_app" do
        files "/var/www/rails_apps/your_app/"
        exclude ["/var/www/rails_apps/your_app/shared/logs"]
      end

    end
  end
configure do

  # Log queries to STDOUT in development
  if Sinatra::Application.development?
    ActiveRecord::Base.logger = Logger.new(STDOUT)

    set :database, {
      adapter: "sqlite3",
      database: "db/db.sqlite3"
    }
  end

  if Sinatra::Application.production?
    ActiveRecord::Base.establish_connection ENV['DATABASE_URL']
  end

end

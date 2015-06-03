require 'rake'
require "sinatra/activerecord/rake"
require ::File.expand_path('../config/environment', __FILE__)

Rake::Task["db:create"].clear
Rake::Task["db:drop"].clear

#shotgun -p 3000 -o 0.0.0.0

# NOTE: Assumes SQLite3 DB
desc "create the database"
task "db:create" do
  touch 'db/db.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/db.sqlite3'
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc "start console"
task :console do
  require 'irb'
  require 'irb/completion'
  require ::File.expand_path('../config/environment',  __FILE__)

  ARGV.clear
  IRB.start
end

desc "populate db"
task :populate_db do

  # Create 10 Users
  10.times do |n|
    User.create!({
      first_name: ["Paul", "Patty", "Shaun", "Marnie"].sample,
      last_name: ["Halliday", "Marshall", "Serna", "Hawkins"].sample,
      email: "email#{n}@email.com",
      password: "cats123",
      age: (20..50).to_a.sample
    })
  end

  user_ids = User.pluck(:id)

  # Create 100 Pets
  100.times do |n|
    Pet.create!({
      user_id: user_ids.sample,
      genus: ["Cat", "Dog", "Llama", "Bear"].sample,
      name: ["Chewy", "Fluffy", "Sneaky", "Tippy", "Cuddly"].sample,
      birth_date: (1..10).to_a.sample.years.ago.to_date
    })
  end

end

desc "export db"
task :export_db do
  require 'CSV'

  [User, Pet].each do |klass|
    CSV.open("#{klass.name.downcase.pluralize}.csv", "wb") do |csv|
      csv << klass.column_names
      klass.find_each do |p|
        csv << klass.column_names.map{|c| p.send(c)}
      end
    end
  end
end

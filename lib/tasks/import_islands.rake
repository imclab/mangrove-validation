desc 'Import islands from CartoDB'
task :import_islands_from_cartodb => :environment do
  page, per_page = 0, 200

  begin
    puts "Importing islands offset #{page*per_page}"
    result = CartoDB::Connection.query "SELECT island_id AS id, MIN(name) AS name, MIN(name_local) AS name_local, MIN(iso_3) AS iso_3 FROM gid_development_copy GROUP BY island_id ORDER BY island_id OFFSET #{page*per_page} LIMIT #{per_page}"

    result.rows.each do |row|
      island = Island.find_or_initialize_by_id(row.id)
      island.update_attributes(row)
    end

    page = page + 1
  end while result.rows.length == per_page

  # Reset ID sequence to max id + 1
  Island.connection.execute "SELECT SETVAL('islands_id_seq', (SELECT MAX(id) FROM islands) + 1);"
  
end

desc 'Import countries from CSV'
task :import_countries => :environment do
  require 'csv'
  CSV.foreach("#{Rails.root}/lib/data/countrylist.csv", :headers => true) do |row|
    Country.find_or_create_by_iso_3( row.field('ISO 3166-1 3 Letter Code'), :name => row.field('Common Name'))
  end
end

namespace :scrape do 
  # this is a description of your task
  desc "Scraping Google Finance Fundamentals Data"

  # this is your task function
  task :google_finance => :environment do
    # In order to access a website, I need to require this
    require 'open-uri'

    # In order to scrape elements on a website, I need to require nokogiri
    require 'nokogiri'

    # this access the site
    url = "https://www.google.com/finance?q=NASDAQ%3AAAPL&fstype=ii"
    document = open(url).read

    # this parse the site using Nokogiri
    html_doc = Nokogiri::HTML(document)

    # this is the format of what we want. I get this from Kimono where you have highlighted these items
    data_format = "div.id-incannualdiv > table.gf-table.rgt > tbody > tr > td.lft.lm"

    # use nokogiri to get all the data that shares the common format
    row_names = html_doc.css(data_format)

    puts row_names
  end


  desc "Scrape companies"
    task :make_companies => :environment do
      require 'open-uri'
      require 'csv'

      url = "http://s3.amazonaws.com/nvest/nasdaq_09_11_2014.csv"

      url_data = open(url)

      CSV.foreach(url_data) do |symbol, name|
        # puts "#{name}: #{symbol}" unless name == "Name"
        Company.create(:name => name, :symbol => symbol) unless name == "Name"
      end
      puts "done scrapping"
    end
end

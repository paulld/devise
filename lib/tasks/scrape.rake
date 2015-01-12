namespace :scrape do 
  
  desc "Scraping the row names and convert into symbol (to generate our Annualincome model"
    task :get_row_names => :environment do
      
      require 'open-uri'
      require 'nokogiri'

      url = "https://www.google.com/finance?q=NASDAQ%3AAAPL&fstype=ii"
      document = open(url).read

      html_doc = Nokogiri::HTML(document)

      data_format = "div.id-incannualdiv > table.gf-table.rgt > tbody > tr > td.lft.lm"

      array_of_row_names = []

      html_doc.css(data_format).map do |t|
        t = t.text.parameterize.underscore.to_sym   # convert <td class="">Foo Bar</td> into :foo_bar
        array_of_row_names.push(t)
      end
      puts array_of_row_names
    end


  # this is your task function
  desc "Scrape the financials from Google Finance"
    task :get_financials => :environment do
      # In order to access a website, I need to require this
      require 'open-uri'

      # In order to scrape elements on a website, I need to require nokogiri
      require 'nokogiri'
      
      # this is the format of what we want. I get this from Kimono where you have highlighted these items
      data_format = [
        "div.id-incannualdiv > table.gf-table.rgt > tbody > tr > td.lft.lm",
        "div.id-incannualdiv > table.gf-table.rgt > tbody > tr > td:nth-child(2).r",
        "div.id-incannualdiv > table.gf-table.rgt > tbody > tr > td:nth-child(3).r",
        "div.id-incannualdiv > table.gf-table.rgt > tbody > tr > td:nth-child(4).r",
        "div.id-incannualdiv > table.gf-table.rgt > tbody > tr > td.r.rm"
      ]

      companies = Company.all

      for i in 0..companies.length do
        if i < 190
          url = "https://www.google.com/finance?q=NASDAQ%3A" + companies[i].symbol + "&fstype=ii"
          puts url
          puts companies[i].symbol
          
          # this access the site
          document = open(url).read
          # this parse the site using Nokogiri
          html_doc = Nokogiri::HTML(document)

          array_of_names = []
          html_doc.css(data_format[0]).map do |t|
            t = t.text.parameterize.underscore.to_sym   # convert <td class="">Foo Bar</td> into :foo_bar
            array_of_names.push(t)
          end
          array_of_year1 = []
          html_doc.css(data_format[1]).map do |t|
            t = t.text.parameterize.underscore.to_sym   # convert <td class="">Foo Bar</td> into :foo_bar
            array_of_year1.push(t)
          end

          annualincome = companies[i].annualincomes.new
          for j in 0...array_of_names.length do 
            puts j, ' -- ', array_of_names[j], ' -- ', array_of_year1[j]

            annualincome[array_of_names[j].to_sym] = array_of_year1[j]
          end

          annualincome.save
          # puts 'ROWS:  ', array_of_names
          # puts 'YEAR 1:  ', array_of_year1


          # use nokogiri to get all the data that shares the common format
          # names = html_doc.css(names_format)
          # year1 = html_doc.css(year1_format)
          # year2 = html_doc.css(year2_format)
          # year3 = html_doc.css(year3_format)
          # year4 = html_doc.css(year4_format)




        end
      end
    end


  desc "Scrape companies from CSV"
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

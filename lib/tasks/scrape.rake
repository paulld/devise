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


  desc "Scrape the financials from Google Finance"
  task :get_financials => :environment do
    # In order to access a website, I need to require this
    require 'open-uri'
    # In order to scrape elements on a website, I need to require nokogiri
    require 'nokogiri'
    
    Company.all.each_with_index do |company, index|
      # if index < 300
        record_financials(company)
      # end
    end
  end


  def record_financials(company)
    # this is the format of what we want. I get this from Kimono where you have highlighted these items
    url = "http://www.google.com/finance?q="+company.symbol.upcase+"&fstype=ii"
    puts ">>> Scrapping #{company.symbol} from #{url}"
    
    # this access the site
    document = open(url).read
    # this parse the site using Nokogiri
    html_doc = Nokogiri::HTML(document)

    # columns 
    row_names = html_doc.css("div.id-incannualdiv > table.gf-table.rgt > tbody > tr > td.lft.lm")
    # data
    data_structure = [
      "div.id-incannualdiv > table.gf-table.rgt > thead > tr > th",                  # first row (currency, dates)
      "div.id-incannualdiv > table.gf-table.rgt > tbody > tr > td:nth-child(2).r",   # Year 1
      "div.id-incannualdiv > table.gf-table.rgt > tbody > tr > td:nth-child(3).r",   # Year 2
      "div.id-incannualdiv > table.gf-table.rgt > tbody > tr > td:nth-child(4).r",   # Year 3
      "div.id-incannualdiv > table.gf-table.rgt > tbody > tr > td.r.rm"              # Year 4
    ]

    details = html_doc.css("div.id-incannualdiv > table.gf-table.rgt > tbody > tr > td.r.rm")

    first_row = html_doc.css(data_structure[0])
    years = 1...first_row.length
    years.each do |year|
      data = html_doc.css(data_structure[year])

      if not data.any?
        puts "No data for year #{year}"
        return
      end
      # puts first_row[0].text.match( /(In).*(\))/ )
      puts "Recording year #{year}"

      new_record = company.annualincomes.new

      Annualincome.columns[4..52].each_with_index do |column, index|
        new_record["#{column.name}"] = data[index].text
      end
      new_record["currency"] = first_row[0].text.match( /(In).*(\))/ ).to_s
      new_record["period"] = "#{first_row[year].text.match( /[\d]+[-][\d]+[-][\d]+/ )} 12:0:00.000000000 Z"
      new_record.save
    end
    puts "Done"
  end



  desc "Scrape companies from CSV"
  task :make_companies => :environment do
    require 'open-uri'
    require 'csv'

    url = "http://s3.amazonaws.com/nvest/nasdaq_09_11_2014.csv"

    url_data = open(url)

    CSV.foreach(url_data) do |symbol, name|
      # puts "#{name}: #{symbol}" unless name == "Name"
      Company.create(:name => name, :symbol => symbol, :stock_exchange => "NASDAQ") unless symbol == "Symbol"
    end
    puts "done scrapping"
  end

end

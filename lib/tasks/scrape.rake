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
    
    
    Company.all.each_with_index do |company, index|
      if index == 190
        record_financials(company)
      end
    end
  end

  def record_financials(company)
    # this is the format of what we want. I get this from Kimono where you have highlighted these items
    puts company.symbol
    url = "http://www.google.com/finance?q="+company.symbol.upcase+"&fstype=ii"
    puts url
    puts company.symbol
    
    # this access the site
    document = open(url).read
    # this parse the site using Nokogiri
    html_doc = Nokogiri::HTML(document)

    # columns 
    row_names = html_doc.css("div.id-incannualdiv > table.gf-table.rgt > tbody > tr > td.lft.lm")
    header = html_doc.css("div.id-incannualdiv > table.gf-table.rgt > thead > tr > th")
    year1 = html_doc.css("div.id-incannualdiv > table.gf-table.rgt > tbody > tr > td:nth-child(2).r")
    year2 = html_doc.css("div.id-incannualdiv > table.gf-table.rgt > tbody > tr > td:nth-child(3).r")
    year3 = html_doc.css("div.id-incannualdiv > table.gf-table.rgt > tbody > tr > td:nth-child(4).r")
    year4 = html_doc.css("div.id-incannualdiv > table.gf-table.rgt > tbody > tr > td.r.rm")

    details = html_doc.css("div.id-incannualdiv > table.gf-table.rgt > tbody > tr > td.r.rm")
    # puts header[4].text.split("52 weeks ending ")
    # return 


    if not year4.any?
      return
    end

    new_record = company.annualincomes.new

    Annualincome.columns[4..52].each_with_index do |column, index|
      new_record["#{column.name}"] = year4[index].text
    end
    new_record["period"] = "#{header[4].text.match( /[\d][\d][\d][\d]-[\d][\d]-[\d][\d]/ )} 12:0:00.000000000 Z"
    # year = "#{header[4].text[].split("52 weeks ending ")} 12:0:00.000000000 Z"
    # puts header
    # puts header[4].text
    # puts + " 12:0:00.000000000 Z"
    # return
    new_record.save
  end

  def get_periods(header)
    periods = []
    [1..4].each do |i|
      date = header[4].text.split("52 weeks ending ").split("-")

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
      Company.create(:name => name, :symbol => symbol, :stock_exchange => "NASDAQ") unless symbol == "Symbol"
    end
    puts "done scrapping"
  end

end

namespace :scrape_flights do 
  
  desc "Scraping list of Airlines"
  task :get_airlines => :environment do
    
    require 'open-uri'
    require 'nokogiri'

    url = "http://www.flightradar24.com/data/airplanes/"
    document = open(url).read
    html_doc = Nokogiri::HTML(document)
    
    data_format_codes = "ul#airlineList > li"
    data_format_link  = "ul#airlineList > li > a"
    data_format_name  = "ul#airlineList > li > a > div > span.operator"

    html_doc.css(data_format_codes).each_with_index do |foo, index|
      iata_code = html_doc.css(data_format_codes)[index]['data-iata'].squish

      if Airline.find_by(:iata => iata_code)
        puts "#{iata_code} was already done."
      else
        new_airline = Airline.new
        new_airline["name"] = html_doc.css(data_format_name)[index].text
        new_airline["iata"] = iata_code
        new_airline["icao"] = html_doc.css(data_format_codes)[index]['data-icao'].squish
        new_airline["url"] = "http://www.flightradar24.com" + html_doc.css(data_format_link)[index]['href']
        new_airline.save
        puts "Done #{index+1} (#{new_airline["name"]})"
      end
    end
  end


  desc "Scraping list of Planes"
  task :get_planes_codes => :environment do
    
    require 'open-uri'
    require 'nokogiri'

    Airline.all.each_with_index do |airline, index|
      if index < 200    # ONLY SCRAPE THE FIRST 200!!
        document = open(airline.url).read
        html_doc = Nokogiri::HTML(document)

        data_format_code = "ul#listAircrafts > li > a > p" # Airplane registration codes

        html_doc.css(data_format_code).each do |code|
          airline.airplanes.create(:registration_code => code.text.squish)
        end
        puts "Done #{index+1} (#{airline.name})"
      end
    end
  end


  desc "Scraping Plane data"
  task :get_planes_data => :environment do
    
    require 'open-uri'
    require 'nokogiri'

    Airplane.all.each_with_index do |plane, index|
      url = "http://www.flightradar24.com/data/airplanes/" + plane.registration_code
      puts url
      document = open(url).read
      html_doc = Nokogiri::HTML(document)

      data_format_info1 = "#cntAircraftDetails > div > dl > dd:nth-of-type(1)" # ModeS
      data_format_info3 = "#cntAircraftDetails > div > dl > dd:nth-of-type(3)" # Type Code
      data_format_info4 = "#cntAircraftDetails > div > dl > dd:nth-of-type(4)" # Type
      data_format_info5 = "#cntAircraftDetails > div > dl > dd:nth-of-type(5)" # S/N

      plane.update_attributes(
        :mode_s => html_doc.css(data_format_info1).text,
        :plane_type_code => html_doc.css(data_format_info3).text,
        :plane_type => html_doc.css(data_format_info4).text,
        :s_n => html_doc.css(data_format_info5).text
      )
      puts "Done #{index+1} (#{plane.registration_code})"
    end
  end

end

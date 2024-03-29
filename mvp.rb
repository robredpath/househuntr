#!/usr/bin/env ruby

require 'sinatra'
require 'csv'
require 'pp'
require 'net/http'
require 'json'
require 'erubis'


post '/' do

	output = ""

	# define some data structures

	# grab the data from the POST request

	# build up the query

	# Do initial search based on geographic data, price banding, all the easy stuff

	# MOCKUP - load sample csv from disk
	properties = CSV.read("properties.csv")
	tramstops = CSV.read("tramstops.csv")

	# TODO - grab data from external data source and parse for important values

	# is there an 'x distance from a tram stop' type query? 
	# MOCKUP - let's assume yes, and let's assume it's just the one tram stop and 3 mins walk

	output_properties = []
	simple_search_data.each do |property|

		# Get the tram stops
		trams_in_query = ""
		tramstops.each do |stop|
			trams_in_query << stop[0] 
		end

		# Ask Google how far it is to each of them
		uri = URI("https://maps.googleapis.com/maps/api/distancematrix/json?mode=walking&origins=#{property[1]}&destinations=#{trams_in_query}&key=AIzaSyBz0ZEOpH17m35flnCwMrkei1xHlWgZohQ")
		Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|   
			request = Net::HTTP::Get.new uri
			response = http.request request # Net::HTTPResponse object 

			tramstops_from_property = tramstops
			gmaps_data = JSON.parse(response.body)["rows"].first["elements"]

			gmaps_data.each do |dest|
				duration = dest["duration"]["text"].split(" ")[0]
				properties[gmaps_data.index(dest)] << duration
			end

			output_properties << {
				price: property[0],
				postcode: property[1],
				description: property[2],
				tram_walk_time: duration
			}
		end 
	end

	# if so => grab additional data from google maps API
	# is there an 'x distance from the motorway' type query?

	# if so => grab additional data from google maps API

	# filter results according to google maps data
	
	# build up the new filter list
	filters = params.select { |k,v| /^filter/.match(k) }

	new_filter_label = params[:new_filter_type].to_sym
	new_filter_value = params[:new_filter_time]

	filters[new_filter_label] = new_filter_value

	# present results
	# => If there's no existing request, give the empty page
	# => if there is an existing request, display it with the ability to add another item the query

	results = []
	properties.each do |property|
		logger.info property.pretty_inspect
		if property[:tram_walk_time] < filters[:filter_tram]
			results.push property
		end
	end

	template = File.read('form.erb')
	eruby = Erubis::Eruby.new(template)
	eruby.result(filters: filters, properties: results)

end


get '/' do

	# send the form
	template = File.read('form.erb')
	eruby = Erubis::Eruby.new(template)
	filters = {
		filter_city: "Nottingham",
		filter_min_value: "150000",
		filter_max_value: "180000"
	}
	eruby.result("filters" => filters)

end
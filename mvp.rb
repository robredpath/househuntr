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
	#simple_search_data = CSV.read("sampledata.csv")

	# TODO - grab data from external data source and parse for important values

	# is there an 'x distance from a tram stop' type query? 
	# MOCKUP - let's assume yes, and let's assume it's just the one tram stop and 3 mins walk

	#from_tram_stop = "Nottingham%20Trent%20University%20Tram%20Stop"

	#simple_search_data.each do |property|
	#	uri = URI("https://maps.googleapis.com/maps/api/distancematrix/json?mode=walking&origins=#{property[1]}&destinations=#{from_tram_stop}&key=AIzaSyBz0ZEOpH17m35flnCwMrkei1xHlWgZohQ")
#
#		Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|   
#			request = Net::HTTP::Get.new uri
#			response = http.request request # Net::HTTPResponse object 
#			duration = JSON.parse(response.body)["rows"].first["elements"].first["duration"]["text"] 
#			output.concat "#{property[2]} in #{property[1]} for £#{property[0]} and #{duration} mins walk from trent tram stop<br />"
#		end 
#	end

	# if so => grab additional data from google maps API
	# is there an 'x distance from the motorway' type query?

	# if so => grab additional data from google maps API

	# filter results according to google maps data
	
	# build up the new filter list
	#filters = params.select { |k,v| /^filter/.match(k) }

	"I got #{params['filter_city']}"


	# present results
	# => If there's no existing request, give the empty page
	# => if there is an existing request, display it with the ability to add another item the query


end


get '/' do

	# send the form
	template = File.read('form.erb')
	eruby = Erubis::Eruby.new(template)
	filters = [
		{ 	label: "city",
			value: "Nottingham"
		},
		{ 	label: "min_value",
			value: "150000"
		},		
		{ 	label: "max_value",
			value: "180000"
		}
	]
	eruby.result("filters" => filters)

end
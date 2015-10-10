#!/usr/bin/env ruby

require 'sinatra'
require 'csv'
require 'pp'
require 'net/http'

get '/' do

	output = ""

	# define some data structures


	# grab the data from the POST request

	# build up the query

	# Do initial search based on geographic data, price banding, all the easy stuff

	# MOCKUP - load sample csv from disk
	simple_search_data = CSV.read("sampledata.csv")

	# TODO - grab data from external data source and parse for important values

	# is there an 'x distance from a tram stop' type query? 
	# MOCKUP - let's assume yes, and let's assume it's just the one tram stop and 3 mins walk

	from_tram_stop = "Nottingham%20Trent%20University%20Tram%20Stop"

	simple_search_data.each do |property|
		url = URI.parse("https://maps.googleapis.com/maps/api/directions/json?origin=#{property[1]}&destination=#{from_tram_stop}&key=AIzaSyBz0ZEOpH17m35flnCwMrkei1xHlWgZohQ")
		#req = Net::HTTP::Get.new(url.to_s)
		#res = Net::HTTP.start(url.host, url.port) {|http|
 		# http.request(req)
		#}

		output.concat url
	end

	# if so => grab additional data from google maps API

	# is there an 'x distance from the motorway' type query?

	# if so => grab additional data from google maps API

	# filter results according to google maps data
	output 
	# present results
	# => If there's no existing request, give the empty page
	# => if there is an existing request, display it with the ability to add another item the query

end
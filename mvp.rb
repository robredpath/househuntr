#!/usr/bin/ruby

#use csv
use pp 
use cgi

# define some data structures

class Property
	def initialize(price,postcode,description)
		@price = price
		@postcode = postcode
		@description = description
	end
end


# grab the data from the POST request

# build up the query

# Do initial search based on geographic data, price banding, all the easy stuff

# MOCKUP - load sample csv from disk
simple_search_data = CSV.read("~/public_html/househuntr/sampledata.csv")

# TODO - grab data from external data source and parse for important values

# is there an 'x distance from a tram stop' type query? 
# MOCKUP - let's assume yes, and let's assume it's just the one tram stop and 3 mins walk

simple_search_data.each do |property|
 pp property
end

# if so => grab additional data from google maps API

# is there an 'x distance from the motorway' type query?

# if so => grab additional data from google maps API

# filter results according to google maps data

# present results

# => If there's no existing request, give the empty page
# => if there is an existing request, display it with the ability to add another item the query

cgi.out() do
  cgi.html() do
  
  end
end
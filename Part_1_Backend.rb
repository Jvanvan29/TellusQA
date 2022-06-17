#################################################
#
# This assignment is for back-end testing in Ruby
#
# Complete the following goals using Ruby
#
# Perform the following on GIPHY 
# 1. Search request, Specific query, Offset and limit for Pagination
# 2. Verify response is correct
#
###############################################

#Required Libraries
require 'net/http'
require 'json'

########################################
#
#         Methods For Testing
#
########################################

########################################
# Create API url link by verifying the parameters for the request
# Params: 
# Search is for parameter q :String
# offset_value is for parameter offset :Int
# limit_value is for parameter limit :Int
#

def call_api_request(search, offset_value, limit_value)
    #Intializing parameter values
    if verify_q_is_string(search) && verify_limit_is_int(offset_value) && verify_offset_is_int(limit_value)
        #Add api_key and parameters after search with "?"
        url_string = "https://api.giphy.com/v1/gifs/search?api_key=ysudxz9vLhUna6pucz1DFZNLBV4WIwBe&q=#{search}&offset=#{offset_value}&limit=#{limit_value}"
        puts "API url created successfully!"
    else  
        url = ""
        puts "Something went wrong. API url was not created. URL is empty"
    end
    return url_string
end

#########################################
# Test the response value recieved from API call to GIPHY
# Params:
# response_status is for the status that is returned for API request :Int
#

def test_response_status(response_status)
    case response_status
    when 200
        puts "Your Request Was Successful! code #{response_status}"
    when 400
        puts "Bad Request code #{response_status}- Your request was formattd incorrectly or missing a parameter(s)"
    when 403
        puts "Forbidden code #{response_status}- You weren't authorized to make your request; most likely this indicates an issue with your API Key."
    when 404
        puts "Not Found code #{response_status}- The particular GIF or Sticker you are requesting was not found. This occurs, for example, if you request a GIF by using an id that does not exist."
    when 414
        puts "URI Too Long #{response_status}- The length of the search query exceeds 50 characters."
    when 429
        puts "Too Many Requests #{response_status}- Your API Key is making too many requests. Read about requesting a Production Key to upgrade your API Key rate limits."
    end
end

##########################################
# Test to see if the user offset values match the returned offset value
# Params:
# response_offset is for the offset that is returned from the request :Int
# user_offset is for the offset that is entered from the user :Int
# 

def test_offset(response_offset, user_offset)
    if response_offset == user_offset
        puts "Offset is exactly what the user wanted! Offset:#{response_offset}"
    else
        puts "The Offset values do not match. The user wanted #{user_offset} and the response sent #{response_offset}"
    end
end

##########################################
# Test to see if the user pagination values match the returned pagination value
# Params:
# response_limitt is for the offset that is returned from the request :Int 
# user_limit is for the offset that is entered from the user :Int
#

def test_pagination(response_limit, user_limit)
    if response_limit == user_limit
        puts "Pagination is exactly what the user wanted! count:#{response_limit}"
    else
        puts "The pagination values do not match. The user wanted #{user_limit} and the response sent #{response_limit}"
    end
end

##########################################
# Test to make sure q is a string before used as a parameter for API request
# Params:
# Search is for the parameter q :String
#

def verify_q_is_string(search)
    if search.is_a? String
        puts "q is verified as an String!"
        return true
    else
        puts "Something is wrong. Search needs to be a string"
        
    end
    return false
end

##########################################
# Test to make sure offset is an Int before used as a parameter for API request
# Params:
# value is for the parameter value :Int
#

def verify_offset_is_int(value)
    if value.is_a? Integer
        puts "Offset is verified as an Int!"
        return true
    else 
        puts "Something is wrong. Offset needs to be an Int"
    end
    return false
end

##########################################
# Test to make sure limit is an Int before used as a parameter for API request
# Params:
# value is for the parameter limit :Int
#

def verify_limit_is_int(value)
    if value.is_a? Integer
        puts "Limit is verified as an Int!"
        return true
    else 
        puts "Something is wrong. Limit needs to be an Int"
    end
    return false
end

############################################
#
#       Script Starts Here
#
############################################

########################################
#
# Parameters used in API-
#
#q: Name for query that you are searching for Ex: Pizza, The Office, SpongeBob
#offset: The index position/starting point for list of gifs
#limit: The limit of GIFs shown per page (Pagination)
#API KEY: this is used to communicate with the server by sending a GET request 
#
########################################

#HERE - Intialize parameter values for API request through these methods

q = "cats"
offset = 6
limit = 15

#Intialize API URL here
url = call_api_request(q, offset, limit)

#Return the API response and parse through it to format into JSON
uri = URI(url)
response = Net::HTTP.get_response(uri)
json = JSON.parse(response.body)

#Using JSON return response values and store in variables
status = json["meta"]["status"]
pagination = json["pagination"]["count"]
returned_offset = json["pagination"]["offset"]

#Calling the test methods are here
test_response_status(status)
test_offset(returned_offset,offset)
test_pagination(pagination, limit)
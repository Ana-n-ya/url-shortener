# README

# URL Shortener

URL Shortener is a simple web application built with Ruby on Rails that allows you to shorten long URLs into shorter, more manageable ones.

## Features

- Shorten long URLs into shorter, customized URLs
	You can make a POST call using
	URL - http://localhost:3000/urls
	Params- 
	{
	  "url": {
	    "original_url": "https://example.com"
	  }
	}
	
	Original URL need to be in correct format and a valid URL

- Redirect shortened URLs to their original long URLs
	You can make a GET call using 
	URL - http://localhost:3000/short_code
	This is the short code which was generated in the above POST call

- View a list of all generated URLs
	You can make a get call for index using
	URL - http://localhost:3000/urls

	We have Authentication (Basic) for all APIs
	Username - "hello"
	Password - 123 #Only for local use

## Prerequisites

Make sure you have the following installed on your local machine:

- Ruby [3.0.2]
- Ruby on Rails [7.0.5]
- PostgreSQL [14.8]

## Installation

1. Clone the repository:
   git clone [repository_url]

2. Navigate to the project directory:
	cd url-shortener

3. Install the required dependencies:
	bundle install

4. Create and migrate the database:
	rails db:create
	rails db:migrate

5. Start the Rails server:

	rails server
Open your web browser and visit http://localhost:3000.

Use the following endpoints to interact with the URL Shortener:

POST /urls: Create a new shortened URL.
GET /urls: View a list of all generated URLs.
GET /:short_code: Redirect to the original URL associated with the provided short code.
Configuration
The configuration options for the URL Shortener can be found in the config/application.rb file.

Security
To enhance security, the URL Shortener implements the following measures:

Basic authentication: Users are required to provide a username and password to access the application functionality.
Input validations: The application validates the format and presence of URLs to ensure only valid URLs are accepted.
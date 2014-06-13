require 'sinatra'

configure do 
	enable :sessions
end

get '/' do
	erb :index
end

get '/new' do
	erb :new
end

post '/new' do
end

class Person
	def initialize (name,url,description=nil)
		@name = name.to_s
		@url = url.to_s
		@description = description.to_s
	end

	attr_accessor :name, :url, :description

end

class Deck
	def initialize (setname,setpeople=[],setdescription)
		@setname = setname.to_s
		@setpeople = setpeople
		@setdescription = setdescription.to_s
	end

	attr_accessor :setname, :setdescription, :setpeople

	def add_person (name,url,description=nil)
		@setpeople.push(Person.new(name,url,description))
	end

	def delete_person (name)
		@setpeople.delete_if {|n| n.name == name}
	end

end

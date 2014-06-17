require 'sinatra'

configure do 
	enable :sessions
end

session = {}
session['alldecks'] = []

get '/' do
	erb :index
end

get '/results' do
	erb :results
end

get '/newdeck' do
	erb :newdeck
end

post '/newdeck' do
	params[:deckname] = Deck.new(params[:deckname], [], params[:deckdescription])
	# newdeck.add_person(params[:name], params[:photourl], params[:description])
	session['alldecks'] << params[:deckname]
	erb :results, :locals => {:alldecks => session['alldecks']}
	redirect '/results'
end

get '/:deckname/newperson' do
	erb :newperson
end

get '/newperson' do
	erb :newperson
end

post '/:deckname/newperson' do
	deckname = params[:deckname]
	newperson = Person.new(params[:name],params[:photourl],params[:description])
	deckname.add_person(newperson)
	erb :results, :locals => {:alldecks => session['alldecks']}
	redirect '/results'
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
	def initialize (deckname,deckpeople=[],deckdescription)
		@deckname = deckname.to_s
		@deckpeople = deckpeople
		@deckdescription = deckdescription.to_s
	end

	attr_accessor :deckname, :deckdescription, :deckpeople

	def add_person (person)
		@deckpeople.push(person)
	end

	def delete_person (name)
		@deckpeople.delete_if {|n| n.name == name}
	end

end

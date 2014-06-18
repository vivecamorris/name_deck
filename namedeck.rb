require 'sinatra'
require_relative 'decks'

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

post '/test' do
	if params[:nameinput] == params[:correctname]
		erb :correct
	else
		erb :incorrect
	end
end

def get_random_photo(deckpeople)
	successful = false
	while successful == false
		num = rand(deckpeople.length)
		persontobequizzed = deckpeople[num]
			if persontobequizzed.quizzed == false
				persontobequizzed.quizzed = true
				successful = true
				return persontobequizzed
			end
	end
end

get '/test' do
	bootcampdeck = session['alldecks'].find{|a| a.deckname == "Tech Bootcamp 2014"}
	randomperson = get_random_photo(bootcampdeck.deckpeople)
	erb :test, :locals => { :randomperson => randomperson}
end

get '/:deckname/newperson' do
	erb :newperson
end

get '/display' do
	bootcampdataobj = BootcampData.new
	session['alldecks'] << bootcampdataobj.bootcamp
	erb :display, :locals => { :bootcamp => session['alldecks'].find{|a| a.deckname == "Tech Bootcamp 2014"} }
end

post '/newdeck' do
	params[:deckname] = Deck.new(params[:deckname], [], params[:deckdescription])
	newdeck.add_person(params[:name], params[:photourl], params[:description])
	session['alldecks'] << params[:deckname]
	erb :results, :locals => {:alldecks => session['alldecks']}
	redirect '/results'
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



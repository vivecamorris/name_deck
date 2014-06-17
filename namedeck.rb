require 'sinatra'
require_relative 'decks'

configure do 
	enable :sessions
end


session = {}
session['alldecks'] = []

get '/' do
	bootcampdataobj = BootcampData.new
	puts bootcampdataobj.bootcamp
	erb :index, :locals => { :bootcamp => bootcampdataobj.bootcamp }
end

get '/results' do
	erb :results
end

get '/newdeck' do
	erb :newdeck
end

post '/newdeck' do
	params[:deckname] = Deck.new(params[:deckname], [], params[:deckdescription])
	newdeck.add_person(params[:name], params[:photourl], params[:description])
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



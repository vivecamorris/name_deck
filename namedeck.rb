require 'sinatra'
require 'pry'
require_relative 'decks'

configure do 
	enable :sessions
end

before do
	session['alldecks'] ||= []
	unless session['alldecks'].any?{|deck| deck.deckname == "Tech Bootcamp 2014"}
		bootcampdataobj = BootcampData.new
		session['alldecks'] << bootcampdataobj.bootcamp
	end
end

get '/' do
	erb :index
end

get '/gallery' do
	erb :gallery, :locals => { :alldecks => session['alldecks'] }
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
		erb :incorrect, :locals => {:nameinput => params[:nameinput],
									:correctname => params[:correctname],
									:bootcamp => session['alldecks'].find{|a| a.deckname == "Tech Bootcamp 2014" } }
	end
end

# def get_random_photo(deckpeople)
# 	notquizzed = deckpeople.find_all{ |person| person.quizzed == false }
# 	if notquizzed != []
# 		num = rand(notquizzed.length)
# 		persontobequizzed = notquizzed[num]
# 		return persontobequizzed
# 	else
# 		return "done"
# 	end
# end

get '/test' do
	# bootcampdeck = session['alldecks'][0]
	# find{|a| a.deckname == "Tech Bootcamp 2014"}

	# Alias the slides that people have not viewed yet into 'notquizzed'
	notquizzed = session['alldecks'][0].deckpeople.find_all{ |person| person.quizzed == false }

	if notquizzed != []
		# Choose a random person to be quizzed from 'notquizzed'
		num = rand(notquizzed.length)
		persontobequizzed = notquizzed[num]

		# 
		isthisquizzed = session['alldecks'][0].deckpeople.find{ |x| x.name == persontobequizzed.name}
		isthisquizzed.quizzed = true
		erb :test, :locals => { :randomperson => persontobequizzed }
	else
		erb :done
	end
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



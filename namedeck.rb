require 'sinatra'
require 'pry'
require_relative 'decks'

configure do 
	use Rack::Session::Pool
end

before do
	session['alldecks'] ||= []
	unless session['alldecks'].any?{|deck| deck.deckname == "Tech Bootcamp 2014" || "YEI Fellowship Teams"}
		bootcampdataobj = BootcampData.new
		fellowsdataobj = YEIFellowsData.new
		session['alldecks'].push(bootcampdataobj.bootcamp, fellowsdataobj.fellows)
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

post '/fellowstest' do
	if params[:nameinput] == params[:correctname]
		erb :fellowscorrect 
	else
		erb :fellowsincorrect, :locals => {:nameinput => params[:nameinput],
									:correctname => params[:correctname],
									:fellows => session['alldecks'].find{|a| a.deckname == "YEI Fellowship Teams" } }
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
		erb :test, :locals => { :randomperson => persontobequizzed,
								:numleft => notquizzed.length,
								:numtotal => session['alldecks'][0].deckpeople.length }
	else
		session.clear
		erb :done
	end
end

get '/fellowstest' do

	# Alias the slides that people have not viewed yet into 'notquizzed'
	notquizzedfellows = session['alldecks'][1].deckpeople.find_all{ |person| person.quizzed == false }

	if notquizzedfellows != []
		# Choose a random person to be quizzed from 'notquizzed'
		numfellows = rand(notquizzedfellows.length)
		persontobequizzedfellows = notquizzedfellows[numfellows]

		# 
		isthisquizzedfellows = session['alldecks'][1].deckpeople.find{ |x| x.name == persontobequizzedfellows.name}
		isthisquizzedfellows.quizzed = true
		erb :fellowstest, :locals => { :randomfellow => persontobequizzedfellows,
								:numleftfellows => notquizzedfellows.length,
								:numtotalfellows => session['alldecks'][1].deckpeople.length }
	else
		session.clear
		erb :fellowsdone
	end
end


get '/:deckname/newperson' do
	erb :newperson
end

get '/display' do
	erb :display, :locals => { :bootcamp => session['alldecks'].find{|a| a.deckname == "Tech Bootcamp 2014"} }
end

get '/fellowsdisplay' do
	erb :fellowsdisplay, :locals => { :fellows => session['alldecks'].find{|a| a.deckname == "YEI Fellowship Teams"} }
end

post '/newdeck' do
	# params[:deckname] = Deck.new(params[:deckname], [], params[:deckdescription])
	# params[:deckname].add_person(params[:name], params[:photourl], params[:description])
	# session['alldecks'] << params[:deckname]
	# erb :results, :locals => {:alldecks => session['alldecks']}
	erb :newperson
end

get '/newperson' do
	erb :newperson
end

post '/newperson' do
	redirect '/'
end

post '/:deckname/newperson' do
	deckname = params[:deckname]
	newperson = Person.new(params[:name],params[:photourl],params[:description])
	deckname.add_person(newperson)
	erb :results, :locals => {:alldecks => session['alldecks']}
	redirect '/results'
end



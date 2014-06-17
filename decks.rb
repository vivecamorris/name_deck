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

	def add_person (name, photo, description)
		person = Person.new(name, photo, description)
		@deckpeople.push(person)
	end

	def delete_person (name)
		@deckpeople.delete_if {|n| n.name == name}
	end

end

class BootcampData
	def initialize
		@bootcamp = Deck.new("Tech Bootcamp 2014", [], "Code Monkeys")
		@bootcamp.add_person("Viveca Morris", "photos/viveca_morris.jpg", "Stiles 2015")
		@bootcamp.add_person("Tim Follo", "photos/tim_follo.jpg", "Morse 2016")
		@bootcamp.add_person("Paul Styslinger", "photos/paul_styslinger.jpg", "Stiles 2017")
		@bootcamp.add_person("Patrick Casey", "photos/patrick_casey.jpg", "Saybrook 2015")
		@bootcamp.add_person("Andres Vargas", "photos/andres_vargas.jpg", "Calhoun 2017")
		@bootcamp.add_person("E-lynn Yap", "photos/elynn_yap.jpg", "Timothy Dwight 2014")
		@bootcamp.add_person("Taylor Stibs", "photos/taylor_stibs.jpg", "Branford 2015")
		@bootcamp.add_person("Natalia Castillejo Arias", "photos/natalia_castillejo.jpg", "JE 2016")
		@bootcamp.add_person("David Liu", "photos/david_liu.jpg", "Berkeley 2017")
		@bootcamp.add_person("Nikki Feldman", "photos/nikki_feldman.jpg", "Davenport 2014")
		@bootcamp.add_person("Loide Marwanga", "photos/loide_marwanga.jpg", "School of Art 2015")
		@bootcamp.add_person("Jay Hou", "photos/jay_hou.jpg", "Trumbull 2017")
		@bootcamp.add_person("Sonja Peterson", "photos/sonja_peterson.jpg", "Davenport 2014")
		@bootcamp.add_person("Caroline Posner", "photos/caroline_posner.jpg", "Berkeley 2017")
		@bootcamp.add_person("Aily Zhang", "photos/aily_zhang.jpg", "Silliman 2015")
		@bootcamp.add_person("Aileen Huang", "photos/aileen_huang.jpg", "Berkeley 2017")
		@bootcamp.add_person("Rachel Prince", "photos/rachel_prince.jpg", "Davenport 2017")
		@bootcamp.add_person("Phil Esterman", "photos/phil_esternman.jpg", "Branford 2017")
		@bootcamp.add_person("Ben Burke", "photos/ben_burke.jpg", "Pierson 2015")
		@bootcamp.add_person("Amy Rockwood", "photos/amy_rockwood.jpg", "Berkeley 2016")
		@bootcamp.add_person("Natalia Bueno", "photos/natalia_bueno.jpg", "GSAS 2017")
		@bootcamp.add_person("Joe Calamia", "photos/joe_calamia.jpg", "Forestry 2015")
		@bootcamp.add_person("Zach Young", "photos/zach_young.jpg", "Silliman 2017")
		@bootcamp.add_person("David McPeek", "photos/david_mcpeek.jpg", "Berkeley 2016")
		@bootcamp.add_person("Sahil Gupta", "photos/sahil_gupta.jpg", "Saybrook 2017")
		@bootcamp.add_person("Henok Addis", "photos/henok_addis.jpg", "Stiles 2017")
		@bootcamp.add_person("Jason Kim", "photos/jason_kim.jpg", "Silliman 2016")
		@bootcamp.add_person("Charlie Proctor", "photos/charlie_proctor", "TD 2017")
		@bootcamp.add_person("Marcus Russi", "photos/marcus_russi.jpg", "Branford 2017")
		@bootcamp.add_person("Casey Watts", "photos/casey_watts.jpg", "Yale ITS")
		@bootcamp.add_person("Sara Hamilton", "photos/sara_hamilton.jpg", "Stiles 2@016")
	end
	attr_reader :bootcamp
end




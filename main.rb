require "pry"
require "csv"

@people = {}

CSV.foreach("accounts.csv", {headers: true, return_headers: false}) do |row|
	@people[row["Account"].chomp.to_sym] = {}

end

CSV.foreach("accounts.csv", {headers: true, return_headers: false}) do |row|
	@people[row["Account"].chomp.to_sym][row["Category"].chomp.to_sym] = []
end

CSV.foreach("accounts.csv", {headers: true, return_headers: false}) do |row|
	account = row["Account"].chomp.to_sym
	category = row["Category"].chomp.to_sym
	outflow = - row["Outflow"].gsub("$", "").gsub(",","").to_f
	inflow = row["Inflow"].gsub("$","").gsub(",","").to_f
@people[account][category] << outflow + inflow
end

amount = 0
@people[account][category].each {|amount| += amount}

binding.pry

puts "nil"


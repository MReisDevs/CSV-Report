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

def categoryTotal (account, category)
	total = @people[account][category].sum
	total.round(2)
end 

def categoryAverage (account, category)
	categoryTotal(account, category) / @people[account][category].length 
	total.round(2)
end

def categoryBal (account, category)
	
end

binding.pry

puts "nil"


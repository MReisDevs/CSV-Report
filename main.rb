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
	total = @people[account][category].sum.round(2)
end 

def categoryAverage (account, category)
	categoryTotal(account, category) / @people[account][category].length 
	total.round(2)
end

def TotalBal(account)
	total = 0 
	@people[account].each_key {|key| total += categoryTotal(account, key) } 
	total.round(2)
end

account = gets.chomp.capitalize.to_sym
if account == :Priya
	puts TotalBal(account)
else
	puts "Please try another account"
end

binding.pry

puts "placeholder for prying deeper into the depths of our misfortunes \n Abandon all hope \n ye who debug here!"


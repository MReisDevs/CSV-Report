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



def nextprompt(account)
	puts "What would you like to view next?\nFor Account Overview type 'Overview'\nFor Category Details type 'Category'\n To Exit type 'Exit' "
	choice = gets.chomp.capitalize
	if choice == "Overview"
		puts "This is a placeholder but your total balance is #{TotalBal(account)}"
	elsif choice == "Category"
		puts "Some sort of magic category info here"
	elsif choice == "Exit"
		puts "Goodbye! Have a great day!"
	else
		puts "Mistakes were made, please try again"
		puts nextprompt(account)
	end
end


puts "What is your name on account?"
account = gets.chomp.capitalize.to_sym
if @people.include?(account)
	puts "Welcome #{account}!\nHere is your overall balance: $ #{TotalBal(account)}\n===============================================\n"
	puts nextprompt(account)

else
	puts "Please try another account"
end

binding.pry 

#
#


puts "Pry Placeholder \n Abandon all hope \n ye who debug here!"


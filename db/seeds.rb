Villa.destroy_all

location = ["Chennai", "Bangalore", "Hydrabad", "Mumbai", "Ooty", "Kodaikanal"]
available = [true, false]
default_cin = DateTime.now.beginning_of_year
default_cout = DateTime.now.end_of_year
default_days = [4,5,6,7]
price = [7499, 7200, 6700, 6800, 7129, 6999, 7225]

50.times do |no|
	per_night = price.sample
	check_in = Time.at((default_cout.to_f - default_cin.to_f)*rand + default_cin.to_f)
	
	year = check_in.strftime('%Y')
	month = check_in.strftime('%m')
	date = check_in.strftime('%d')
	
	check_out = DateTime.new(year.to_i, month.to_i, date.to_i, 11)+(default_days.sample).days
	
	amt_to_stay = (per_night * (check_out.to_date - check_in.to_date).to_i)
	include_gst = (amt_to_stay * 18/100)
 
	Villa.create({
		name: Faker::Name.name,
		price: per_night,
		location: location.sample,
		address: Faker::Address.street_address,
		is_available: available.sample,
		check_in: check_in,
		check_out: check_out,
		adults_count: default_days.sample,
		total_amount: amt_to_stay+include_gst
	})
	p "#{no} executed!!!"
end
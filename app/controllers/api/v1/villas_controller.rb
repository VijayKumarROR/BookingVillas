class Api::V1::VillasController < ApplicationController
	before_action :check_date, except: [:index, :available_villas]

	def index
		render json: {villas: Villa.send("#{params[:availability].eql?('true') ? 'availabilities' : params[:availability].eql?('false') ? 'non_availabilities' : 'all' }").order("price #{params[:sort_by] || 'desc'}")}
	end

	def available_villas
		render json: {names: Villa.availabilities}
	end

	def search_villas
		if params[:name]
			calculate_rate_by_name(params[:check_in], params[:check_out],params[:name])
		elsif params[:name].nil?
			search_all_villas
		end
	end

	def search_all_villas
		villas = Villa.availabilities.where('check_in <= ? AND check_out > ?', params[:check_out],params[:check_out])
		if villas.empty?
			calculate_rate(params[:check_in], params[:check_out])
		elsif villas.exists? && villas.count != Villa.availabilities.count
			calculate_rate(params[:check_in], params[:check_out], villas.pluck(:id))
		else
			render json: {error: "Currently mentioned date is filled in the #{villas.pluck(:name)}"}
		end
	end
	
	def check_date
		cout_date = params[:check_out]

		if params[:check_in].nil? || cout_date.nil?
			error = 'CheckIn/CheckOut parameter required'
			render json: {error: error}, status: 406
		elsif Date.parse(params[:check_in]) > Date.parse(cout_date)
			error = 'CheckOut Date must be greater than CheckIn'
			render json: {error: error}, status: 406
		end
	end

	def calculate_rate_by_name(cin_date, cout_date, name)
		days = get_days(cin_date, cout_date)
		villa = Villa.availabilities.find_by(name: name)
		if villa
			room_price = villa.price * days
			total_price = room_price + (room_price * 18/100)
			
			render json: {Name: villa.name, PerNight: villa.price, Location: villa.location, Address: villa.address, TotalAmount: total_price, LimitPerson: villa.adults_count}
		else
			render json: {error: 'Villa not found'}, status: 404
		end
	end

	def calculate_rate(cin_date, cout_date, non_available_ids=nil)
		days = get_days(cin_date, cout_date)
		if non_available_ids
			villas = Villa.availabilities.where.not(id: non_available_ids)
		else
			villas = Villa.availabilities
		end		
		result = []
		villas.each do |villa|
			room_price = villa.price * days
			total_price = room_price + (room_price * 18/100)
			result << {Id: villa.id, Name: villa.name, PerNight: villa.price, Location: villa.location, Address: villa.address, TotalAmount: total_price, LimitPerson: villa.adults_count}
		end
		render json: {response: result}
	end

	def get_days(cin_date, cout_date)
		return (Date.parse(cout_date).to_date - Date.parse(cin_date)).to_i
	end

end
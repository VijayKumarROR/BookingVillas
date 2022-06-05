# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Steps:

1) clone, rake db:create db:migrate db:seed
2) API to Test:
	1) http://localhost:3000/api/v1/villas
		Feature: sort_by, availability.
	2) http://localhost:3000/api/v1/villas/search_villas
		Feature: CheckIn/Checkout is required in this API, also search villas using name/without name.
	3) http://localhost:3000/api/v1/villas/available_villas
		Feature: All available villas listed in this API.
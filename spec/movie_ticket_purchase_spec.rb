##
# These tests were not written by Eric Lawler!
# I'm providing them merely to demonstrate the completeness of the movie_ticket_purchase program logic.
#
require "movie_ticket_purchase"

describe "MovieTicketPurchase" do
	it "0 tickets == $0.00" do
		purchase = MovieTicketPurchase.new(90, :tuesday, false, false)

		expect(purchase.finish).to eq(0)
	end

	it "4 x 35 year-olds, 2D, 90 minute duration, Tuesday, normal seating == $44.00" do
		purchase = MovieTicketPurchase.new(90, :tuesday, false, false)
		purchase.add_ticket(35, false)
		purchase.add_ticket(35, false)
		purchase.add_ticket(35, false)
		purchase.add_ticket(35, false)

		expect(purchase.finish).to eq(44)
	end

	it "4 x 35 year-olds, 3D, 90 minute duration, Tuesday, normal seating == $56.00" do
		purchase = MovieTicketPurchase.new(90, :tuesday, false, true)
		purchase.add_ticket(35, false)
		purchase.add_ticket(35, false)
		purchase.add_ticket(35, false)
		purchase.add_ticket(35, false)

		expect(purchase.finish).to eq(56)
	end

	it "21 x 35 year-old, 2D, 90 minute duration, Tuesday, normal seating == $126.00" do
		purchase = MovieTicketPurchase.new(90, :tuesday, false, false)

		21.times do
			purchase.add_ticket(35, false)
		end

		expect(purchase.finish).to eq(126)
	end

	it "4 x 35 year-olds, 3D, 90 minute duration, Tuesday, balcony seating == $64.00" do
		purchase = MovieTicketPurchase.new(90, :tuesday, true, true)
		purchase.add_ticket(35, false)
		purchase.add_ticket(35, false)
		purchase.add_ticket(35, false)
		purchase.add_ticket(35, false)

		expect(purchase.finish).to eq(64)
	end

	it "4 x 35 year-olds, 3D, 90 minute duration, Thursday, balcony seating == $56.00" do
		purchase = MovieTicketPurchase.new(90, :thursday, true, true)
		purchase.add_ticket(35, false)
		purchase.add_ticket(35, false)
		purchase.add_ticket(35, false)
		purchase.add_ticket(35, false)

		expect(purchase.finish).to eq(56)
	end

	it "4 x 35 year-olds, 2D, 240 minute duration, Monday, normal seating == $50.00" do
		purchase = MovieTicketPurchase.new(240, :monday, false, false)
		purchase.add_ticket(35, false)
		purchase.add_ticket(35, false)
		purchase.add_ticket(35, false)
		purchase.add_ticket(35, false)

		expect(purchase.finish).to eq(50)
	end

	it "4 x 35 year-olds, 3D, 90 minute duration, Saturday, balcony seating == $70.00" do
		purchase = MovieTicketPurchase.new(90, :saturday, true, true)
		purchase.add_ticket(35, false)
		purchase.add_ticket(35, false)
		purchase.add_ticket(35, false)
		purchase.add_ticket(35, false)

		expect(purchase.finish).to eq(70)
	end

	it "4 x 9 year-olds, 2D, 90 minute duration, Monday, normal seating == $22.00" do
		purchase = MovieTicketPurchase.new(90, :monday, false, false)
		purchase.add_ticket(9, false)
		purchase.add_ticket(9, false)
		purchase.add_ticket(9, false)
		purchase.add_ticket(9, false)

		expect(purchase.finish).to eq(22)
	end

	it "4 x 67 year-olds, 2D, 90 minute duration, Monday, normal seating == $24.00" do
		purchase = MovieTicketPurchase.new(90, :monday, false, false)
		purchase.add_ticket(67, false)
		purchase.add_ticket(67, false)
		purchase.add_ticket(67, false)
		purchase.add_ticket(67, false)

		expect(purchase.finish).to eq(24)
	end

	it "4 x 14 year-old students, 2D, 90 minute duration, Monday, normal seating == $32.00" do
		purchase = MovieTicketPurchase.new(90, :monday, false, false)
		purchase.add_ticket(14, true)
		purchase.add_ticket(14, true)
		purchase.add_ticket(14, true)
		purchase.add_ticket(14, true)

		expect(purchase.finish).to eq(32)
	end

	it "1 x each type, 2D, 90 minute duration, Monday, normal seating == $30.50" do
		purchase = MovieTicketPurchase.new(90, :monday, false, false)
		purchase.add_ticket(35, false)
		purchase.add_ticket(14, true)
		purchase.add_ticket(65, false)
		purchase.add_ticket(12, false)

		expect(purchase.finish).to eq(30.5)
	end

	it "21 x 9 year-olds, 2D, 90 minute duration, Monday, normal seating == $115.50" do
		purchase = MovieTicketPurchase.new(90, :monday, false, false)

		21.times do
			purchase.add_ticket(9, false)
		end

		expect(purchase.finish).to eq(115.50)
	end

	it "21 x 35 year-old, 2D, 90 minute duration, Thursday, normal seating == $126.00" do
		purchase = MovieTicketPurchase.new(90, :thursday, false, false)

		21.times do
			purchase.add_ticket(35, false)
		end

		expect(purchase.finish).to eq(126.00)
	end

	it "10 x 14 year-old students + 11 x 9 year-olds, 2D, 90 minute duration, Monday, normal seating == $120.50" do
		purchase = MovieTicketPurchase.new(90, :monday, false, false)

		10.times do
			purchase.add_ticket(14, true)
		end

		11.times do
			purchase.add_ticket(9, false)
		end

		expect(purchase.finish).to eq(120.50)
	end

	it "7 x each type, 3D, 240 minute duration, Thursday, balcony seating == $346.50" do
		purchase = MovieTicketPurchase.new(240, :thursday, true, true)

		7.times do
			purchase.add_ticket(35, false)
			purchase.add_ticket(14, true)
			purchase.add_ticket(65, false)
			purchase.add_ticket(12, false)
		end

		expect(purchase.finish).to eq(346.50)
	end
end

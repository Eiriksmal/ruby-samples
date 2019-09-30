# Sample Ruby projects

This is a small repo containing toy Ruby projects I've created. Some were written as part of code challenges in interview processes. The bowling project is an exception, I'm writing that to practice test-driven development in RSpec.

# Movie Tickets Exercise

## What is this?

This program calculates purchase prices for movie tickets, using a predefined series of RSpec tests. The interface and business rules for the ticket prices are detailed below. The test consisted of this readme, requiring careful scrutiny of the ticket price edge cases, and the existing RSpec tests. I wrote all the logic in `/lib/movie_ticket_purchase.rb`.

You can run the tests with a simple `rspec --format doc` from the root directory.

## Base admission rate

The Base Admission Rate cover movies to be viewed on a regular weekday (see "Special Movie Day" below), in 2D, with a length of <= 120 minutes, viewed from the main seating area (there is also a balcony seating area, which is much fancier).

- General Admission, $11.00/ticket
- Students (where 13 <= age < 64 years of age), $8.00/ticket
- Senior Citizen (65 & older), $6.00/ticket
- Children (under 13), $5.50/ticket
- Group Pricing (if 20 people or more), max base rate of $6.00/ticket (i.e. tickets for 30 children, 2D, Monday showing, 90 minutes, main seating area would cost `30 * 5.50` instead of `30 * 6.00`)

## Rate Modifications

There are some exceptional cases which can cause us to add/subtract from a ticket's price:

- If watching a 3D movie, add $3.00/ticket
- If the movie's duration is greater than 120 minutes, add $1.50/ticket
- On Special Movie Day (Thursday, but does not apply if group-pricing), subtract $2.00/ticket
- On Weekends (Saturday and Sunday), add $1.50/ticket
- If seated in the balcony area, add $2.00/ticket

## Additional Assumptions

- Movie tickets must be purchased and consumed on the same day
- All of the movie tickets for a single purchase must be for the same showing
- All of the moviegoers for a single purchase will be seated in the same area

## Predefined Interface

```ruby
class MovieTicketPurchase

  def initialize(movie_duration_minutes, day_of_week, is_balcony_seats, is_3d)

  end

  def add_ticket(viewer_age, viewer_is_student)

  end

  def finish

  end

end
```

...and is used like so:

```
p = MovieTicketPurchase.new(90, :tuesday, false, false)
p.add_ticket(35, false)
p.add_ticket(35, false)
p.add_ticket(35, false)
p.add_ticket(35, false)
p.finish() # 44.00
```

## Test Cases

- 0 tickets == $0.00
- 4 x 35 year-olds, 2D, 90 minute duration, Tuesday, normal seating == $44.00
- 4 x 35 year-olds, 3D, 90 minute duration, Tuesday, normal seating == $56.00
- 21 x 35 year-old, 2D, 90 minute duration, Tuesday, normal seating == $126.00
- 4 x 35 year-olds, 3D, 90 minute duration, Tuesday, balcony seating == $64.00
- 4 x 35 year-olds, 3D, 90 minute duration, Thursday, balcony seating == $56.00
- 4 x 35 year-olds, 2D, 240 minute duration, Monday, normal seating == $50.00
- 4 x 35 year-olds, 3D, 90 minute duration, Saturday, balcony seating == $70.00
- 4 x 9 year-olds, 2D, 90 minute duration, Monday, normal seating == $22.00
- 4 x 67 year-olds, 2D, 90 minute duration, Monday, normal seating == $24.00
- 4 x 14 year-old students, 2D, 90 minute duration, Monday, normal seating == $32.00
- 1 x each type, 2D, 90 minute duration, Monday, normal seating == $30.50
- 21 x 9 year-olds, 2D, 90 minute duration, Monday, normal seating == $115.50
- 21 x 35 year-old, 2D, 90 minute duration, Thursday, normal seating == $126.00
- 10 x 14 year-old students + 11 x 9 year-olds, 2D, 90 minute duration, Monday, normal seating == $120.50
- 7 x each type, 3D, 240 minute duration, Thursday, balcony seating == $346.50

# Bowling exercise

## What is this?
RSpec's docs start off by writing a simple test for a bowling simulator, then building out the code for the first test. Bowling has weird rules that are easy to implement, in part, but challenging to fully implement. I figure this is a good chance to think through the optimal Ruby data structures for storing frame information and tracking spares and strikes across throws.

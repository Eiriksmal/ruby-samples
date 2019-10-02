# Sample Ruby projects

This is a small repo containing toy Ruby projects I've created. Some were written as part of code challenges in interview processes. The bowling project is an exception, I'm writing that to practice test-driven development in RSpec.

## Run the tests
Clone this repo, make sure you're running at least Ruby 2.5.5 (I use rbenv to manage environments), install RSpec, and off you go!

0. `git clone https://github.com/Eiriksmal/ruby-samples.git`
1. `cd ruby-samples/`
2. `bundler install`
3. `rbenv --format doc`
4. See a bunch of green text for passing tests. 👍 

# Bowling exercise

## What is this?
RSpec's docs start off by writing a simple test for a bowling simulator, then building out the code for the first test. Bowling has weird rules that are easy to implement, in part, but challenging to fully implement. I figure this is a good chance to think through the optimal Ruby data structures for storing frame information and tracking spares and strikes across throws.

I'm not sure the code fully embodies the Ruby spirit, but I strove to purge the inevitable PHP smells from the files. It seems like it would be more Ruby to remove the parameters from `reset_frame?` and create a `strike!` and `spare!` method, but leaning on that many class variables seems very alien to me. Is that what Ruby prefers, over passing local variables into a method? Please [let me know](https://lawler.io/contact/)!

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

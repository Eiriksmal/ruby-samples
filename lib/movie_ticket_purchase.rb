class MovieTicketPurchase

  def initialize(movie_duration_minutes, day_of_week, is_balcony_seats, is_3d)
    @price_modifiers = 0
    @tickets_sold = []
    @is_thursday = false

    # save the initial parameters that effect this movie's price: 3D, balcony seats, etc.
    calculate_price_modifiers(movie_duration_minutes, day_of_week, is_balcony_seats, is_3d)
  end

  def add_ticket(viewer_age, viewer_is_student)
    # save to our array of all tickets sold, for calculating group rates
    @tickets_sold.push([viewer_age, viewer_is_student])
  end

  def finish
    # fewer than 20 tickets sold? Regular rates apply
    if @tickets_sold.count < 20
      regular_rates(@tickets_sold)
    else
      # else calculate the group discount
      group_rates(@tickets_sold)
    end
  end

  private

  def calculate_price_modifiers(movie_minutes, day_of_week, is_balcony_seats, is_3d)
    if movie_minutes >= 120
      @price_modifiers = @price_modifiers + 1.50
    end

    if day_of_week == :thursday
      # if this is Thursday, we'll have to undo our discount in the case of a group sale
      @is_thursday = true
      @price_modifiers = @price_modifiers - 2.00
    end

    if day_of_week == :saturday || day_of_week == :sunday
      @price_modifiers = @price_modifiers + 1.50
    end

    if is_balcony_seats
      @price_modifiers += 2
    end

    if is_3d
      @price_modifiers += 3
    end
  end


  ##
  # Returns the total price of this group of tickets, no group rates apply
  # @return [Float]
  def regular_rates(tickets_sold)
    total = 0.0

    tickets_sold.each do |tickets|
      # the price per ticket is merely the base rate, plus any additional modifiers
      total += viewer_price(tickets[0], tickets[1]) + @price_modifiers
    end

    total
  end

  ##
  # Returns the total price of this group of tickets, group rates considered
  # @return [Float]
  def group_rates(tickets_sold)
    total = 0.0

    tickets_sold.each do |tickets|
      # the base ticket price is no more than $6 for group rates
      total += [viewer_price(tickets[0], tickets[1]), 6].min + @price_modifiers

      # Special Movie Day doesn't apply to group discounts
      # So add an extra $2 to back out the discount already applied in the @price_modifier
      if @is_thursday
        total += 2
      end
    end

    total
  end

  ##
  # Calculates a viewer's base ticket price
  def viewer_price(viewer_age, viewer_is_student)
    case viewer_age
    when 0...13
      5.50
    when 13...64
      if viewer_is_student
        8
      else
        11
      end
    when 65..999
      6
    else
      11
    end
  end

end

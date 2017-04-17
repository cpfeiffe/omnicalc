class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    text_split_into_array = @text.gsub(/[^a-z0-9\s]/i, "").downcase.split

    @word_count = text_split_into_array.length

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ", "").gsub("\n","").gsub("\r","").gsub("\t","").length

    @occurrences = text_split_into_array.count(@special_word.downcase)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = (((@apr/100/12) * (@principal)) / (1- (1+@apr/100/12)**(@years*-12)))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending-@starting
    @minutes = ((@ending-@starting)/60)
    @hours = (((@ending-@starting)/60)/60)
    @days = ((((@ending-@starting)/60)/60)/24)
    @weeks = (((((@ending-@starting)/60)/60)/24)/7)
    @years = ((((((@ending-@starting)/60)/60)/24)/7)/52)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    ascend = @numbers.sort

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = (@numbers.max) - (@numbers.min)



   if (@count % 2) != 0
        @median = (@count + 1) / 2.0
    else
      @median = ((ascend.length/2.0) + ((ascend.length + 2)/2.0) / 2.0)
    end

    @sum = @numbers.sum

    @mean = (@numbers.sum)/(@count)

    @somenumbers = []
    @variance = @numbers.each do |num|
      diff = num - @mean
      square = diff*diff
      @somenumbers.push(square)
    end
      @variance = (@somenumbers.sum)/@count


    @standard_deviation = @variance**0.5

    @mode = @numbers.mode

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end

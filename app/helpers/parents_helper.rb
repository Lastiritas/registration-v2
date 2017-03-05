module ParentsHelper
  # Return the date from the datetime field
  def getDate(datetime)
    datetime.to_date
  end

  # Return the date formatted to Month Day
  def getMonthDate(startDate, endDate)
    starting = getDate(startDate)
    ending = getDate(endDate)

    if starting.mon == ending.mon
      "#{starting.strftime("%b %d")} - #{ending.strftime("%d")}"
    else
      "#{starting.strftime("%b %d")} - #{ending.strftime("%b %d")}"
    end
  end
end

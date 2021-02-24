module EventsHelper
  def crop_title(event)
    shorten_title = ""
    count = 0

    event.title.each_char do |letter|
      if count < 14
        shorten_title << letter
        count += 1
      end
    end
    shorten_title = shorten_title + " [...]"
    return shorten_title
  end

  def crop_description(event)
    shorten_description = ""
    count = 0

    event.description.each_char do |letter|
      if count < 94
        shorten_description << letter
        count += 1
      end
    end
    shorten_description = shorten_description + " [...]"
    return shorten_description
  end

  def extend_description(event)
    number_of_spaces = 100 - event.description.length
    extended_description = event.description + " " * number_of_spaces
    return extended_description
  end
end

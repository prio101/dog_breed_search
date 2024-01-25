module HomesHelper
  # Format breed name for url with hyphens and makes it lowercase
  # example: "German Shepherd" => "german-shepherd"
  def breed_name_formatted(breed_name)
    breed_name.downcase.split.join('-')
  end
end

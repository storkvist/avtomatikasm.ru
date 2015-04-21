unless Rails.env.production?
  require 'inch/rake'

  Inch::Rake::Suggest.new
end

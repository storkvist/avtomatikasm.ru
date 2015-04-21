unless Rails.env.production?
  namespace :brakeman do
    desc 'Поиск уязвимостей с помощью Brakeman.'
    task :run, :output_files do |_, args|
      require 'brakeman'

      files = args[:output_files].split(' ') if args[:output_files]
      Brakeman.run app_path: '.', output_files: files, print_report: true
    end
  end
end

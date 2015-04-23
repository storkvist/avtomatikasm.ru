unless Rails.env.production?
  desc 'Выполнить проверку проекта: тестирование, уязвимости, метрики и стиль кода.'
  task check: :environment do
    Rake::Task['spec'].invoke
    Rake::Task['brakeman:run'].invoke
    Rake::Task['quality'].invoke
    Rake::Task['rubocop'].invoke
    Rake::Task['inch'].invoke
  end
end

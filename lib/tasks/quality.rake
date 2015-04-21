unless Rails.env.production?
  begin
    require 'cane/rake_task'

    desc 'Запуск Cane для анализа метрик кода'
    # Cane::RakeTask.new(:quality) do |cane|
    #   cane.abc_max = 10
    #   cane.add_threshold 'coverage/covered_percent', :>=, 99
    #   cane.no_style = true
    #   cane.abc_exclude = %w(Foo::Bar#some_method)
    # end
    Cane::RakeTask.new(:quality)

    task default: :quality
  rescue LoadError
    warn 'Cane не доступен, невозможно вычислить метрики кода.'
  end
end

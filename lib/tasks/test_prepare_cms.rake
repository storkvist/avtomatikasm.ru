if Rails.env.test?
  namespace :test do
    task :prepare do
      Rake::Task['db:setup'].invoke

      ENV['FROM'] = 'avtomatikasm'
      ENV['TO']   = 'avtomatikasm'

      Comfy::Cms::Site.create!(identifier: 'avtomatikasm', hostname: 'localhost:3000', locale: 'ru')

      Rake::Task['comfortable_mexican_sofa:fixtures:import'].invoke
    end
  end
end

namespace :app do


  desc "Import all goods from subtotal"
  task :import_all_goods => :environment do

    require File.join(Rails.root, "lib", "subtotal", "subtotal_integration.rb")
    SubtotalIntegration.new.import_all_goods

  end

end

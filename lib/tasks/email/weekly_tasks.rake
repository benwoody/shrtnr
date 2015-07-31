namespace :email do
  task :weekly_stats => :environment do
    User.all.find_each do |user|
      # testing!
      UserMailer.weekly_stats(user).deliver_now
    end
  end
end

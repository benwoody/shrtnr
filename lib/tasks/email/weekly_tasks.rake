namespace :email do
  task :weekly_stats => :environment do
    User.all.find_each do |user|
      UserMailer.weekly_stats(user).deliver_now
    end
  end
end

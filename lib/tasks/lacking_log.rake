namespace :lacking_log do
  desc 'datetimeが存在しないドキュメントにdatetimeを追加'
  task add_datetime: :environment do
    Log.all.map do |log|
      if log.datetime == nil
        log.update_attribute(:datetime, Time.at(log.raw_message[:ts].to_i))
      end
    end
  end
end

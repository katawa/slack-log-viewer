namespace :exported_log do
  desc 'Slack本家からエクスポートしたログをインポート -- usage: rake exported_log:import slack_log=#{log_dir} team_id=#{team_id}'
  task import: :environment do
    log_dir = SlackLogViewer::Importer::Importer::Log::LogDirectory.new(ENV['slack_log'])
    SlackLogViewer::Importer::Importer.load(log_dir)
  end
end

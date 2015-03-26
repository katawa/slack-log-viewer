namespace :exported_log do
  desc 'Slack本家からエクスポートしたログをインポート -- usage: rake exported_log:import slack_log=#{log_dir} team_id=#{team_id}'
  task import: :environment do
    SlackLogViewer::Importer::Importer.load(ENV['slack_log'])
  end
end

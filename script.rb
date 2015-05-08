#!/usr/bin/env ruby

def escape str
  str.gsub(/\"/, '\"').gsub(/\'/, %{'"'"'}).gsub(/\n/, "\\n")
end

def show_message title: nil, content: ''
  title_cmd = %{with title "#{escape(title)}"} if title
  cmd = %{osascript -e 'display notification "#{escape(content)}" #{title_cmd}'}
  puts cmd
  `#{cmd}`
end

timestamp = Time.new
drive_path = ARGV.first
log_path =  "/Users/yurokle/ws/kindle-notes-sync/sync.log"

content = []
content << "===== #{timestamp} ====="
content << __FILE__
content << drive_path
content << "------------------------"

File.open log_path, 'a' do |file|
  file.write content.join("\n")
  file.write "\n\n"
end

show_message title: 'Extremely important as fuck message', content: "We've done all the \"work\".\nSo you can drink beer."

class OSXNotification
  class << self
    def show title: nil, content: ''
      title_cmd = %{with title "#{bash_escape(title)}"} if title
      cmd = %{osascript -e 'display notification "#{bash_escape(content)}" #{title_cmd}'}
      `#{cmd}`
    end

    def bash_escape str
      str.gsub(/\"/, '\"').gsub(/\'/, %{'"'"'}).gsub(/\n/, "\\n")
    end
  end
end
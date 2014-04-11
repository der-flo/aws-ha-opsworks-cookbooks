node[:deploy].each do |app_name, deploy|

  template "#{deploy[:deploy_to]}/current/config.rb" do
    source "config.rb.erb"
    mode 0660
    group deploy[:group]

    if platform?("ubuntu")
      owner "www-data"
    elsif platform?("amazon")
      owner "apache"
    end

    variables redis_url: node[:redis_url]
    only_if do
      File.directory?("#{deploy[:deploy_to]}/current")
    end
  end
end

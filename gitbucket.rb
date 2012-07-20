#!/usr/bin/env ruby

require 'thor'
require 'github_api'

class App < Thor
  option :github_username, :required => true
  option :github_password, :required => true
  option :bitbucket_username, :required => true
  option :bitbucket_password, :required => true
  option :org

  desc "backup [Repository Name on GitHub]", "Choose one GitHub repository to backup in Bitbucket."
  def backup(repo_name=nil)
    puts "GitHub Username: #{options[:github_username]}" if options[:github_username]
    puts "GitHub Password: #{options[:github_password].gsub(/./, '*')}" if options[:github_password]
    puts "Bitbucket Username: #{options[:bitbucket_username]}" if options[:bitbucket_username]
    puts "Bitbucket Password: #{options[:bitbucket_password].gsub(/./, '*')}" if options[:bitbucket_password]

    puts "Choose to backup the repository \"#{repo_name}\" on GitHub" if repo_name

    github_username = options[:github_username]
    github_password = options[:github_password]
    bitbucket_username = options[:bitbucket_username]
    bitbucket_password = options[:bitbucket_password]
    org = options[:org]

    @github = Github.new :basic_auth => "#{github_username}:#{github_password}"

    unless repo_name
      puts "=="
      @github.repos.list(org: org).each do |repo|
        puts repo.name
      end
      puts "=="
      puts "Choose a repostory."
      exit -1
    end

    @github.repos.list(org: org).each do |repo|
      @source_repo = repo if repo.name == repo_name
    end

    unless @source_repo
      puts "There is no \"#{repo_name}\" repository."
      exit -1
    end

    source_repo_url = @source_repo.ssh_url
    # source_repo_url = @source_repo.clone_url

    source_repo_name = @source_repo.name
    source_repo_dir = @source_repo.name + '.git'

    puts "Backup processing..."

    output = %x[git clone --mirror #{source_repo_url} /tmp/#{source_repo_dir}]

    # Delete the previous backup repository in Bitbucket
    output = %x[curl -s -X DELETE -u #{bitbucket_username}:#{bitbucket_password} https://api.bitbucket.org/1.0/repositories/#{bitbucket_username}/#{source_repo_name.downcase}]

    # Create the backup repository in Bitbucket
    output = %x[curl -s -X POST -u #{bitbucket_username}:#{bitbucket_password} https://api.bitbucket.org/1.0/repositories/ -d name=#{source_repo_name} -d scm=git -d is_private=True]
    # Add remote from Bitbucket
    output = %x[git --git-dir=/tmp/#{source_repo_dir} remote add bitbucket https://#{bitbucket_username}:#{bitbucket_password}@bitbucket.org/#{bitbucket_username}/#{source_repo_name.downcase}]

    # Push the source repostory to Bitbucket with all branches, and tags
    output = %x[git --git-dir=/tmp/#{source_repo_dir} push bitbucket --all]

    # Delete the source repostory dir
    output = %x[rm -rf /tmp/#{source_repo_dir}]

    puts "Done."

  end

end

App.start(ARGV)

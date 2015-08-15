require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

set :domain, 'www.boyishwei.com'
set :user, 'ec2-user'
set :identity_file, '/Users/Ryan/aws/boyishwei.pem' 
set :deploy_to, '/home/ec2-user/blog'
set :repository, 'git@github.com:boyishwei/boyishwei-jekyll.git'
set :branch, 'master'

task :environment do
  invoke :'rvm:use[ruby-2.1.0@gemset_name]'
end 

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Preparations here
    invoke :'git:clone'
    invoke :'bundle:install'
    queue "ruby -v"
    #queue "jekyll -v"
    queue "bundle -v"
    #queue %{bundle exec jekyll build -s }
    #queue "#{bundle_prefix} jekyll build"
  end
end

task :restart do
  queue 'sudo service restart nginx'
end

# Rakefile
require 'rubygems'
require 'rake'
require 'echoe'
require 'lib/rockstar/version'

WEBSITE_PATH = 'jnunemaker@rubyforge.org:/var/www/gforge-projects/scrobbler'

Echoe.new('rockstar', Rockstar::Version) do |p|
  p.description     = "wrapper for audioscrobbler (last.fm) web services"
  p.url             = "http://github.com/bitboxer/rockstar"
  p.author          = ['John Nunemaker', 'Jonathan Rudenberg', 'Bodo Tasche']
  p.email           = "bodo@bitboxer.de"
  p.extra_deps      = [['hpricot', '>=0.4.86'], ['activesupport', '>=1.4.2']]
  p.need_tar_gz     = false
  p.docs_host       = WEBSITE_PATH
end

desc 'Preps the gem for a new release'
task :prepare do
  %w[manifest build_gemspec].each do |task|
    Rake::Task[task].invoke
  end
end

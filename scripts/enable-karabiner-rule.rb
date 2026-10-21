#!/usr/bin/ruby
require 'json'
require 'fileutils'
require 'tempfile'

asset = File.expand_path('../config/karabiner/complex_modifications/left-command-space-to-eisuu.json', __dir__)
config_path = File.join(ENV.fetch('XDG_CONFIG_HOME', File.join(Dir.home, '.config')), 'karabiner', 'karabiner.json')
original = File.exist?(config_path) ? File.read(config_path) : nil
config = original ? JSON.parse(original) : {}
profiles = config['profiles'] ||= []
if profiles.empty?
  profiles << { 'name' => 'Default profile', 'selected' => true }
end
profile = profiles.find { |entry| entry['selected'] }
abort 'No selected Karabiner profile; select a profile before running bootstrap.' unless profile
rules = (profile['complex_modifications'] ||= {})['rules'] ||= []
JSON.parse(File.read(asset)).fetch('rules').each do |rule|
  index = rules.index { |entry| entry['description'] == rule.fetch('description') }
  if index
    rules[index] = rule
  else
    rules << rule
  end
end
simple_asset = File.expand_path('../config/karabiner/simple_modifications.json', __dir__)
simple_modifications = profile['simple_modifications'] ||= []
JSON.parse(File.read(simple_asset)).each do |modification|
  index = simple_modifications.index { |entry| entry['from'] == modification.fetch('from') }
  if index
    simple_modifications[index] = modification
  else
    simple_modifications << modification
  end
end
if original && JSON.parse(original) == config
  puts 'Karabiner modifications already enabled.'
  exit
end

FileUtils.mkdir_p(File.dirname(config_path))
# Preserve the pre-bootstrap configuration before the first update.
backup = "#{config_path}.bootstrap-backup"
FileUtils.cp(config_path, backup) if original && !File.exist?(backup)
Tempfile.create(['.karabiner-', '.json'], File.dirname(config_path)) do |file|
  file.chmod(original ? File.stat(config_path).mode & 0777 : 0600)
  file.write(JSON.pretty_generate(config) + "\n")
  file.flush
  file.fsync
  File.rename(file.path, config_path)
end
puts "Enabled Karabiner modifications in #{profile.fetch('name')}."

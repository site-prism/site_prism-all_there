# frozen_string_literal: true

task :specs do
  system('bundle exec rspec') || raise('Specs failed')
end

task :cops do
  system('bundle exec rubocop') || raise('Cops failed')
end

task default: %i[specs cops]

# frozen_string_literal: true

require 'site_prism'
require 'capybara'

$LOAD_PATH << './lib'

require 'site_prism_at'

Capybara.default_max_wait_time = 0

class MyTestApp
  def call(_env)
    [200, { 'Content-Length' => '9' }, ['MyTestApp']]
  end
end

Capybara.app = MyTestApp.new

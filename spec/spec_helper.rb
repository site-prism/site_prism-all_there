# frozen_string_literal: true

$LOAD_PATH << './lib'

require 'site_prism/all_there'

class MyTestApp
  def call(_env)
    [200, { 'Content-Length' => '9' }, ['MyTestApp']]
  end
end

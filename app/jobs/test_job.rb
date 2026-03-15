class TestJob < ApplicationJob
  queue_as :default

  def perform
    puts "SIDEKIQ FUNCIONANDO!"
  end
end
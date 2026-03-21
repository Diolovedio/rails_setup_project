class TestJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info "Sidekiq funcionando!"
  end
end

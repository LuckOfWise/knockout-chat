class Comment < ActiveRecord::Base
  validates :name, presence: true
  validates :content, presence: true

  after_create :notify_pusher
  before_destroy :notify_destroy_pusher

  def self.channel
    'test'
  end

  private
  def notify_pusher
    action = 'create'
    data = { 'commentId' => self.id }
    logger.info "[Pusher] channel: #{Comment.channel} / action: #{action} / data: #{data.inspect}"
    Pusher[Comment.channel].trigger(action, data)
  end

  def notify_destroy_pusher
    action = 'destroy'
    data = { 'commentId' => self.id }
    logger.info "[Pusher] channel: #{Comment.channel} / action: #{action} / data: #{data.inspect}"
    Pusher[Comment.channel].trigger(action, data)
  end
end

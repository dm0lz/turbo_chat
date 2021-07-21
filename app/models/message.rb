# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  after_create_commit { broadcast_append_to 'messages' }
  after_update_commit { broadcast_replace_to 'messages' }
  after_destroy_commit { broadcast_remove_to 'messages' }

  validates :body, presence: true
end

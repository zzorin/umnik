class AddChatLinkToParticipants < ActiveRecord::Migration[6.0]
  def change
    add_column :participants, :chat_link, :string
  end
end

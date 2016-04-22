module UsersHelper
  def self_user? id
    current_user_id == id
  end
end

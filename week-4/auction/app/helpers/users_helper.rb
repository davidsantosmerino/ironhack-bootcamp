module UsersHelper
  def self_user? user_id
    current_user.id == user_id
  end
end

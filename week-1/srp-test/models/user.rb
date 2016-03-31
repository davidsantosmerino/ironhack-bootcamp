require "./models/user-login"
class User

  def login user, passwd
    UserLogin.check user, passwd
  end

end

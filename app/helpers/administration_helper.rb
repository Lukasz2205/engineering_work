module AdministrationHelper
  def block_information(status)
    status == false ? 'Brak' : 'Zablokowany'
  end

  def user_role(role)
    role == 'admin' ? 'Administrator' : 'Użytkownik'
  end
end
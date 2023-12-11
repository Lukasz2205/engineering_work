module AdministrationHelper
  def block_information(status)
    status == false ? 'Brak' : 'Zablokowany'
  end
end
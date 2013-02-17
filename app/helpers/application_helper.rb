module ApplicationHelper

  def format_address(obj)
    address = ""

    if obj.city && !obj.city.empty?
      address << obj.city
    end

    if obj.state && !obj.state.empty?
      address << ", " unless address == ""
      address << obj.state
    end

    if obj.zip_code && !obj.zip_code.empty?
      address << ", " unless address == ""
      address << obj.zip_code
    end

    address
  end

end

module FamiliesHelper

  def family_roles
    [["Père", :father], ["Mère", :mother], ["Enfant", :child]]
  end

  def families_options
    options = []

    options << ["Créer une famille (en utilisant le nom de famille)", :new_family]
    options << ["--"]
    Family.order('name ASC').each do |f|
      text = f.name
      unless f.full_address.blank?
        text += " (#{f.full_address})"
      end
      options << [text, f.id]
    end
    options
  end

end

module FamiliesHelper

  def family_roles
    [["Père", :father], ["Mère", :mother], ["Enfant", :child]]
  end

  def families_options
    options = []

    options << ["Créer une famille (en utilisant le nom de famille)", :new_family]
    options << ["--"]
    Family.order('name ASC').each do |f|
      options << ["#{f.name} - #{f.full_address}", f.id]
    end
    options
  end

end

class SeedStructureService

  def self.call(structure_id)
    #FIRST USER IS ADMIN
    structure = Structure.find structure_id
    user = structure.users.first
    user.add_role :admin, structure

    # SOME DEFAULT CATEGORIES
    Category.create(name: 'Contact', structure_id: structure_id)
    Category.create(name: 'Fidèle', structure_id: structure_id)
    Category.create(name: 'Visiteur régulier', structure_id: structure_id)
    first_category = Category.create(name: 'Membre', structure_id: structure_id)

    #FIRST USER IS MEMBER TOO
    member = Member.new(firstname: user.firstname, lastname: user.lastname, email: user.email, structure_id: structure.id, user_id: user.id, cgu: true, gender: :nil)
    member.categories << first_category
    member.save

  end

end

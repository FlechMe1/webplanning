class App::Settings::MembersController < AppController

  def index
    @categories = @structure.categories.order(name: :asc)
    @category = @structure.categories.build
  end



end
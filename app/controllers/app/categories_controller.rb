class App::CategoriesController < AppController

  def destroy
    Category.destroy(params[:id])
    redirect_back fallback_location: '/', alert: {success: 'Catégorie supprimée'}
  end

  def create
    Category.create(category_params)
    redirect_back fallback_location: app_settings_members_path, alert: {success: 'Catégorie créé'}
  end

  private
    def category_params
      params.required(:category).permit(:name, :structure_id)
    end
end
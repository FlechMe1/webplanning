module MembersHelper

  def categories_options
    [["Contact", :contact], ["Visiteur régulier", :regular], ["Fidèle", :devoted], ["Adhérent", :adherent]]
  end

  def expired_at_in_words expired_at
    if expired_at > Date.today
      "Dans #{distance_of_time_in_words_to_now(expired_at)}"
    else
      "il y a #{distance_of_time_in_words_to_now(expired_at)}"
    end
  end

end

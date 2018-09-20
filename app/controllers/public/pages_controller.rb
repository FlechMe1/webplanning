class Public::PagesController < ApplicationController

  layout 'public'

  def home
    @member = Member.new
    @member.build_sibling
  end

end

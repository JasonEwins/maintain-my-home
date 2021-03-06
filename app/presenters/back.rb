class Back
  def initialize(controller_name:, routes: Rails.application.routes)
    @controller_name = controller_name
    @helpers = ActionController::Base.helpers
    @routes = routes
  end

  def link
    @helpers.link_to text, @routes.path_for(controller: @controller_name)
  end

  private

  def text
    I18n.t 'back_links.prefix', page_description: page_description
  end

  def page_description
    I18n.t @controller_name, scope: :back_links
  end
end

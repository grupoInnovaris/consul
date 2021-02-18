class SDGManagement::WebSections::CardsController < SDGManagement::BaseController
  include Admin::Widget::CardsActions
  helper_method :index_path

  load_and_authorize_resource :web_section, class: "::WebSection"
  load_and_authorize_resource :card, through: :web_section, class: "::Widget::Card"

  private

    def index_path
      sdg_management_homepage_path
    end
end

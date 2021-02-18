class SDGManagement::HomepageController < SDGManagement::BaseController
  def show
    @phases = SDG::Phase.accessible_by(current_ability).order(:kind)
    @cards = ::WebSection.find_by!(name: "sdg").cards
  end
end

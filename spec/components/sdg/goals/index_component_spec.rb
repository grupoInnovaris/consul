require "rails_helper"

describe SDG::Goals::IndexComponent, type: :component do
  let!(:goals) { SDG::Goal.all }
  let!(:phases) { SDG::Phase.all }
  let!(:component) { SDG::Goals::IndexComponent.new(goals, phases, nil) }

  before do
    Setting["feature.sdg"] = true
  end

  describe "renders a heading" do
    it "render static header" do
      render_inline component

      expect(page).to have_css "h1", exact_text: "Sustainable Development Goals"
    end

    it "render a custom header" do
      sdg_web_section = WebSection.find_by!(name: "sdg")
      header = create(:widget_card, cardable: sdg_web_section)
      component = SDG::Goals::IndexComponent.new(goals, phases, header)

      render_inline component

      expect(page).to have_content header.title
      expect(page).not_to have_css "h1", exact_text: "Sustainable Development Goals"
    end
  end

  it "renders phases" do
    render_inline component

    expect(page).to have_content "Sensitization"
    expect(page).to have_content "Planning"
    expect(page).to have_content "Monitoring"
  end
end

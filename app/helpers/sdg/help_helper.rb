module SDG::HelpHelper
  def is_active?(goal)
    "is-active" if goal.code == 1
  end
end

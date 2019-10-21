def navigation_menu
  presenter = Neuralle::Pages::MenuPresenter.new(refinery_menu_pages, self)
  presenter.dom_id = 'main-nav-menu'
  presenter.css = ""
  presenter.list_tag_css = 'navbar-nav'
  presenter.menu_tag = :div
  presenter.active_css = 'active'
  presenter.selected_css = 'active'
  presenter.first_css = ""
  presenter.last_css = ""
  presenter.max_depth = 0 # prevents dropdown menus, which don't render correctly
  presenter
end

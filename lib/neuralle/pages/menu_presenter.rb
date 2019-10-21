module Neuralle
  module Pages
    class MenuPresenter < Refinery::Pages::MenuPresenter

      private

      def render_menu_item_link(menu_item)
        title = menu_item.title
        link_to(title, context.refinery.url_for(menu_item.url), :class => link_tag_css)
      end

      def image_for_menu_item(title)
        case title.downcase.strip
        when 'our cause'
          'cause'
        when 'our services'
          'services'
        when 'our voice'
          'blog'
        else
          title.underscore.split.join('_')
        end
      end

    end
  end
end

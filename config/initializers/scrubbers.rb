Rails::Html::PermitScrubber.class_eval do

  protected

  def scrub_attributes(node)
    if @attributes
      node.attribute_nodes.each do |attr|
        attr.remove if scrub_attribute?(attr.name)
        scrub_attribute(node, attr)
      end

      # scrub_css_attribute(node)
    else
      Loofah::HTML5::Scrub.scrub_attributes(node)
    end
    node
  end

end

Loofah::HTML5::WhiteList::ALLOWED_ELEMENTS_WITH_LIBXML2.merge %w(iframe)
Loofah::HTML5::WhiteList::ALLOWED_ATTRIBUTES.merge %w(onclick)

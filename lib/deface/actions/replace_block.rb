module Deface
  module Actions
    class ReplaceBlock < ElementAction
      def execute(target_range)
        block_element = target_range.first.attr('id')
        add_erb_variable(source_element, 'block_name', block_element)
        default_text = target_range.first.attr('default-text')
        add_erb_variable(source_element, 'default_text', default_text)
        target_range.first.before(source_element)
        target_range.map(&:remove)
      end

      def range_compatible?
        true
      end

      def add_erb_variable(parent, name, value)
        erb_variable = Nokogiri::XML::Node.new("erb", parent)
        erb_variable['silent'] = ''
        erb_variable.content = "#{name} = '#{value}'"
        parent.children.first.add_previous_sibling(erb_variable)
      end
    end
  end
end
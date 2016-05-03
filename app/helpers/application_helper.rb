require 'pp'

module ApplicationHelper
  def pp_item (obj)
    '<pre>' +
        h(obj.pretty_inspect) +
    '</pre>'
  end
end

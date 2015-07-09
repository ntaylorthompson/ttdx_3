module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Ttdx3"
    end
  end
end

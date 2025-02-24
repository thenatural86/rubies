sig do
    params(value: T.nilable(T.any(String, Numeric, Axlsx::RichText)), units: T.nilable(String),
      time: T.nilable(String), column_name: Symbol).returns(T.nilable(T.any(String, Numeric, Axlsx::RichText)))
  end
  def format_row_data_values(value, units, time, column_name)
    return nil unless value
    return value if units.nil?

    if value.is_a?(String)
      unit_display = [Vts.t("views.units_label.#{units}.squared"), time].compact.join('/')
      if unit_display.present? && column_name == :size
        value += " #{unit_display}"
      elsif unit_display.present?
        value += "/#{unit_display}"
      end
    end
    value
  end

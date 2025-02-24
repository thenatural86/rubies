

sig { params(units: T.nilable(String), currency: T.nilable(String), time: T.nilable(String)).returns(String) }
def display_units(units, currency = nil, time = nil)
  return '' unless units

  unit_components = [currency, Vts.t("views.units_label.#{units}.squared")]
  unit_components << time unless time.nil? || time.empty?

  "(#{unit_components.compact.join('/')})"
end

sig { params(value: T.nilable(T.any(Numeric, BigDecimal, Integer, Float)), currency: String, _column_name: Symbol, time: T.nilable(String)).returns(String) }
def display_value(value, currency, _column_name, time)
  formatted_value = Localization.format_currency(value, currency_code: currency)

  return T.must(formatted_value) unless time

  formatted_value.gsub(/^(-)?(\$|€)/, '\1')
end

sig { params(value: T.nilable(String), units: T.nilable(String), currency: T.nilable(String), time: T.nilable(String)).returns(T.any(String, NilClass)) }
def display_value_and_currency(value, units, currency, time = nil)
  return nil unless value
  return value if currency.nil?

  formatted_value = T.must(value).gsub(/^(-)?(\$|€)/, '\1')
  unit_display = display_units(units, currency, time ? "yr" : nil)

  "#{formatted_value} #{unit_display}"
end

sig { params(value: T.nilable(T.any(Numeric, BigDecimal, Integer, Float, Axlsx::RichText)), currency: T.nilable(String), units: T.nilable(String), column_name: Symbol, time: T.nilable(String)).returns(T.any(String, NilClass)) }
def display_currency_or_units(value, currency, units, column_name, time)
  return if value.is_a?(Axlsx::RichText)

  unit_display = display_units(units, currency, time)

  return "#{number_with_delimiter(value.to_i)} #{unit_display}" if currency.nil?
  return "#{format('%.2f', value)} #{unit_display}" if value == 0

  "#{display_value(value, currency, column_name, time)} #{unit_display}"
end

sig { params(value: T.nilable(T.any(Numeric, BigDecimal, Integer, Float, String, Axlsx::RichText)), units: T.nilable(String), currency: T.nilable(String), time: T.nilable(String), column_name: Symbol).returns(T.nilable(T.any(Numeric, BigDecimal, Integer, Float, String, Axlsx::RichText))) }
def row_data_values(value, units, currency, time, column_name)
  return nil unless value

  if value.is_a?(String)
    display_value_and_currency(value, units, currency, time)
  elsif currency || units
    display_currency_or_units(value, currency, units, column_name, time)
  else
    value
  end
end

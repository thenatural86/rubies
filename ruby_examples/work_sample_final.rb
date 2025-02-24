sig { params(units: T.nilable(String), _column_name: Symbol, currency: T.nilable(String), time: T.nilable(String)).returns(String) }
  def display_units(units, _column_name, currency = nil, time = nil)
    return '' unless units
    unit_display = time == '' ? [currency, Vts.t("views.units_label.#{units}.squared")].compact.join('/') : [currency, Vts.t("views.units_label.#{units}.squared"), time].compact.join('/')
    "(#{unit_display})"
  end

sig { params(value: T.nilable(T.any(Numeric, BigDecimal, Integer, Float)), currency: String, _column_name: Symbol, time: T.nilable(String)).returns(String) }
  def display_value(value, currency, _column_name, time)
    time_value_to_display = T.must(Localization.format_currency(value, currency_code: currency)).gsub!(/^(-)?(\$|€)/, '\1')
    value_to_display = time ? time_value_to_display : Localization.format_currency(value, currency_code: currency)
    T.must(value_to_display)
  end

  sig { params(value: T.nilable(String), units: T.nilable(String), currency: T.nilable(String), _column_name: Symbol, time: T.nilable(String)).returns(T.any(String, NilClass)) }
  def display_value_and_currency(value, units, currency, _column_name, time = nil)
    return nil unless value
    return value if currency.nil?
    if time
      "#{T.must(value).gsub!(/^(-)?(\$|€)/, '\1')} (#{currency}/#{Vts.t("views.units_label.#{units}.squared")}/yr)"
    elsif units
      "#{T.must(value).gsub!(/^(-)?(\$|€)/, '\1')} (#{currency}/#{Vts.t("views.units_label.#{units}.squared")})"
    else
      value
    end
  end


  sig { params(value: T.nilable(T.any(Numeric, BigDecimal, Integer, Float, Axlsx::RichText)), currency: T.nilable(String), units: T.nilable(String), column_name: Symbol, time: T.nilable(String)).returns(T.any(String, NilClass)) }
  def display_currency_or_units(value, currency, units, column_name, time)
    # :size
    return if value.is_a?(Axlsx::RichText)
    return "#{number_with_delimiter(value.to_i)} #{display_units(units, column_name, currency, time)}" if currency.nil?
    # :remaining_lease_obligation, :total_other_income,
    return "#{value}.00 #{display_units(units, column_name, currency, time)}" if value == 0
    # :total_other_income, :total_recoveries, :remaining_lease_obligation
    "#{display_value(value, currency, column_name, time)} #{display_units(units, column_name, currency, time)}"
  end

  sig { params(value: T.nilable(T.any(Numeric, BigDecimal, Integer, Float, String, Axlsx::RichText)), units: T.nilable(String), currency: T.nilable(String), time: T.nilable(String), column_name: Symbol).returns((T.nilable(T.any(Numeric, BigDecimal, Integer, Float, String, Axlsx::RichText)))) }
  def row_data_values(value, units, currency, time, column_name)
    return nil unless value
    if value.is_a?(String)

      # :ti, :gross_rent, :ner, :concessions_sqft, :concessions_sqft_year,
      display_value_and_currency(value, units, currency, column_name, time)
    elsif currency || units

      # :total_recoveries,:total_other_income, :remaining_lease_obligation, :npv, :npv_per_sf, :size
      display_currency_or_units(value, currency, units, column_name, time)
    else

      value
    end
  end

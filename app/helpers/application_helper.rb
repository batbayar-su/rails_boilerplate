module ApplicationHelper
  # normal translation action override
  def t(lng, options = {})
    I18n.t(lng, options)
  end

  # load activerecord translations
  def t2(lng, options = {})
    I18n.t("activerecord.attributes.#{lng}", options)
  end
end

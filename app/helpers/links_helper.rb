module LinksHelper

  def full_url(link)
    #Changed so I can use this in rspec
    I18n.t('domain') + link.short_url
  end

  def complete_url(link)
    "http://" + full_url(link)
  end
end

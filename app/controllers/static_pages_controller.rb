class StaticPagesController < ApplicationController

  def about_us
  	@aboutus = StaticPage.where(:page_name => 'about_us').first
  end

  def pricing
  	@pricing = StaticPage.where(:page_name => 'pricing').first
  end

  def colleges
  	@colleges = StaticPage.where(:page_name => 'colleges').first
  end

  def contactus
  	@contactus = StaticPage.where(:page_name => 'contact_us').first
  end

  def privacypolicy
  	@privacy_policy = StaticPage.where(:page_name => 'privacy_policy').first
  end

  def termsofuse
  	@termsofuse = StaticPage.where(:page_name => 'terms_of_use').first
  end
  
end

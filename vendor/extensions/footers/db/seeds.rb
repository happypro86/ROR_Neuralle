Refinery::I18n.frontend_locales.each do |lang|
  I18n.locale = lang

  Refinery::User.find_each do |user|
    user.plugins.where(name: 'refinerycms-footers').first_or_create!(
      position: (user.plugins.maximum(:position) || -1) +1
    )
  end if defined?(Refinery::User)


  def find_or_create(attrs)
    existing_footer = Refinery::Footers::Footer.where(:title => attrs[:title]).first
    Refinery::Footers::Footer.create!(attrs) unless existing_footer
  end

  find_or_create(
    :title      => 'Home',
    :text       => 'Home',
    :link       => '/',
    :placement  => 'left'
  )

  find_or_create(
    :title      => 'Newsletter',
    :text       => 'Newsletter',
    :link       => '/signup',
    :placement  => 'left'
  )

  find_or_create(
    :title      => 'Twitter link',
    :icon       => 'twitter',
    :link       => 'https://twitter.com/michaelides_j',
    :placement  => 'right'
  )

  find_or_create(
    :title      => 'LinkedIn link',
    :icon       => 'linkedin-square',
    :link       => 'http://www.linkedin.com/profile/view?id=52864472&trk=nav_responsive_tab_profile_pic',
    :placement  => 'right'
  )

  find_or_create(
    :title      => 'AngelList link',
    :icon       => 'angellist',
    :link       => 'https://angel.co/jordan-michaelides',
    :placement  => 'right'
  )

end

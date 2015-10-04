class CardsMailer < ActionMailer::Base
  default from: ENV['DEFAULT_EMAIL_FROM_CARDS']

  def pending_cards_notification(email)
    mail(to: email, subject: t('mailers.cards.pending_cards.subject'))
  end
end

class UserMailer < ApplicationMailer
  default from: "orane@yopmail.com"

  def welcome_email(user)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url = "http://monsite.fr/login"

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: "Bienvenue chez EventBrite(bis) !")
  end

  def attendance_notif_email(attendance)
    @event = attendance.event
    @host = @event.host

    mail(to: @host.email, subject: "Il y a un nouveau participant à votre évènement #{@event.title}")
  end
end

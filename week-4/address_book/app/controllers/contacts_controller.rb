class ContactsController < ApplicationController

  def index
    @notice = params[:notice]
    @contacts = Contact.order(name: :asc)
    render "index"
  end

  def new
    @notice = params[:notice]
    @contact = Contact.new
    render "new"
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to action: 'index'
    else
      errors = @contact.errors.full_messages
      redirect_to action: 'new', notice: errors
    end
  end

  def contact_params
    params.require(:contact).permit(:name,:address,:phone,:email,:avatar)
  end

  def search
    @query = params[:search][:q]
    @contacts = Contact.where("name LIKE ?", @query+"%").order(name: :asc)
    render "search"
  end

  def mark_as_fav
    id = params[:id]
    contact = Contact.find_by(id: id)
    contact.fav = contact.fav.nil? ? true : !contact.fav
    if contact.save
      notice = "#{contact.name} is a fav contact now"
    else
      notice = "Oops, something went wrong..."
    end
    redirect_to action: 'index', notice: notice
  end

end

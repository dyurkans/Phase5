class TournamentsController < ApplicationController

  def index
    @events = Tournament.alphabetical.paginate(:page => params[:page]).per_page(8)
    @inactive_events = Tournament.inactive.alphabetical.paginate(:page => params[:page]).per_page(8)
  end

  def show
    @Tournament = Tournament.find(params[:id])
  end
  
  def new
    @Tournament = Tournament.new
  end

  def edit
    @Tournament = Tournament.find(params[:id])
  end

  def create
    @Tournament = Tournament.new(params[:Tournament])
    if @Tournament.save
      # if saved to database
      flash[:notice] = "Successfully created #{@Tournament.name}."
      redirect_to @Tournament # go to show Tournament page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end

  def update
    @Tournament = Tournament.find(params[:id])
    if @Tournament.update_attributes(params[:Tournament])
      flash[:notice] = "Successfully updated #{@Tournament.name}."
      redirect_to @Tournament
    else
      render :action => 'edit'
    end
  end

  def destroy
    @Tournament = Tournament.find(params[:id])
    @Tournament.destroy
    flash[:notice] = "Successfully removed #{@Tournament.name} from karate tournament system"
    redirect_to events_url
  end
end

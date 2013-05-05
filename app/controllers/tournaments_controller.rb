class TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.alphabetical.paginate(:page => params[:page]).per_page(8)
    @inactive_tournaments= Tournament.inactive.alphabetical.paginate(:page => params[:page]).per_page(8)

  end

  def show
    @tournament = Tournament.find(params[:id])
    @tournament_students = @tournament.students.alphabetical.paginate(:page => params[:page]).per_page(8)
    @tournament_sections = @tournament.sections.alphabetical.paginate(:page => params[:page]).per_page(8)
  end
  
  def new
    @tournament = Tournament.new
  end

  def edit
    @tournament = Tournament.find(params[:id])
  end

  def create
    @tournament = Tournament.new(params[:tournament])
    if @tournament.save
      # if saved to database
      flash[:notice] = "Successfully created #{@tournament.name}."
      redirect_to @tournament # go to show Tournament page
    else
      # return to the 'new' form
      flash[:notice] = "Unable to create #{@tournament.name}."
      render :action => 'new'
    end
  end

  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update_attributes(params[:tournament])
      flash[:notice] = "Successfully updated #{@tournament.name}."
      redirect_to @tournament
    else
   	  flash[:notice] = "Unable to update #{@tournament.name}."
      render :action => 'edit'
    end
  end

  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.destroy
    flash[:notice] = "Successfully removed #{@tournament.name} from karate tournament system"
    redirect_to tournaments_url
  end
end
